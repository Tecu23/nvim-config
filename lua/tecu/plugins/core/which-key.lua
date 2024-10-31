local M = {
    "folke/which-key.nvim",
    event = "VimEnter",
}

function M.config()
    local which_key = require("which-key")
    which_key.setup()
end

return M
