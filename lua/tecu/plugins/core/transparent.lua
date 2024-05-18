local M = {
    "xiyaowong/transparent.nvim",
    lazy = false,
}

function M.config()
    local transparent = require("transparent")
    transparent.setup({
        extra_groups = {
            "Normal",
            "NormalNC",
            "NormalSB",
            "NormalFloat",

            "CursorLine",
            "CursorLineNr",
            "FoldColumn",

            "SignColumn",
            "EndOfBuffer",
            "LineNr",

            "NonText",

            "Todo",
            "Comment",
            "Type",
            "String",
            "Function",
            "Conditional",
            "Structure",
            "Operator",
            "Constant",
            "Special",
            "Identifier",
            "Statement",

            "GitSignsAdd",
            "GitSignsChange",
            "GitSignsDelete",

            "NvimTreeNormal",

            "Pmenu",

            "PreProc",
            "Underlined",
            "Repeat",

            "StatusLine",
            "StatusLineNC",

            "FloatBorder",
            "FloatTitle",

            "TelescopeBorder",

            "NoiceCmdline",
            "NoiceCmdlineIcon",
            "NoiceCmdlineIconCalculator",
            "NoiceCmdlineIconCmdline",
            "NoiceCmdlineIconFilter",
            "NoiceCmdlineIconHelp",
            "NoiceCmdlineIconIncRename",
            "NoiceCmdlineIconInput",
            "NoiceCmdlineIconLua",
            "NoiceCmdlineIconSearch",
            "NoiceCmdlinePopup",
            "NoiceCmdlinePopupBorder",
            "NoiceCmdlinePopupBorderCalculator",
            "NoiceCmdlinePopupBorderCmdline",
            "NoiceCmdlinePopupBorderFilter",
            "NoiceCmdlinePopupBorderHelp",
            "NoiceCmdlinePopupBorderIncRename",
            "NoiceCmdlinePopupBorderInput",
            "NoiceCmdlinePopupBorderLua",
            "NoiceCmdlinePopupBorderSearch",
            "NoiceCmdlinePopupTitle",
            "NoiceCmdlinePrompt",
            "NoiceCompletionItemKindClass",
            "NoiceCompletionItemKindColor",
            "NoiceCompletionItemKindConstant",
            "NoiceCompletionItemKindConstructor",
            "NoiceCompletionItemKindDefault",
            "NoiceCompletionItemKindEnum",
            "NoiceCompletionItemKindEnumMember",
            "NoiceCompletionItemKindField",
            "NoiceCompletionItemKindFile",
            "NoiceCompletionItemKindFolder",
            "NoiceCompletionItemKindFunction",
            "NoiceCompletionItemKindInterface",
            "NoiceCompletionItemKindKeyword",
            "NoiceCompletionItemKindMethod",
            "NoiceCompletionItemKindModule",
            "NoiceCompletionItemKindProperty",
            "NoiceCompletionItemKindSnippet",
            "NoiceCompletionItemKindStruct",
            "NoiceCompletionItemKindText",
            "NoiceCompletionItemKindUnit",
            "NoiceCompletionItemKindValue",
            "NoiceCompletionItemKindVariable",
            "NoiceCompletionItemMenu",
            "NoiceCompletionItemWord",
            "NoiceConfirm",
            "NoiceConfirmBorder",
            "NoiceCursor",
            "NoiceFormatConfirm",
            "NoiceFormatConfirmDefault",
            "NoiceFormatDate",
            "NoiceFormatEvent",
            "NoiceFormatKind",
            "NoiceFormatLevelDebug",
            "NoiceFormatLevelError",
            "NoiceFormatLevelInfo",
            "NoiceFormatLevelOff",
            "NoiceFormatLevelTrace",
            "NoiceFormatLevelWarn",
            "NoiceFormatProgressDone",
            "NoiceFormatProgressTodo",
            "NoiceFormatTitle",
            "NoiceLspProgressClient",
            "NoiceLspProgressSpinner",
            "NoiceLspProgressTitle",
            "NoiceMini",
            "NoicePopup",
            "NoicePopupBorder",
            "NoicePopupmenu",
            "NoicePopupmenuBorder",
            "NoicePopupmenuMatch",
            "NoicePopupmenuSelected",
            "NoiceScrollbar",
            "NoiceScrollbarThumb",
            "NoiceSplit",
            "NoiceSplitBorder",
            "NoiceVirtualText",

            "NotifyBackground",
        },
    })
    transparent.clear_prefix("BufferLine")
    transparent.clear_prefix("NeoTree")
    transparent.clear_prefix("lualine")

    vim.keymap.set("n", "<leader>td", ":TransparentDisable<cr>")
    vim.keymap.set("n", "<leader>te", ":TransparentEnable<cr>")
    vim.keymap.set("n", "<leader>tb", ":TransparentToggle<cr>")
end

return M
