local M = {
    "akinsho/toggleterm.nvim",
}

function M.config()
    require("toggleterm").setup({
        size = function(term)
            if term.direction == "horizontal" then
                return vim.o.lines * 0.4
            elseif term.direction == "vertical" then
                return vim.o.columns * 0.5
            end
        end,
        open_mapping = [[<c-\>]],
        hide_numbers = true,
        shade_terminals = false,
        insert_mappings = true,
        persist_size = true,
        direction = "float",
        close_on_exit = true,
        shell = vim.o.shell,
        autochdir = true,
        highlights = {
            NormalFloat = {
                link = "Normal",
            },
            FloatBorder = {
                link = "FloatBorder",
            },
        },
        float_opts = {
            border = "rounded",
            height = math.ceil(vim.o.lines * 1.0 - 4),
            width = math.ceil(vim.o.columns * 1.0),
            winblend = 0,
        },
    })
    vim.keymap.set(
        "n",
        "<leader>tt",
        "<cmd>ToggleTerm direction=float<cr>",
        { desc = "Toggle Terminal", silent = true }
    )
    vim.keymap.set(
        "n",
        "<leader>th",
        "<cmd>ToggleTerm direction=horizontal<cr>",
        { desc = "Horizontal Terminal", silent = true }
    )
    vim.keymap.set(
        "n",
        "<leader>tv",
        "<cmd>ToggleTerm direction=vertical<cr>",
        { desc = "Vertical Terminal", silent = true }
    )
end

return M
