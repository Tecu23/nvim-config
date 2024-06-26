local M = {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    event = "VeryLazy",
    dependencies = {
        { "nvim-lua/plenary.nvim" },
    },
}

function M.config()
    local harpoon = require("harpoon")

    harpoon:setup()

    vim.keymap.set("n", "<TAB>", function()
        harpoon.ui:toggle_quick_menu(harpoon:list())
    end)
    vim.keymap.set("n", "<M-m>", function()
        harpoon:list():add()
    end)
    vim.keymap.set("n", "<M-n>", function()
        harpoon:list():remove()
    end)

    vim.keymap.set("n", "<C-q>", function()
        harpoon:list():prev()
    end)
    vim.keymap.set("n", "<C-w>", function()
        harpoon:list():next()
    end)
end

return M
