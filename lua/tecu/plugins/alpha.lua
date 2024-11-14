return {
	"goolord/alpha-nvim",
	dependencies = { "echasnovski/mini.icons", "nvim-lua/plenary.nvim" },
	config = function()
		local alpha = require("alpha")

		local dashboard = require("alpha.themes.dashboard")
		dashboard.section.header.val = {
			"                                                    ",
			" ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗ ",
			" ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║ ",
			" ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║ ",
			" ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║ ",
			" ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║ ",
			" ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝ ",
		}

		dashboard.section.buttons.val = {
			dashboard.button("p", "  Search projects", ":Telescope projects<CR>"),
			dashboard.button("f", "  Find file", ":Telescope find_files <CR>"),
			dashboard.button("b", "  File Browser", ":Telescope file_browser <CR>"),
			dashboard.button("t", "  Find text", ":Telescope live_grep <CR>"),
			dashboard.button("r", "  Recent files", ":Telescope oldfiles <CR>"),
			dashboard.button(
				"c",
				"  Configuration",
				":lua require('telescope.builtin').find_files({cwd = '~/.config/nvim/' })<CR>"
			),
			dashboard.button("u", "  Update plugins", ":PackerSync<CR>"),
			dashboard.button("q", "   Quit", ":qa<CR>"),
		}

		for _, button in ipairs(dashboard.section.buttons.val) do
			button.opts.hl = "AlphaButtons"
			button.opts.hl_shortcut = "AlphaShortcut"
		end

		local function footer()
			-- Number of plugins
			local total_plugins = require("lazy").stats().count
			local datetime = os.date("%d-%m-%Y %H:%M:%S")
			local plugins_text = "   "
				.. total_plugins
				.. " plugins"
				.. " v"
				.. vim.version().major
				.. "."
				.. vim.version().minor
				.. "."
				.. vim.version().patch
				.. "   "
				.. datetime

			-- Quote
			local fortune = require("alpha.fortune")
			local quote = table.concat(fortune(), "\n")

			return plugins_text .. "\n" .. quote
		end

		dashboard.section.footer.val = footer()

		dashboard.section.header.opts.hl = "AlphaHeader"
		dashboard.section.buttons.opts.hl = "AlphaButtons"
		dashboard.section.footer.opts.hl = "AlphaFooter"

		dashboard.opts.opts.noautocmd = true
		alpha.setup(dashboard.opts)
	end,
}
