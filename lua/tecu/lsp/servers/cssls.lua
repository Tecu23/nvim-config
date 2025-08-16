-- ============================================================================
-- CSS Language Server
-- ============================================================================

return {
	cmd = { "vscode-css-language-server", "--stdio" },
	filetypes = { "css", "scss", "less" },
	settings = {
		css = {
			validate = true,
			lint = {
				unknownAtRules = "ignore", -- For Tailwind @apply, etc.
				duplicateProperties = "warning",
				emptyRules = "warning",
				importStatement = "warning",
				zeroUnits = "warning",
				fontFaceProperties = "warning",
				hexColorLength = "warning",
				argumentsInColorFunction = "warning",
				unknownProperties = "warning",
				ieHack = "warning",
				unknownVendorSpecificProperties = "ignore",
				propertyIgnoredDueToDisplay = "warning",
				important = "ignore",
				float = "ignore",
				idSelector = "ignore",
			},
			hover = {
				documentation = true,
				references = true,
			},
		},
		scss = {
			validate = true,
			lint = {
				unknownAtRules = "ignore",
				duplicateProperties = "warning",
				emptyRules = "warning",
				importStatement = "warning",
				zeroUnits = "warning",
				fontFaceProperties = "warning",
				hexColorLength = "warning",
				argumentsInColorFunction = "warning",
				unknownProperties = "warning",
				ieHack = "warning",
				unknownVendorSpecificProperties = "ignore",
				propertyIgnoredDueToDisplay = "warning",
				important = "ignore",
				float = "ignore",
				idSelector = "ignore",
			},
			hover = {
				documentation = true,
				references = true,
			},
		},
		less = {
			validate = true,
			lint = {
				unknownAtRules = "ignore",
				duplicateProperties = "warning",
				emptyRules = "warning",
				importStatement = "warning",
				zeroUnits = "warning",
				fontFaceProperties = "warning",
				hexColorLength = "warning",
				argumentsInColorFunction = "warning",
				unknownProperties = "warning",
				ieHack = "warning",
				unknownVendorSpecificProperties = "ignore",
				propertyIgnoredDueToDisplay = "warning",
				important = "ignore",
				float = "ignore",
				idSelector = "ignore",
			},
			hover = {
				documentation = true,
				references = true,
			},
			suggest = {
				html5 = true,
			},
			validate = {
				scripts = true,
				styles = true,
			},
		},
	},
}
