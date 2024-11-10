return {
	filetypes = {
		"templ",
		"html",
		"css",
		"javascriptreact",
		"typescriptreact",
		"javascript",
		"typescript",
		"jsx",
		"tsx",
	},
	root_dir = require("lspconfig").util.root_pattern(
		"tailwind.config.js",
		"tailwind.config.cjs",
		"tailwind.config.mjs",
		"tailwind.config.ts",
		"postcss.config.js",
		"postcss.config.cjs",
		"postcss.config.mjs",
		"postcss.config.ts",
		"package.json",
		"node_modules",
		".git"
	),
}
