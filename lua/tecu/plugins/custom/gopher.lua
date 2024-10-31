local M = {
    "olexsmir/gopher.nvim",
    dependencies = { -- dependencies
        "nvim-lua/plenary.nvim",
        "nvim-treesitter/nvim-treesitter",
    },
}

M.config = function()
    require("gopher").setup({
        commands = {
            go = "go",
            gomodifytags = "gomodifytags",
            impl = "impl",
            iferr = "iferr",
        },
        gotests = {
            -- gotests doesn't have template named "default" so this plugin uses "default" to set the default template
            template = "default",
            -- path to a directory containing custom test code templates
            template_dir = nil,
            -- switch table tests from using slice to map (with test name for the key)
            -- works only with gotests installed from develop branch
            named = false,
        },
        gotag = {
            transform = "snakecase",
        },
    })

    vim.keymap.set("n", "<leader>gsj", "<cmd>GoTagAdd json<CR>", { desc = "Add json struct tags" })
    vim.keymap.set("n", "<leader>gsy", "<cmd>GoTagAdd yaml<CR>", { desc = "Add yaml struct tags" })
end

return M
