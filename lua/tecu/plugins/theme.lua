-- Should be where the actual themes are kept
return {
	{ "rktjmp/lush.nvim" },
	{
		"rose-pine/neovim",
		name = "rose-pine",
		config = function()
			require("rose-pine").setup({

				highlight_groups = {
					CursorLine = { bg = "#2e2e35" },
					RenderMarkdownCode = { bg = "#32363f" },
					RenderMarkdownCodeInline = { bg = "none" },
				},

				styles = {
					bold = true,
					italic = true,
					transparency = true,
				},
			})

			-- Finally set colorscheme
			vim.cmd("colorscheme rose-pine")
		end,
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
