local M = {
    "folke/which-key.nvim",
    event = "VimEnter",
}

function M.config()
    local mappings = {
        a = {
            name = "Tab",
            n = { "<cmd>$tabnew<cr>", "New Empty Tab" },
            N = { "<cmd>tabnew %<cr>", "New Tab" },
            o = { "<cmd>tabonly<cr>", "Only" },
            h = { "<cmd>-tabmove<cr>", "Move Left" },
            l = { "<cmd>+tabmove<cr>", "Move Right" },
        },
        b = { name = "Buffers" },
        c = { name = "[C]ode" },
        d = { name = "[D]ebug" },
        -- ["<leader>d"] = { name = "[D]ocument", _ = "which_key_ignore" },
        f = { name = "[F]ind" },
        g = { name = "[G]it" },
        h = { "<cmd>nohlsearch<CR>", "NOHL" },
        -- ["<leader>h"] = { name = "Git [H]unk", _ = "which_key_ignore" },
        l = { name = "[L]SP" },
        p = { name = "[P]lugins" },
        q = { "<cmd>confirm q<CR>", "Quit" },
        r = { name = "[R]ename" },
        s = { name = "[S]earch" },
        t = { name = "[T]est" },
        -- ["<leader>t"] = { name = "[T]oggle", _ = "which_key_ignore" },
        T = { name = "[T]reesitter" },
        v = { "<cmd>vsplit<CR>", "Split" },
        w = { name = "[W]orkspace" },

        [";"] = { "<cmd>tabnew | terminal<CR>", "Term" },
    }

    local which_key = require("which-key")
    which_key.setup({
        plugins = {
            marks = true,
            registers = true,
            spelling = {
                enabled = true,
                suggestions = 20,
            },
            presets = {
                operators = false,
                motions = false,
                text_objects = false,
                windows = false,
                nav = false,
                z = false,
                g = false,
            },
        },
        window = {
            border = "rounded",
            position = "bottom",
            padding = { 2, 2, 2, 2 },
        },
        ignore_missing = true,
        show_help = false,
        show_keys = false,
        disable = {
            buftypes = {},
            filetypes = { "TelescopePrompt" },
        },
    })

    local opts = {
        mode = "n", -- NORMAL mode
        prefix = "<leader>",
    }

    which_key.register(mappings, opts)
end

return M
