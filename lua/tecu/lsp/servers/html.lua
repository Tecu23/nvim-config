-- ============================================================================
-- HTML Language Server
-- ============================================================================

return {
	cmd = { "vscode-html-language-server", "--stdio" },
	filetypes = { "html", "templ", "eruby", "ejs", "erb" },
	init_options = {
		configurationSection = { "html", "css", "javascript" },
		embeddedLanguages = {
			css = true,
			javascript = true,
		},
		provideFormatter = true,
	},
	settings = {
		html = {
			format = {
				enable = true,
				wrapLineLength = 120,
				unformatted = "wbr",
				contentUnformatted = "pre,code,textarea",
				indentInnerHtml = false,
				preserveNewLines = true,
				maxPreserveNewLines = 2,
				indentHandlebars = false,
				endWithNewline = false,
				extraLiners = "head, body, /html",
				wrapAttributes = "auto",
			},
			hover = {
				documentation = true,
				references = true,
			},
		},
	},
}
