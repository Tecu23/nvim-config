-- ============================================================================
-- Lua Language Server Configuration
-- ============================================================================

return {
	cmd = { "lua-language-server" },
	filetypes = { "lua" },
	settings = {
		Lua = {
			runtime = {
				-- LuaJIT in the case of Neovim
				version = "LuaJIT",
				path = vim.split(package.path, ";"),
			},
			diagnostics = {
				-- Get the language server to recognize the `vim` global
				globals = {
					"vim",
					"describe",
					"it",
					"before_each",
					"after_each",
					"pending",
					"xit",
				},
				disable = {
					"missing-fields",
					"incomplete-signature-doc",
				},
			},
			workspace = {
				-- Make the server aware of Neovim runtime files
				library = {
					vim.env.VIMRUNTIME .. "/lua",
					vim.env.VIMRUNTIME .. "/lua/vim/lsp",
					vim.fn.stdpath("data") .. "/lazy", -- if using lazy.nvim
					vim.fn.stdpath("config") .. "/lua",
				},
				maxPreload = 10000,
				preloadFileSize = 10000,
				checkThirdParty = false,
			},
			completion = {
				callSnippet = "Replace",
				keywordSnippet = "Replace",
				displayContext = 1,
				showWord = "Enable",
			},
			telemetry = {
				enable = false,
			},
			hint = {
				enable = true,
				arrayIndex = "Auto",
				await = true,
				paramName = "All",
				paramType = true,
				semicolon = "SameLine",
				setType = true,
			},
			format = {
				enable = true,
				defaultConfig = {
					indent_style = "space",
					indent_size = "2",
					continuation_indent = "2",
				},
			},
			spell = {
				enable = true,
			},
		},
	},
}
