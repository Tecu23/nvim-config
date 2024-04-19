-- [[ Install `lazy.nvim` plugin manager ]]
--    See `:help lazy.nvim.txt` or https://github.com/folke/lazy.nvim for more info
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"

    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        lazyrepo,
        "--branch=stable",
        lazypath,
    })
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

-- Setup lazy with the launch spec
require("lazy").setup({
    spec = LAZY_PLUGIN_SPEC,
    install = {
        colorscheme = { "darkplus", "default" },
    },
    ui = {
        border = "rounded",
        icons = vim.g.have_nerd_font and {} or {
            cmd = "⌘",
            config = "🛠",
            event = "📅",
            ft = "📂",
            init = "⚙",
            keys = "🗝",
            plugin = "🔌",
            runtime = "💻",
            require = "🌙",
            source = "📄",
            start = "🚀",
            task = "📌",
            lazy = "💤 ",
        },
    },
    change_detection = {
        enabled = true,
        notify = false,
    },
})
