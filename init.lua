-- Launch
require("tecu.launch")

-- Core functionality
require("tecu.core.opts")
require("tecu.core.kmaps")

-- Autocommands
require("tecu.core.autocmds")

-- Core Plugins
spec("tecu.plugins.core.colorscheme")
spec("tecu.plugins.core.cmp")
spec("tecu.plugins.core.gitsigns")
spec("tecu.plugins.core.which-key")
spec("tecu.plugins.core.neo-tree")
spec("tecu.plugins.core.treesitter")
spec("tecu.plugins.core.telescope")
spec("tecu.plugins.core.indent_line")
spec("tecu.plugins.core.harpoon")
spec("tecu.plugins.core.transparent")
spec("tecu.plugins.core.colorizer")

-- Custom Plugins
spec("tecu.plugins.custom.todo-comments")
spec("tecu.plugins.custom.comment")
spec("tecu.plugins.custom.mini")
spec("tecu.plugins.custom.autopairs")
spec("tecu.plugins.custom.autotag")
spec("tecu.plugins.custom.gopher")
spec("tecu.plugins.custom.lazygit")
spec("tecu.plugins.custom.ufo")
spec("tecu.plugins.custom.dressing")
spec("tecu.plugins.custom.markdown-preview")
spec("tecu.plugins.custom.flash")
spec("tecu.plugins.custom.oil")

-- LSP
spec("tecu.lsp.lspconfig")
spec("tecu.lsp.conform")
spec("tecu.lsp.lint")

-- Lazy Nvim
require("tecu.lazy")

vim.api.nvim_command(":TransparentEnable")
