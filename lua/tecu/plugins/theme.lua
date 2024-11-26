-- Should be where the actual themes are kept
return {
	{ "rktjmp/lush.nvim" },
	{
		"rose-pine/neovim",
		name = "rose-pine",
		opts = {
			on_highlights = function(hl, c)
				hl.TelescopeSelection = { bg = c.bg_highlight, fg = c.fg }
			end,

			styles = {
				bold = true,
				italic = true,
				transparency = true,
			},
		},
	},
	{
		"rebelot/kanagawa.nvim",
		opts = {
			transparent = true,
			theme = "dragon",
		},
	},
	{ "mountain-theme/vim" },
	{ "tiagovla/tokyodark.nvim" },
}
