return { -- Autoformat
	"stevearc/conform.nvim",
	event = { "BufWritePre" },
	cmd = { "ConformInfo" },
	keys = {
		{
			"<leader>f",
			function()
				require("conform").format({ async = true, lsp_format = "fallback" })
			end,
			mode = "",
			desc = "[F]ormat buffer",
		},
	},
	opts = {
		notify_on_error = true,
		log_level = vim.log.levels.DEBUG,
		format_on_save = function(bufnr)
			-- Disable "format_on_save lsp_fallback" for languages that don't
			-- have a well standardized coding style. You can add additional
			-- languages here or re-enable it for the disabled ones.
			local disable_filetypes = { c = true, cpp = true }

			local lsp_format_opt
			if disable_filetypes[vim.bo[bufnr].filetype] then
				lsp_format_opt = "never"
			else
				lsp_format_opt = "fallback"
			end
			return {
				timeout_ms = 500,
				lsp_format = lsp_format_opt,
			}
		end,
		formatters = {
			stylua = {
				prepend_args = { "--indent-width", "4" },
			},
			prettierd = {},
		},
		formatters_by_ft = {
			asm = { "asmfmt" },
			lua = { "stylua" },
			--
			astro = { "prettierd" },
			css = { "prettierd" },
			html = { "prettierd" },
			json = { "prettierd" },
			markdown = { "prettierd" },
			typescript = { "prettierd" },
			typescriptreact = { "prettierd" },
			javascript = { "prettierd" },
			javascriptreact = { "prettierd" },

			python = { "isort", "black" },
			--
			-- ruby = { "rufo" },
			--
			go = { "gofumpt", "goimports-reviser", "goimports", "golines" },
			yaml = { "yamlfmt" },

			sql = { "sqlfmt" },

			cpp = { "clang-format" },
			--
			bash = { "shfmt" },
			sh = { "shfmt" },
			-- make = {
			-- 	{
			-- 		command = "shfmt",
			-- 		args = { "-filename", "Makefile" }, -- Specific tag for makefile
			-- 		stdin = true,
			-- 	},
			-- },
		},
	},
}
