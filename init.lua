-- ============================================================================
-- Neovim Main Entry File
-- ============================================================================

vim.g.mapleader = " "
vim.g.maplocalleader = " "

require("tecu.core.options") -- Basic Options
require("tecu.core.keymaps") -- Key Mappings
require("tecu.core.autocommands") -- Autocommands

require("tecu.config.lazy") -- Plugin Manager
