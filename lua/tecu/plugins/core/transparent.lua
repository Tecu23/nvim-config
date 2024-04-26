local M = {
    "xiyaowong/transparent.nvim",
    lazy = false,
}

function M.config()
    local transparent = require("transparent")
    transparent.setup({
        extra_groups = {
            "NormalFloat",
            "NvimTreeNormal",
            "Normal",
            "NormalNC",
            "Comment",
            "Constant",
            "Special",
            "Identifier",
            "Statement",
            "PreProc",
            "Type",
            "Underlined",
            "Todo",
            "String",
            "Function",
            "Conditional",
            "Repeat",
            "Operator",
            "Structure",
            "LineNr",
            "NonText",
            "SignColumn",
            "CursorLine",
            "CursorLineNr",
            "StatusLine",
            "StatusLineNC",
            "EndOfBuffer",
        },
    })
    transparent.clear_prefix("BufferLine")
    transparent.clear_prefix("NeoTree")
    transparent.clear_prefix("lualine")

    vim.keymap.set("n", "<leader>td", ":TransparentDisable<cr>")
    vim.keymap.set("n", "<leader>te", ":TransparentEnable<cr>")
end

return M
