-- ============================================================================
-- ESLint Language Server
-- ============================================================================

return {
	cmd = { "vscode-eslint-language-server", "--stdio" },
	filetypes = {
		"javascript",
		"javascriptreact",
		"javascript.jsx",
		"typescript",
		"typescriptreact",
		"typescript.tsx",
		"vue",
		"svelte",
		"astro",
	},
	settings = {
		eslint = {
			enable = true,
			packageManager = "npm", -- or "yarn" or "pnpm"
			autoFixOnSave = true,
			codeActionsOnSave = {
				mode = "all",
				rules = {},
			},
			format = true,
			quiet = false,
			onIgnoredFiles = "off",
			rulesCustomizations = {},
			run = "onType", -- or "onSave"
			nodePath = "",
			options = {},
			problems = {
				shortenToSingleLine = false,
			},
			-- Working directories for monorepos
			workingDirectories = {
				mode = "auto",
			},
			validate = "on",
			codeAction = {
				disableRuleComment = {
					enable = true,
					location = "separateLine", -- or "sameLine"
				},
				showDocumentation = {
					enable = true,
				},
			},
			-- This is the new part to add the rule configuration
			rules = {
				["no-unused-vars"] = "off",
				["@typescript-eslint/no-unused-vars"] = {
					"warn",
					{
						argsIgnorePattern = "^_",
						varsIgnorePattern = "^_",
						caughtErrorsIgnorePattern = "^_",
					},
				},
			},
		},
	},
	on_attach = function(client, bufnr)
		-- ESLint specific autocmds
		vim.api.nvim_create_autocmd("BufWritePre", {
			buffer = bufnr,
			command = "EslintFixAll",
		})

		-- ESLint specific keymaps
		local map = function(mode, lhs, rhs, desc)
			vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = "ESLint: " .. desc })
		end

		map("n", "<leader>ef", "<cmd>EslintFixAll<CR>", "Fix all ESLint issues")
	end,
}
