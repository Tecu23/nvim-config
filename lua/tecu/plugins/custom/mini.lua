-- Collection of various small independent plugins/modules
local M = {
    "echasnovski/mini.nvim",
}

function M.config()
    -- Better Around/Inside textobjects
    require("mini.ai").setup({ n_lines = 500 })

    -- Add/delete/replace surroundings (brackets, quotes, etc.)
    require("mini.surround").setup({

        custom_surrounding = nil,
        --
        -- Duration (in ms) of highlight when calling `MiniSurround.highlight()`
        highlight_duration = 500,

        mappings = {
            add = "<leader>sa", -- Add surrounding in Normal and Visual modes
            delete = "<leader>sd", -- Delete surrounding
            find = "<leader>sf", -- Find surrounding (to the right)
            find_left = "<leader>sF", -- Find surrounding (to the left)
            highlight = "<leader>sh", -- Highlight surrounding
            replace = "<leader>sr", -- Replace surrounding
            update_n_lines = "<leader>sn", -- Update `n_lines`

            suffix_last = "l", -- Suffix to search with "prev" method
            suffix_next = "n", -- Suffix to search with "next" method
        },

        -- Number of lines within which surrounding is searched
        n_lines = 20,

        -- Whether to respect selection type:
        -- - Place surroundings on separate lines in linewise mode.
        -- - Place surroundings on each line in blockwise mode.
        respect_selection_type = false,

        -- How to search for surrounding (first inside current line, then inside
        -- neighborhood). One of 'cover', 'cover_or_next', 'cover_or_prev',
        -- 'cover_or_nearest', 'next', 'prev', 'nearest'. For more details,
        -- see `:h MiniSurround.config`.
        search_method = "cover",

        -- Whether to disable showing non-error feedback
        silent = false,
    })

    -- Simple and easy statusline.
    local statusline = require("mini.statusline")

    -- set use_icons to true if you have a Nerd Font
    statusline.setup({ use_icons = vim.g.have_nerd_font })

    -- You can configure sections in the statusline by overriding their
    -- default behavior. For example, here we set the section for
    -- cursor location to LINE:COLUMN
    ---@diagnostic disable-next-line: duplicate-set-field
    statusline.section_location = function()
        return "%2l:%-2v"
    end
end

return M
