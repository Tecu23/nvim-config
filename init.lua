-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

require("tecu.core") -- Core Settings

vim.g.base46_cache = vim.fn.stdpath("data") .. "/base46_cache/"

require("tecu.config.lazy") -- Plugin Manager

-- (method 2, for non lazyloaders) to load all highlights at once
for _, v in ipairs(vim.fn.readdir(vim.g.base46_cache)) do
	if v == "tbline" then
		goto continue
	end
	dofile(vim.g.base46_cache .. v)
	::continue::
end

require("tecu.colorscheme")

-- NOTE: Next step on your Neovim journey: Add/Configure additional plugins for Kickstart
--
--  Here are some example plugins that I've included in the Kickstart repository.
--  Uncomment any of the lines below to enable them (you will need to restart nvim).
--
-- require 'kickstart.plugins.debug',
-- require 'kickstart.plugins.indent_line',
-- require 'kickstart.plugins.lint',
-- require 'kickstart.plugins.autopairs',
-- require 'kickstart.plugins.neo-tree',
-- require 'kickstart.plugins.gitsigns', -- adds gitsigns recommend keymaps

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
