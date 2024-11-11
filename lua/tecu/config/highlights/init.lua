-- NOTE: NvChad Related Highlights
-- To find any highlight groups: "<cmd> Telescope highlights"
-- Each highlight group can take a table with variables fg, bg, bold, italic, etc
-- base30 variable names can also be used as colors

local M = {}

---@type Base46HLGroupsList
M.override = {
	Comment = {
		italic = true,
	},
	["@comment"] = { italic = true },
	Search = { fg = "black", bg = "blue" },
	IncSearch = { fg = "black", bg = "red" },
	CurSearch = { fg = "black", bg = "blue" },
	Substitute = { fg = "black", bg = "green" },
	NvDashAscii = { bg = "NONE", fg = "blue" },
	NvDashButtons = { bg = "NONE" },
	FoldColumn = { bg = "NONE" },
	LspReferenceRead = { link = "Underlined" },
	LspReferenceText = { link = "Underlined" },
	LspReferenceWrite = { link = "Underlined" },
	TblineFill = { link = "Normal" },
	NvimTreeRootFolder = { link = "NvimTreeFolderName" },
	["@variable"] = { fg = "#8fb4b5" },
	["@variable.builtin"] = { fg = "#ff9e64", italic = true },
	["@tag"] = { fg = "#8fb4b5" }, -- Color for JSX tags
	["@tag.attribute"] = { fg = "#8fb4b5" }, -- Color for JSX tag attributes
	["@tag.delimiter"] = { fg = "#bd93f9" }, -- Color for delimiters (e.g., <, />)
	htmlTagName = { fg = "#8fb4b5" }, -- Color for HTML tag names
	["@lsp.type.parameter.typescriptreact"] = { link = "@variable" },
}

---@type HLTable
M.add = {
	WinBar = { link = "Normal" },
	WinBarNC = { link = "Normal" },
	DiffviewDiffAdd = { fg = "black", bg = "green" },
	DiffviewDiffChange = { fg = "black", bg = "green" },
	DiffviewDiffDelete = { fg = "black", bg = "red" },
	DiffviewDiffAddAsDelete = { fg = "black", bg = "red" },
	LspInlayHint = { link = "Comment" },
}

return M
