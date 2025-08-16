return {
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
		end,
	},
	{
		"vague2k/vague.nvim",
		config = function()
			require("vague").setup({
				transparent = true, -- don't set background
				style = {
					boolean = "bold",
					comments = "italic",
					strings = "italic",
					-- most other token types are set to "none"
				},
				-- Override highlights or add new highlights
				on_highlights = function(highlights, colors)
					for k, v in pairs(highlights) do
						print(k, v[1])
					end
				end,

				colors = {
					bg = "#141415",
					inactiveBg = "#1c1c24",
					fg = "#cdcdcd",
					floatBorder = "#878787",
					line = "#252530",
					comment = "#606079",
					builtin = "#b4d4cf",
					func = "#c48282",
					string = "#e8b589",
					number = "#e0a363",
					property = "#c3c3d5",
					constant = "#aeaed1",
					parameter = "#bb9dbd",
					visual = "#333738",
					error = "#d8647e",
					warning = "#f3be7c",
					hint = "#7e98e8",
					operator = "#90a0b5",
					keyword = "#6e94b2",
					type = "#9bb4bc",
					search = "#405065",
					plus = "#7fa563",
					delta = "#f3be7c",
				},
			})

			vim.cmd.colorscheme("rose-pine")
			vim.cmd.colorscheme("vague")
		end,
	},
}
