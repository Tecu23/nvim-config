-- ============================================================================
-- JSON Language Server
-- ============================================================================

return {
	cmd = { "vscode-json-language-server", "--stdio" },
	filetypes = { "json", "jsonc" },
	init_options = {
		provideFormatter = true,
	},
	settings = {
		json = {
			-- Use schemastore for better schema support
			schemas = (function()
				local ok, schemastore = pcall(require, "schemastore")
				if ok then
					return schemastore.json.schemas()
				end
				return {}
			end)(),
			validate = { enable = true },
			format = {
				enable = true,
				keepLines = false,
			},
			hover = {
				documentation = true,
				references = true,
			},
			trace = {
				server = "off",
			},
		},
	},
}
