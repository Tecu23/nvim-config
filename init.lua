-- Set <space> as the leader key
--  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

require("tecu.core.options") -- Basic Options
require("tecu.core.autocommands") -- Autocommands

require("tecu.config.lazy") -- Plugin Manager

require("tecu.core.keymaps") -- Key Mappings
