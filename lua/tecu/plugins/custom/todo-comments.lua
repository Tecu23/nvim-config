-- Highlight todo, notes, etc in comments
local M = {
    'folke/todo-comments.nvim',
    event = 'VimEnter',
    dependencies = {
        'nvim-lua/plenary.nvim'
    },
    opts = { signs = false }
}

function M.config()
    require('todo-comments').setup()
end


return M
