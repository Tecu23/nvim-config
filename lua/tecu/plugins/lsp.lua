-- ============================================================================
-- LSP Plugins Configuration for Lazy.nvim
-- ============================================================================
return {
	-- ============================================================================
	-- Core LSP Configuration
	-- ============================================================================
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			-- LSP Management
			{ "williamboman/mason.nvim" },
			{ "williamboman/mason-lspconfig.nvim" },

			-- Useful status updates for LSP
			{
				"j-hui/fidget.nvim",
				config = function()
					require("fidget").setup({
						notification = {
							window = {
								winblend = 0,
								relative = "editor",
							},
						},
					})
				end,
			},

			-- Additional lua configuration, makes nvim stuff amazing
			{ "folke/neodev.nvim", opts = {} },

			-- Schema information for JSON/YAML
			{ "b0o/schemastore.nvim" },
		},
		config = function()
			require("tecu.lsp").setup()
		end,
	},

	-- ============================================================================
	-- Mason - Package Manager for LSP servers, DAP servers, linters, formatters
	-- ============================================================================
	{
		"williamboman/mason.nvim",
		cmd = { "Mason", "MasonInstall", "MasonUninstall", "MasonUpdate", "MasonLog" },
		build = ":MasonUpdate",
		config = function()
			require("mason").setup({
				ui = {
					border = "rounded",
					width = 0.8,
					height = 0.8,
					icons = {
						package_installed = "✓",
						package_pending = "➜",
						package_uninstalled = "✗",
					},
				},
				log_level = vim.log.levels.DEBUG,
				max_concurrent_installers = 4,
			})
		end,
	},

	-- ============================================================================
	-- TypeScript Tools (Better TypeScript support than ts_ls)
	-- ============================================================================
	{
		"pmizio/typescript-tools.nvim",
		dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
		ft = { "typescript", "typescriptreact", "javascript", "javascriptreact" },
		opts = {
			settings = {
				-- spawn additional tsserver instance to calculate diagnostics on it
				separate_diagnostic_server = true,
				-- "change"|"insert_leave" determine when the client asks the server about diagnostic
				publish_diagnostic_on = "insert_leave",
				-- array of strings("fix_all"|"add_missing_imports"|"remove_unused"|
				-- "remove_unused_imports"|"organize_imports") -- or string "all"
				expose_as_code_action = "all",
				-- string|nil - specify a custom path to `tsserver.js` file, if this is nil or file under path
				-- not exists then standard path resolution strategy is applied
				tsserver_path = nil,
				-- specify a list of plugins to load by tsserver
				tsserver_plugins = {},
				-- this value is passed to: https://nodejs.org/api/cli.html#--max-old-space-sizesize-in-megabytes
				tsserver_max_memory = "auto",
				-- described below
				tsserver_format_options = {},
				tsserver_file_preferences = {
					includeInlayParameterNameHints = "all",
					includeInlayParameterNameHintsWhenArgumentMatchesName = false,
					includeInlayFunctionParameterTypeHints = true,
					includeInlayVariableTypeHints = true,
					includeInlayVariableTypeHintsWhenTypeMatchesName = false,
					includeInlayPropertyDeclarationTypeHints = true,
					includeInlayFunctionLikeReturnTypeHints = true,
					includeInlayEnumMemberValueHints = true,
					includeCompletionsForModuleExports = true,
					quotePreference = "auto",
					allowTextChangesInNewFiles = true,
					providePrefixAndSuffixTextForRename = true,
				},
				-- locale of all tsserver messages
				tsserver_locale = "en",
				-- mirror of VSCode's code_lens_on
				complete_function_calls = true,
				include_completions_with_insert_text = true,
				-- CodeLens
				code_lens = "all", -- "off" | "all" | "implementations_only" | "references_only"
				-- disable_member_code_lens = true, -- true | false
				-- JSX specific settings
				jsx_close_tag = {
					enable = true,
					filetypes = { "javascriptreact", "typescriptreact" },
				},
			},
			handlers = {},
		},
	},

	-- ============================================================================
	-- Autocompletion
	-- ============================================================================
	{
		"hrsh7th/nvim-cmp",
		event = "InsertEnter",
		dependencies = {
			-- Snippet Engine & its associated nvim-cmp source
			{
				"L3MON4D3/LuaSnip",
				version = "v2.*",
				build = "make install_jsregexp",
				dependencies = {
					{
						"rafamadriz/friendly-snippets",
						config = function()
							require("luasnip.loaders.from_vscode").lazy_load()
						end,
					},
				},
				config = function()
					require("luasnip.loaders.from_vscode").lazy_load()
				end,
			},
			"saadparwaiz1/cmp_luasnip",

			-- LSP completion capabilities
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-nvim-lsp-signature-help",

			-- Additional completion sources
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-cmdline",
			"hrsh7th/cmp-nvim-lua",

			-- Better sorting and filtering
			{
				"tzachar/cmp-fuzzy-buffer",
				dependencies = { "tzachar/fuzzy.nvim" },
			},

			-- Icons for completion items
			"onsails/lspkind.nvim",
		},
		config = function()
			require("tecu.lsp.completion").setup()
		end,
	},

	-- ============================================================================
	-- Formatting
	-- ============================================================================
	{
		"stevearc/conform.nvim",
		event = { "BufWritePre" },
		cmd = { "ConformInfo" },
		keys = {
			{
				"<leader>f",
				function()
					require("conform").format({ async = true, lsp_fallback = true })
				end,
				mode = { "n", "v" },
				desc = "[F]ormat Buffer",
			},
		},
		opts = {
			notify_on_error = true,
			formatters_by_ft = {
				asm = { "asmfmt" },
				lua = { "stylua" },

				cpp = { "clang-format" },

				python = { "isort", "black" },

				css = { "prettierd", "prettier" },
				scss = { "prettierd", "prettier" },
				html = { "prettierd", "prettier" },
				yaml = { "prettierd", "prettier" },
				json = { "prettierd", "prettier" },
				markdown = { "prettierd", "prettier" },
				javascript = { "prettierd", "prettier" },
				typescript = { "prettierd", "prettier" },
				javascriptreact = { "prettierd", "prettier" },
				typescriptreact = { "prettierd", "prettier" },

				go = { "gofumpt", "goimports-reviser", "goimports", "gofmt", "golines" },

				sql = { "sqlfmt" },

				ruby = { "rubocop" },

				rust = { "rustfmt" },

				sh = { "shfmt" },
				["*"] = { "trim_whitespace" },
			},
			format_on_save = function(bufnr)
				-- Disable with a global or buffer-local variable
				if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
					return
				end
				return { timeout_ms = 500, lsp_fallback = true }
			end,
		},
	},

	-- ============================================================================
	-- Linting
	-- ============================================================================
	{
		"mfussenegger/nvim-lint",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			local lint = require("lint")

			lint.linters_by_ft = {
				javascript = { "eslint_d" },
				typescript = { "eslint_d" },
				javascriptreact = { "eslint_d" },
				typescriptreact = { "eslint_d" },

				python = { "pylint" },

				ruby = { "rubocop" },

				go = { "revive" },

				json = { "jsonlint" },

				markdown = { "markdownlint" },

				yaml = { "yamllint" },

				dockerfile = { "hadolint" },

				bash = { "shellcheck" },
				sh = { "shellcheck" },
				make = { "checkmate" },
			}

			-- Create autocommand which carries out the actual linting
			-- on the specified events.
			local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })
			vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
				group = lint_augroup,
				callback = function()
					lint.try_lint()
				end,
			})
		end,
	},

	-- ============================================================================
	-- Trouble - Better diagnostics list
	-- ============================================================================
	{
		"folke/trouble.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		cmd = { "Trouble", "TroubleToggle" },
		opts = {
			position = "bottom",
			height = 10,
			width = 50,
			icons = true,
			mode = "workspace_diagnostics",
			fold_open = "",
			fold_closed = "",
			group = true,
			padding = true,
			action_keys = {
				close = "q",
				cancel = "<esc>",
				refresh = "r",
				jump = { "<cr>", "<tab>" },
				open_split = { "<c-x>" },
				open_vsplit = { "<c-v>" },
				open_tab = { "<c-t>" },
				jump_close = { "o" },
				toggle_mode = "m",
				toggle_preview = "P",
				hover = "K",
				preview = "p",
				close_folds = { "zM", "zm" },
				open_folds = { "zR", "zr" },
				toggle_fold = { "zA", "za" },
				previous = "k",
				next = "j",
			},
			indent_lines = true,
			auto_open = false,
			auto_close = false,
			auto_preview = true,
			auto_fold = false,
			auto_jump = { "lsp_definitions" },
			sign_priority = 6,
			use_diagnostic_signs = false,
		},
	},

	-- ============================================================================
	-- Inlay Hints (if not using Neovim 0.10+)
	-- ============================================================================
	{
		"lvimuser/lsp-inlayhints.nvim",
		branch = "anticonceal",
		event = "LspAttach",
		opts = {},
	},
}
