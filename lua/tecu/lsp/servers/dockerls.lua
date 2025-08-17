-- ============================================================================
-- Docker Language Server Configuration
-- ============================================================================

return {
	cmd = { "docker-langserver", "--stdio" },
	filetypes = { "dockerfile" },
	root_dir = function(fname)
		local util = require("lspconfig.util")
		return util.root_pattern("Dockerfile", "docker-compose.yml", ".git")(fname) or util.path.dirname(fname)
	end,
	single_file_support = true,
}
