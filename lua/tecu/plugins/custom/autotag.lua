local M = {
    "windwp/nvim-ts-autotag",
    filetypes = {
        "javascript",
        "javascriptreact",
        "typescript",
        "typescriptreact",
    },
}

function M.config()
    require("nvim-ts-autotag").setup()
end

return M
