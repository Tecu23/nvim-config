-- ============================================================================
-- Bash Language Server Configuration
-- ============================================================================

return {
	cmd = { "bash-language-server", "start" },
	filetypes = { "sh", "bash", "zsh" },
	settings = {
		bashIde = {
			globPattern = "*@(.sh|.bash|.zsh|.zshrc|.bashrc|.bash_profile|.bash_aliases)",
			shellcheckPath = "shellcheck",
			shellcheckArguments = {},
			explainshellEndpoint = "",
			includeAllWorkspaceSymbols = false,
			backgroundAnalysisMaxFiles = 500,
		},
	},
}
