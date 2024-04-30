local M = {
    "kevinhwang91/nvim-ufo",
    event = { "BufReadPost", "BufNewFile" },
    lazy = true,
    init = function()
        vim.o.foldcolumn = "1"
        vim.o.foldlevel = 99
        vim.o.foldlevelstart = 99
        vim.o.foldenable = true
        vim.o.foldmethod = "indent"
    end,
    dependencies = {
        "kevinhwang91/promise-async",
        {
            "luukvbaal/statuscol.nvim",
            config = function()
                local builtin = require("statuscol.builtin")
                require("statuscol").setup({
                    relculright = true,
                    ft_ignore = {},
                    segments = {
                        -- Diagnostics
                        {
                            sign = { name = { "Diagnostic" }, maxwidth = 2, auto = false },
                            click = "v:lua.ScSa",
                        },

                        -- Folds
                        {
                            text = { builtin.foldfunc },
                        },
                        -- Relative Line Numbers
                        {
                            text = { builtin.lnumfunc },
                            condition = { true, builtin.not_empty },
                        },

                        -- Gitsigns
                        {
                            sign = {
                                namespace = { "gitsigns" },
                                maxwidth = 1,
                                colwidth = 1,
                                wrap = true,
                            },
                        },
                    },
                })
            end,
        },
    },
}
function M.config()
    require("ufo").setup({
        open_fold_hl_timeout = 150,
        enable_get_fold_virt_text = true,
        close_fold_kinds_for_ft = {
            default = { "imports", "comment" },
        },
        preview = {
            win_config = {
                border = { "", "─", "", "", "", "─", "", "" },
                winhighlight = "Normal:Folded",
                winblend = 0,
            },
            mappings = {
                scrollU = "<C-u>",
                scrollD = "<C-d>",
                jumpTop = "[",
                jumpBot = "]",
            },
        },
        provider_fold_virt_text_handler = function(text, lnum, endLnum, width)
            local suffix = "  "
            local lines = ("[%d lines] "):format(endLnum - lnum)

            local cur_width = 0
            for _, section in ipairs(text) do
                cur_width = cur_width + vim.fn.strdisplaywidth(section[1])
            end

            suffix = suffix .. (" "):rep(width - cur_width - vim.fn.strdisplaywidth(lines) - 3)

            table.insert(text, { suffix, "Comment" })
            table.insert(text, { lines, "Todo" })
            return text
        end,
        provider_selector = function(_, _, _)
            return { "lsp", "indent" }
        end,
    })

    -- Using ufo provider need remap `zR` and `zM`. If Neovim is 0.6.1, remap yourself
    vim.keymap.set("n", "zR", require("ufo").openAllFolds)
    vim.keymap.set("n", "zM", require("ufo").closeAllFolds)
end

return M
