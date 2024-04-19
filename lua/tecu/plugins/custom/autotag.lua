local M = {
    "windwp/nvim-ts-autotag",
    ft = {
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
