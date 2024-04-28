local M = {
    -- Add indentation guides even on blank lines
    "lukas-reineke/indent-blankline.nvim",
    event = "User FilePost",
    -- Enable `lukas-reineke/indent-blankline.nvim`
    -- See `:help ibl`
    main = "ibl",
    opts = {},
}

function M.config()
    require("ibl").setup({
        scope = {
            show_start = false,
        },
    })
end

return M
