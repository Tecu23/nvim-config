-- ============================================================================
-- Comments Plugins Configuration for Lazy.nvim (TS-Comments, Todo-Comments)
-- ============================================================================
return {
	{
		"folke/todo-comments.nvim",
		event = "VimEnter",
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = { signs = false },
	},
	{
		"folke/ts-comments.nvim",
		event = "BufReadPost",
		opts = {},
	},
}
