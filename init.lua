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
spec("tecu.plugins.core.which-key")
spec("tecu.plugins.core.neo-tree")
spec("tecu.plugins.core.treesitter")
spec("tecu.plugins.core.telescope")
spec("tecu.plugins.core.indent_line")
spec("tecu.plugins.core.harpoon")
spec("tecu.plugins.core.transparent")

-- Custom Plugins
spec("tecu.plugins.custom.noice")
spec("tecu.plugins.custom.todo-comments")
spec("tecu.plugins.custom.comment")
spec("tecu.plugins.custom.gitsigns")
spec("tecu.plugins.custom.mini")
spec("tecu.plugins.custom.debug")
spec("tecu.plugins.custom.autopairs")
spec("tecu.plugins.custom.autotag")
spec("tecu.plugins.custom.terminal")
spec("tecu.plugins.custom.gopher")
spec("tecu.plugins.custom.lazygit")
spec("tecu.plugins.custom.neotest")
spec("tecu.plugins.custom.ufo")
spec("tecu.plugins.custom.dressing")

-- LSP
spec("tecu.lsp.lspconfig")
spec("tecu.lsp.conform")
spec("tecu.lsp.lint")

-- Lazy Nvim
require("tecu.lazy")
