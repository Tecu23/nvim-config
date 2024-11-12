-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

require("tecu.core") -- Core Settings

require("tecu.config.lazy") -- Plugin Manager

vim.cmd("colorscheme kanagawa")
