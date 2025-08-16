-- ============================================================================
-- Tailwind CSS Language Server
-- ============================================================================

return {
	cmd = { "tailwindcss-language-server", "--stdio" },
	filetypes = {
		"html",
		"css",
		"scss",
		"javascript",
		"javascriptreact",
		"typescript",
		"typescriptreact",
		"vue",
		"svelte",
		"astro",
		"erb",
		"eruby",
	},
	init_options = {
		userLanguages = {
			eruby = "html",
			erb = "html",
		},
	},
	settings = {
		tailwindCSS = {
			emmetCompletions = true,
			includeLanguages = {
				eruby = "html",
				erb = "html",
			},
			lint = {
				cssConflict = "warning",
				invalidApply = "error",
				invalidScreen = "error",
				invalidVariant = "error",
				invalidConfigPath = "error",
				invalidTailwindDirective = "error",
				recommendedVariantOrder = "warning",
			},
			experimental = {
				classRegex = {
					-- Support for clsx, cn, cva, etc.
					{ "clsx\\(([^)]*)\\)", "[\"'`]([^\"'`]*).*?[\"'`]" },
					{ "cn\\(([^)]*)\\)", "[\"'`]([^\"'`]*).*?[\"'`]" },
					{ "cva\\(([^)]*)\\)", "[\"'`]([^\"'`]*).*?[\"'`]" },
					{ "cx\\(([^)]*)\\)", "[\"'`]([^\"'`]*).*?[\"'`]" },
					{ "tw`([^`]*)`" },
					{ "tw\\.\\w+`([^`]*)`" },
					{ "tw\\(.*?\\)`([^`]*)`" },
				},
			},
			validate = true,
			hovers = true,
			suggestions = true,
			codeActions = true,
		},
	},
	on_attach = function(client, bufnr)
		-- Tailwind specific keymaps
		local map = function(mode, lhs, rhs, desc)
			vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = "Tailwind: " .. desc })
		end

		map("n", "<leader>tc", function()
			vim.lsp.buf.execute_command({
				command = "_tailwindcss.showOutput",
			})
		end, "Show Tailwind CSS output")
	end,
}
