local M = {
    -- "gc" to comment visual regions/lines
    "numToStr/Comment.nvim",
}

function M.config()
    -- "_" is the mapping of / so that <C-_> is actually <C-/>
    vim.keymap.set("n", "<C-_>", "<Plug>(comment_toggle_linewise_current)", { desc = "Comment line" })
    vim.keymap.set("v", "<C-_>", "<Plug>(comment_toggle_linewise_visual)", { desc = "Comment line" })
    vim.keymap.set("n", "<leader>/", "<Plug>(comment_toggle_linewise_current)", { desc = "Comment line" })
    vim.keymap.set("v", "<leader>/", "<Plug>(comment_toggle_linewise_visual)", { desc = "Comment line" })
end

return M
