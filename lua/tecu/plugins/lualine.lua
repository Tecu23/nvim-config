return {
	"nvim-lualine/lualine.nvim",
	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},
	enabled = true,
	event = { "BufReadPost", "BufAdd", "BufNewFile" },
	config = function()
		local icon = require("tecu.ui.icons")
		local lualine = require("lualine")

		-- Color table for highlights
		local colors = {
			bg = "none",
			fg = "#bbc2cf",
			yellow = "#ECBE7B",
			cyan = "#008080",
			darkblue = "#081633",
			green = "#98be65",
			orange = "#FF8800",
			violet = "#a9a1e1",
			magenta = "#c678dd",
			blue = "#51afef",
			red = "#ec5f67",
		}

		-- Conditions table:
		--		buffer_not_empty: Is there a file opened
		local conditions = {
			buffer_not_empty = function()
				return vim.fn.empty(vim.fn.expand("%:t")) ~= 1
			end,
		}
		local left_margin = {
			function()
				return "▊"
			end,
			color = { fg = colors.blue }, -- Sets highlighting of component
			padding = { left = 0, right = 1 }, -- We don't need space before this
		}

		local right_margin = {
			function()
				return "▊"
			end,
			color = { fg = colors.blue },
			padding = { left = 1 },
		}

		local mode = {
			function()
				local mode_icon = "" -- Icon for the mode
				local mode_names = {
					n = "NORMAL",
					i = "INSERT",
					v = "VISUAL",
					[""] = "VISUAL",
					V = "VISUAL",
					c = "COMMAND",
					no = "NORMAL",
					s = "SELECT",
					S = "SELECT",
					[""] = "SELECT",
					ic = "INSERT",
					R = "REPLACE",
					Rv = "REPLACE",
					cv = "COMMAND",
					ce = "COMMAND",
					r = "HIT-ENTER",
					rm = "MORE",
					["r?"] = "CONFIRM",
					["!"] = "SHELL",
					t = "TERMINAL",
				}
				-- Get the mode name based on vim.fn.mode()
				local current_mode = vim.fn.mode()
				local mode_text = mode_names[current_mode] or "UNKNOWN" -- Default to "UNKNOWN" if mode is not in table
				return string.format("%s %s", mode_icon, mode_text) -- Return icon and mode name
			end,
			color = function()
				-- auto change color according to neovims mode
				local mode_color = {
					n = colors.red,
					i = colors.green,
					v = colors.blue,
					[""] = colors.blue,
					V = colors.blue,
					c = colors.magenta,
					no = colors.red,
					s = colors.orange,
					S = colors.orange,
					[""] = colors.orange,
					ic = colors.yellow,
					R = colors.violet,
					Rv = colors.violet,
					cv = colors.red,
					ce = colors.red,
					r = colors.cyan,
					rm = colors.cyan,
					["r?"] = colors.cyan,
					["!"] = colors.red,
					t = colors.red,
				}
				local current_mode = vim.fn.mode()
				return { fg = mode_color[current_mode] or "#ffffff" }
			end,
			padding = { right = 1 },
		}

		local filename = {
			"filename",
			cond = conditions.buffer_not_empty,
			color = { fg = colors.magenta, gui = "bold" },
		}

		local lsp = {
			"lsp",
			-- Lsp server name .
			function()
				local msg = "No Active Lsp"
				local buf_ft = vim.api.nvim_buf_get_option(0, "filetype")
				local clients = vim.lsp.get_clients()
				if next(clients) == nil then
					return msg
				end
				for _, client in ipairs(clients) do
					local filetypes = client.config.filetypes
					if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
						return client.name
					end
				end
				return msg
			end,
			icon = " LSP:",
			color = { fg = "#ffffff", gui = "bold" },
		}

		local diagnostics = {
			"diagnostics",
			sources = { "nvim_diagnostic" },
			sections = { "error", "warn", "info", "hint" },
			symbols = {
				error = icon.diagnostics.Error,
				hint = icon.diagnostics.Hint,
				info = icon.diagnostics.Info,
				warn = icon.diagnostics.Warning,
			},
			colored = true,
			update_in_insert = false,
			always_visible = false,
		}

		local diff = {
			"diff",
			source = function()
				local gitsigns = vim.b.gitsigns_status_dict
				if gitsigns then
					return {
						added = gitsigns.added,
						modified = gitsigns.changed,
						removed = gitsigns.removed,
					}
				end
			end,
			symbols = {
				added = icon.git.LineAdded .. " ",
				modified = icon.git.LineModified .. " ",
				removed = icon.git.LineRemoved .. " ",
			},
			colored = true,
			always_visible = false,
		}

		local git = {
			"branch",
			icon = "",
			color = { fg = colors.violet, gui = "bold" },
		}

		-- Config
		local config = {
			options = {
				-- Disable sections and component separators
				component_separators = "",
				section_separators = "",
				theme = {
					normal = { c = { fg = colors.fg, bg = colors.bg } },
					inactive = { c = { fg = colors.fg, bg = colors.bg } },
				},
			},
			sections = {
				lualine_a = { left_margin },
				lualine_b = {},
				lualine_c = { mode, filename },
				lualine_x = { lsp },
				lualine_y = { diagnostics, diff },
				lualine_z = { git, right_margin },
			},
			inactive_sections = {
				-- these are to remove the defaults
				lualine_a = {},
				lualine_b = {},
				lualine_y = {},
				lualine_z = {},
				lualine_c = {},
				lualine_x = {},
			},
		}

		-- Lualine Initialization with the new settings
		lualine.setup(config)
	end,
}
