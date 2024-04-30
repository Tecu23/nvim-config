local M = {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    ft = { "markdown" },
    build = function()
        vim.fn["mkdp#util#install"]()
    end,
}

function M.config()
    vim.keymap.set("n", "<leader>mp", "<cmd>MarkdownPreview<CR>", { desc = "Open MarkdownPreview " })
    vim.keymap.set("n", "<leader>ms", "<cmd>MarkdownPreviewStop<CR>", { desc = "Stop MarkdownPreview " })
    vim.keymap.set("n", "<leader>mt", "<cmd>MarkdownPreviewToggle<CR>", { desc = "Toggle MarkdownPreview " })
end

return M
