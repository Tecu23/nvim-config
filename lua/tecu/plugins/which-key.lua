return { -- Useful plugin to show you pending keybinds.
	"folke/which-key.nvim",
	event = "VimEnter", -- Sets the loading event to 'VimEnter'
	opts = {
		icons = {
			mappings = vim.g.have_nerd_font,
		},

		plugins = {
			marks = true, -- shows a list of your marks on ' and `
			registers = true, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
			spelling = {
				enabled = true, -- enabling this will show WhichKey when pressing z= to select spelling suggestions
				suggestions = 20, -- how many suggestions should be shown in the list?
			},
		},
		window = {
			border = "rounded", -- none, single, double, shadow
			position = "bottom", -- bottom, top
			margin = { 1, 0, 1, 0 }, -- extra window margin [top, right, bottom, left]
			padding = { 2, 2, 2, 2 }, -- extra window padding [top, right, bottom, left]
		},

		spec = {
			-- { "<leader>a", group = "[A] (currently unused)" },
			{ "<leader>b", group = "[B]uffer Commands" },
			{ "<leader>c", group = "[C]ode Commands" },
			{ "<leader>d", group = "[D]ocument/[D]iagnostic Commands" },
			{ "<leader>e", group = "N[E]oTree Commands" },
			{ "<leader>f", group = "[F]ormat File" },
			{ "<leader>g", group = "[G]it Commands" },
			{ "<leader>gg", group = "[G]olang Commands" },
			{ "<leader>h", group = "[H]arpoon Commands" },
			{ "<leader>i", group = "[I]nlay Hints Commands" },
			-- { "<leader>j", group = "[J] (currently unused)" },
			-- { "<leader>k", group = "[K] (currently unused)" },
			{ "<leader>l", group = "[L]ocation List Commands" },
			{ "<leader>m", group = "[M]arkdown Commands" },
			{ "<leader>n", group = "[N]eovi Commands" },
			-- { "<leader>o", group = "[O] (currently unused)" },
			-- { "<leader>p", group = "[P] (currently unused)" },
			{ "<leader>q", group = "[Q]uickfix List Commands" },
			{ "<leader>r", group = "[R]uby Commands" },
			{ "<leader>s", group = "[S]earch Files" },
			{ "<leader>t", group = "[T]erminal/Tab Commands" },
			-- { "<leader>u", group = "[U] (currently unused)" },
			-- { "<leader>v", group = "[V] (currently unused)" },
			{ "<leader>w", group = "[W]orkspace Commands" },
			{ "<leader>x", group = "[X]Trouble Commands" },
			{ "<leader>y", group = "[Y]aml Commands" },
			{ "<leader>z", group = "[Z] Fold Management Commands" },
		},
	},
}
