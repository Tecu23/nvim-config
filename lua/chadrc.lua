local M = {}

M.base46 = {
	theme = "kanagawa",
	-- transparency = true,
}

M.ui = {
	telescope = { style = "borderless" }, -- borderless / bordered
	cmp = {
		lspkind_text = true,
		style = "default", -- default/flat_light/flat_dark/atom/atom_colored
		format_colors = {
			tailwind = true,
		},
	},
	statusline = {
		theme = "minimal", -- default/vscode/vscode_colored/minimal
		-- default/round/block/arrow separators work only for default statusline theme
		-- round and block will work for minimal theme only
		separator_style = "round",
		order = {
			"mode",
			"file",
			"git",
			"%=",
			"lsp_msg",
			"python_venv",
			"diagnostics",
			"command",
			"clients",
			"cwd",
			"total_lines",
		},
		modules = require("tecu.utils.statusline").modules,
	},
	tabufline = { enabled = false },
}

return M
