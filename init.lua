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

-- require("tecu.colorscheme")
