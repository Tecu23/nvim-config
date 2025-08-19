-- ============================================================================
-- Markdown Plugins Configuration
-- ============================================================================

return {
	{
		"OXY2DEV/markview.nvim",
		lazy = false,

		-- For `nvim-treesitter` users.
		priority = 49,
	},
	{
		"iamcco/markdown-preview.nvim",
		enabled = true,
		init = function()
			vim.keymap.set("n", "<leader>m", function()
				if vim.bo.filetype == "markdown" then
					vim.cmd("MarkdownPreviewToggle")
				else
					vim.notify("Only available in markdown", vim.log.levels.WARN, { title = "Markdown-Preview" })
				end
			end, { desc = "Markdown Preview", silent = true })
		end,
		build = function()
			require("lazy").load({ plugins = { "markdown-preview.nvim" } })
			vim.fn["mkdp#util#install"]()
		end,
		ft = "markdown",
	},
}
