-- ============================================================================
-- Theme Configuration
-- ============================================================================

local function apply_transparency()
	local transparent_groups = {
		"Normal",
		"NormalNC",
		"Comment",
		"Constant",
		"Special",
		"Identifier",
		"Statement",
		"PreProc",
		"Type",
		"Underlined",
		"Todo",
		"String",
		"Function",
		"Conditional",
		"Repeat",
		"Operator",
		"Structure",
		"LineNr",
		"NonText",
		"SignColumn",
		"CursorLineNr",
		"EndOfBuffer",
		"TabLine",
		"TabLineFill",
		"StatusLine",
		"StatusLineNC",
		"WinBar",
		"WinBarNC",
	}

	for _, group in ipairs(transparent_groups) do
		vim.cmd(string.format("highlight %s guibg=NONE ctermbg=NONE", group))
	end
end

return {
	"vague2k/vague.nvim",
	lazy = false, -- make sure we load this during startup if it is your main colorscheme
	priority = 1000, -- make sure to load this before all the other plugins
	config = function()
		require("vague").setup({
			transparent = true,
		})
		vim.cmd("colorscheme vague")
		apply_transparency()

		-- Reapply transparency after colorscheme changes
		vim.api.nvim_create_autocmd("ColorScheme", {
			callback = apply_transparency,
		})
	end,
}
