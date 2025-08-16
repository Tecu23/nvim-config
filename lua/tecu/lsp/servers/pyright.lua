-- ============================================================================
-- Python Language Server (Pyright) Configuration
-- ============================================================================

return {
	cmd = { "pyright-langserver", "--stdio" },
	filetypes = { "python" },
	settings = {
		python = {
			analysis = {
				autoSearchPaths = true,
				useLibraryCodeForTypes = true,
				diagnosticMode = "workspace",
				typeCheckingMode = "basic", -- "off", "basic", "strict"
				autoImportCompletions = true,
				completeFunctionParens = true,

				-- Diagnostic settings
				diagnosticSeverityOverrides = {
					reportMissingImports = "error",
					reportUndefinedVariable = "error",
					reportMissingTypeStubs = "none",
					reportGeneralTypeIssues = "warning",
					reportOptionalMemberAccess = "warning",
					reportOptionalCall = "warning",
					reportOptionalIterable = "warning",
					reportOptionalContextManager = "warning",
					reportOptionalOperand = "warning",
					reportTypedDictNotRequiredAccess = "warning",
					reportPrivateImportUsage = "warning",
				},

				-- Inlay hints
				inlayHints = {
					variableTypes = true,
					functionReturnTypes = true,
					parameterNames = true,
				},
			},
			linting = {
				enabled = true,
				pylintEnabled = true,
			},
			formatting = {
				provider = "black",
			},
			testing = {
				provider = "pytest",
			},
		},
	},
	on_attach = function(client, bufnr)
		-- Python specific keymaps
		local map = function(mode, lhs, rhs, desc)
			vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = "Python: " .. desc })
		end

		-- Testing
		map("n", "<leader>pt", "<cmd>!python -m pytest %<CR>", "Run tests in current file")
		map("n", "<leader>pT", "<cmd>!python -m pytest<CR>", "Run all tests")
		map("n", "<leader>pd", "<cmd>!python -m pytest --pdb<CR>", "Run tests with debugger")

		-- Virtual environment
		map("n", "<leader>pv", "<cmd>!python -m venv venv<CR>", "Create virtual environment")
		map("n", "<leader>pa", "<cmd>!source venv/bin/activate<CR>", "Activate virtual environment")

		-- Run
		map("n", "<leader>pr", "<cmd>!python %<CR>", "Run current file")
		map("n", "<leader>pi", "<cmd>!python<CR>", "Start Python REPL")

		-- Package management
		map("n", "<leader>pp", "<cmd>!pip install -r requirements.txt<CR>", "Install requirements")
		map("n", "<leader>pf", "<cmd>!pip freeze > requirements.txt<CR>", "Freeze requirements")
	end,
}
