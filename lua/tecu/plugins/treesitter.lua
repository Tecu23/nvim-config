-- NOTE: Syntax Highlighting
return {
	"nvim-treesitter/nvim-treesitter",
	cmd = {
		"TSInstall",
		"TSUninstall",
		"TSInstallInfo",
		"TSUpdate",
		"TSBufEnable",
		"TSBufDisable",
		"TSEnable",
		"TSDisable",
		"TSModuleInfo",
		"TSToggle",
		"TSBufToggle",
		"TSHighlightCapturesUnderCursor",
	},
	dependencies = {
		{
			"windwp/nvim-ts-autotag",
			opts = {
				opts = {
					-- Defaults
					enable_close = true, -- Auto close tags
					enable_rename = true, -- Auto rename pairs of tags
					enable_close_on_slash = false, -- Auto close on trailing </
				},
			},
		},
		"nvim-treesitter/nvim-treesitter-textobjects",
		{
			"nvim-treesitter/nvim-treesitter-context",
			init = function()
				vim.keymap.set(
					"n",
					"<leader>oc",
					"<cmd>TSContextToggle<cr>",
					{ desc = "Treesitter | Toggle Context", silent = true }
				)
				vim.keymap.set("n", "[c", function()
					require("treesitter-context").go_to_context(vim.v.count1)
				end, { desc = "Treesitter | Jumping to context (upwards)", silent = true })
			end,
			opts = {
				enable = false,
			},
		},
	},
	opts = {
		highlight = {
			enable = false,
		},
		ensure_installed = {
			"bash",
			"c",
			"cpp",
			"css",
			"go",
			"html",
			"http",
			"java",
			"javascript",
			"json",
			"lua",
			"markdown",
			"markdown_inline",
			"python",
			"regex",
			"ruby",
			"tsx",
			"typescript",
			"vim",
			"vimdoc",
			"yaml",
		},
		indent = {
			enable = false,
		},
	},
}
