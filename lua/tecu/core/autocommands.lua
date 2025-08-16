-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})

local opt = vim.opt

-- ============================================================================
-- Filetype Specific Overrides
-- ============================================================================
-- These will be applied automatically based on file type
-- You can add more in ~/.config/nvim/after/ftplugin/<filetype>.lua
vim.api.nvim_create_autocmd("FileType", {
	pattern = { "python" },
	callback = function()
		opt.tabstop = 4
		opt.shiftwidth = 4
		opt.softtabstop = 4
	end,
})

vim.api.nvim_create_autocmd("FileType", {
	pattern = { "go" },
	callback = function()
		opt.expandtab = false -- Go uses tabs
		opt.tabstop = 4
		opt.shiftwidth = 4
		opt.softtabstop = 4
	end,
})

vim.api.nvim_create_autocmd("FileType", {
	pattern = { "markdown", "text" },
	callback = function()
		opt.wrap = true
		opt.spell = true
		opt.linebreak = true
	end,
})

vim.api.nvim_create_autocmd("FileType", {
	pattern = { "yaml", "yml" },
	callback = function()
		opt.tabstop = 2
		opt.shiftwidth = 2
		opt.softtabstop = 2
	end,
})

-- ============================================================================
-- Terminal Settings
-- ============================================================================
vim.api.nvim_create_autocmd("TermOpen", {
	pattern = "*",
	callback = function()
		opt.number = false
		opt.relativenumber = false
		opt.signcolumn = "no"
		vim.cmd("startinsert")
	end,
})
