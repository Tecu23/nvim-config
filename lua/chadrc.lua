local M = {}

local highlights = require("tecu.config.highlights")

for group, settings in pairs(highlights.override) do
	vim.api.nvim_set_hl(0, group, settings)
end

M.base46 = {
	theme = "custom_mountain",
	hl_override = highlights.override,
	hl_add = highlights.add,
	integrations = {
		"notify",
		"trouble",
	},
	transparency = true,
}

M.ui = {
	telescope = { style = "bordered" }, -- borderless / bordered
	cmp = {
		lspkind_text = true,
		style = "default", -- default/flat_light/flat_dark/atom/atom_colored
		format_colors = {
			tailwind = true,
			icon = "󱓻",
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
		modules = require("tecu.config.statusline").modules,
	},
	tabufline = { enabled = false },
}

M.plugins = "tecu.plugins"

return M
