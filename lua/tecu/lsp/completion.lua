-- ============================================================================
-- Neovim Completion Configuration (nvim-cmp)
-- ============================================================================

local M = {}

function M.setup()
	local cmp = require("cmp")
	local luasnip = require("luasnip")
	local lspkind = require("lspkind")

	-- ============================================================================
	-- Helper Functions
	-- ============================================================================

	local has_words_before = function()
		local line, col = unpack(vim.api.nvim_win_get_cursor(0))
		return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
	end

	-- ============================================================================
	-- Setup nvim-cmp
	-- ============================================================================

	cmp.setup({
		-- Snippet configuration
		snippet = {
			expand = function(args)
				luasnip.lsp_expand(args.body)
			end,
		},

		-- Window appearance
		window = {
			completion = cmp.config.window.bordered({
				winhighlight = "Normal:Normal,FloatBorder:BorderBG,CursorLine:PmenuSel,Search:None",
			}),
			documentation = cmp.config.window.bordered({
				winhighlight = "Normal:Normal,FloatBorder:BorderBG,Search:None",
			}),
		},

		-- Experimental features
		experimental = {
			ghost_text = {
				hl_group = "LspCodeLens",
			},
		},

		-- Formatting
		formatting = {
			format = lspkind.cmp_format({
				mode = "symbol_text",
				maxwidth = 50,
				ellipsis_char = "...",
				show_labelDetails = true,

				-- Custom formatting
				before = function(entry, vim_item)
					-- Add source name
					vim_item.menu = ({
						nvim_lsp = "[LSP]",
						nvim_lua = "[Lua]",
						luasnip = "[Snippet]",
						buffer = "[Buffer]",
						path = "[Path]",
						emoji = "[Emoji]",
						copilot = "[Copilot]",
						crates = "[Crates]",
						npm = "[NPM]",
					})[entry.source.name]

					-- Truncate long items
					local content = vim_item.abbr
					if #content > 50 then
						vim_item.abbr = vim.fn.strcharpart(content, 0, 47) .. "..."
					end

					return vim_item
				end,
			}),
		},

		-- Key mappings
		mapping = cmp.mapping.preset.insert({
			-- Navigation
			["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
			["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
			["<C-u>"] = cmp.mapping.scroll_docs(-4),
			["<C-d>"] = cmp.mapping.scroll_docs(4),
			["<C-Space>"] = cmp.mapping.complete(),
			["<C-e>"] = cmp.mapping.abort(),

			-- Confirm selection
			["<CR>"] = cmp.mapping.confirm({
				behavior = cmp.ConfirmBehavior.Replace,
				select = false, -- Don't select first item automatically
			}),

			-- Tab completion
			["<Tab>"] = cmp.mapping(function(fallback)
				if cmp.visible() then
					cmp.select_next_item()
				elseif luasnip.expand_or_jumpable() then
					luasnip.expand_or_jump()
				elseif has_words_before() then
					cmp.complete()
				else
					fallback()
				end
			end, { "i", "s" }),

			["<S-Tab>"] = cmp.mapping(function(fallback)
				if cmp.visible() then
					cmp.select_prev_item()
				elseif luasnip.jumpable(-1) then
					luasnip.jump(-1)
				else
					fallback()
				end
			end, { "i", "s" }),
		}),

		-- Sources priority and configuration
		sources = cmp.config.sources({
			-- Group 1: Primary sources (high priority)
			{
				{ name = "nvim_lsp", priority = 900 },
				{ name = "nvim_lsp_signature_help", priority = 850 },
				{ name = "luasnip", priority = 800 },
			},

			-- Group 2: Secondary sources
			{
				{ name = "nvim_lua", priority = 700 },
				{ name = "path", priority = 600 },
				{ name = "emoji", priority = 300 },
			},
			-- Group 3: Fallback sources (low priority)
			{
				{
					name = "buffer",
					priority = 500,
					option = {
						get_bufnrs = function()
							-- Use all visible buffers
							local bufs = {}
							for _, win in ipairs(vim.api.nvim_list_wins()) do
								bufs[vim.api.nvim_win_get_buf(win)] = true
							end
							return vim.tbl_keys(bufs)
						end,
					},
				},
				{
					name = "fuzzy_buffer",
					priority = 400,
					option = {
						get_bufnrs = function()
							return vim.api.nvim_list_bufs()
						end,
					},
				},
			},
		}),

		-- Sorting
		sorting = {
			priority_weight = 2,
			comparators = {
				cmp.config.compare.offset,
				cmp.config.compare.exact,
				cmp.config.compare.score,
				cmp.config.compare.recently_used,
				cmp.config.compare.locality,
				cmp.config.compare.kind,
				cmp.config.compare.sort_text,
				cmp.config.compare.length,
				cmp.config.compare.order,
			},
		},

		-- Performance
		performance = {
			debounce = 60,
			throttle = 30,
			fetching_timeout = 200,
			confirm_resolve_timeout = 80,
			async_budget = 1,
			max_view_entries = 200,
		},
	})

	-- ============================================================================
	-- Filetype Specific Setup
	-- ============================================================================

	-- Git commit completion
	cmp.setup.filetype("gitcommit", {
		sources = cmp.config.sources({
			{ name = "conventionalcommits" },
			{ name = "buffer" },
		}),
	})

	-- Markdown completion
	cmp.setup.filetype("markdown", {
		sources = cmp.config.sources({
			{ name = "nvim_lsp" },
			{ name = "buffer" },
			{ name = "path" },
			{ name = "emoji" },
		}),
	})

	-- SQL completion
	cmp.setup.filetype("sql", {
		sources = cmp.config.sources({
			{ name = "vim-dadbod-completion" },
			{ name = "nvim_lsp" },
			{ name = "buffer" },
		}),
	})

	-- ============================================================================
	-- Command Line Setup
	-- ============================================================================

	-- Search completion
	cmp.setup.cmdline({ "/", "?" }, {
		mapping = cmp.mapping.preset.cmdline(),
		sources = {
			{ name = "buffer" },
		},
	})

	-- Command completion
	cmp.setup.cmdline(":", {
		mapping = cmp.mapping.preset.cmdline(),
		sources = cmp.config.sources({
			{ name = "path" },
		}, {
			{ name = "cmdline" },
		}),
	})

	-- ============================================================================
	-- Auto-pairs Integration
	-- ============================================================================

	local cmp_autopairs = require("nvim-autopairs.completion.cmp")
	cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())

	-- ============================================================================
	-- Snippet Configuration
	-- ============================================================================

	-- Load friendly-snippets
	require("luasnip.loaders.from_vscode").lazy_load()

	-- Load custom snippets
	require("luasnip.loaders.from_vscode").lazy_load({
		paths = { vim.fn.stdpath("config") .. "/snippets" },
	})

	-- Configure LuaSnip
	luasnip.config.setup({
		history = true,
		updateevents = "TextChanged,TextChangedI",
		enable_autosnippets = true,
		ext_opts = {
			[require("luasnip.util.types").choiceNode] = {
				active = {
					virt_text = { { "←", "Error" } },
				},
			},
		},
	})

	-- ============================================================================
	-- Keymaps for snippets
	-- ============================================================================

	vim.keymap.set({ "i", "s" }, "<C-j>", function()
		if luasnip.expand_or_jumpable() then
			luasnip.expand_or_jump()
		end
	end, { desc = "LuaSnip: Expand or jump forward" })

	vim.keymap.set({ "i", "s" }, "<C-k>", function()
		if luasnip.jumpable(-1) then
			luasnip.jump(-1)
		end
	end, { desc = "LuaSnip: Jump backward" })

	vim.keymap.set({ "i", "s" }, "<C-l>", function()
		if luasnip.choice_active() then
			luasnip.change_choice(1)
		end
	end, { desc = "LuaSnip: Next choice" })

	-- Reload snippets
	vim.keymap.set("n", "<leader>sr", function()
		require("luasnip").unlink_current()
		require("luasnip.loaders.from_vscode").load()
		vim.notify("Snippets reloaded", vim.log.levels.INFO)
	end, { desc = "Reload snippets" })
end

return M
