local M = {
    "folke/which-key.nvim",
    event = "VimEnter",
    keys = {
        {
            "<leader>?",
            function()
                require("which-key").show({ global = false })
            end,
            desc = "Buffer Local Keymaps (which-key)",
        },
    },
}

function M.config()
    local which_key = require("which-key")
    which_key.setup({})
end

return M
