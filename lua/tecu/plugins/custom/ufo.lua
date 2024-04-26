local M = {
    "kevinhwang91/nvim-ufo",
    event = "User FilePost",
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
                    segments = {
                        { text = { builtin.foldfunc, " " }, click = "v:lua.ScFa" },
                        { text = { builtin.lnumfunc, " " }, click = "v:lua.ScLa" },
                        { text = { "%s" }, click = "v:lua.ScSa" },
                    },
                })
            end,
        },
    },
}

function M.config()
    require("ufo").setup({
        provider_selector = function(_, _, _)
            return { "treesitter", "indent" }
        end,
    })

    -- Using ufo provider need remap `zR` and `zM`. If Neovim is 0.6.1, remap yourself
    vim.keymap.set("n", "zR", require("ufo").openAllFolds)
    vim.keymap.set("n", "zM", require("ufo").closeAllFolds)
end

return M
