# Current Neovim Config

Testing ground for neovim config.

## Keymaps

leader = `space`

### Base

#### Movement

|Mode|Shortcut|Action|Description|
|----|--------|------|-----------|
|n| `<Esc>`| `:nohlsearch`|Clear search Highlight|
|n| n | nzz| Keep Screen Centered|
|n| N | Nzz| Keep Screen Centered|
|n| `<Ctrl-d>`| `<Ctrl-d>`zz| Keep Screen Centered|
|n| `<Ctrl-u>`| `<Ctrl-u>`zz| Keep Screen Centered|
|n| `<Ctrl-h>`| `<Ctrl-w><Ctrl-h>`| Move Focus to the left window|
|n| `<Ctrl-l>`| `<Ctrl-w><Ctrl-l>`| Move Focus to the right window|
|n| `<Ctrl-j>`| `<Ctrl-w><Ctrl-j>`| Move Focus to the lower window|
|n| `<Ctrl-k>`| `<Ctrl-w><Ctrl-k>`| Move Focus to the upper window|
|n| `<Shift-k>`| `<Ctrl-w><Ctrl-k>`| Move Focus to the upper window|

vim.keymap.set("v", "<", "<gv", { desc = "Stay in indent mode" })
vim.keymap.set("v", ">", ">gv", { desc = "Stay in indent mode" })

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move block down in visual mode" })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move block up in visual mode" })

vim.keymap.set({ "n", "o", "x" }, "<s-h>", "^", { desc = "Move to start of the line" })
vim.keymap.set({ "n", "o", "x" }, "<s-l>", "g_", { desc = "Move to start of the line" })

-- tailwind bearable to work with
vim.keymap.set({ "n", "x" }, "j", "gj", {})
vim.keymap.set({ "n", "x" }, "k", "gk", {})

-- keep yanked text when pasting in visual mode
vim.keymap.set("v", "p", [["_dP]], { desc = "Keep the yanked text when pasting in visual  mode" })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- TIP: Disable arrow keys in normal mode
vim.keymap.set("n", "<left>", '<cmd>echo "Use h to move!!"<CR>')
vim.keymap.set("n", "<right>", '<cmd>echo "Use l to move!!"<CR>')
vim.keymap.set("n", "<up>", '<cmd>echo "Use k to move!!"<CR>')
vim.keymap.set("n", "<down>", '<cmd>echo "Use j to move!!"<CR>')

### Comment

    vim.keymap.set("n", "<C-_>", "<Plug>(comment_toggle_linewise_current)", { desc = "Comment line" })
    vim.keymap.set("v", "<C-_>", "<Plug>(comment_toggle_linewise_visual)", { desc = "Comment line" })
    vim.keymap.set("n", "<leader>/", "<Plug>(comment_toggle_linewise_current)", { desc = "Comment line" })
    vim.keymap.set("v", "<leader>/", "<Plug>(comment_toggle_linewise_visual)", { desc = "Comment line" })

### Telescope

    vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "[F]ind [H]elp" })
    vim.keymap.set("n", "<leader>fk", builtin.keymaps, { desc = "[F]ind [K]eymaps" })
    vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "[F]ind [F]iles" })
    vim.keymap.set("n", "<leader>fs", builtin.builtin, { desc = "[F]ind [S]elect Telescope" })
    vim.keymap.set("n", "<leader>fw", builtin.grep_string, { desc = "[F]ind current [W]ord" })
    vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "[F]ind by [G]rep" })
    vim.keymap.set("n", "<leader>fb", builtin.git_branches, { desc = "[F]ind Git [B]ranches" })
    vim.keymap.set("n", "<leader>fd", builtin.diagnostics, { desc = "[F]ind [D]iagnostics" })
    vim.keymap.set("n", "<leader>fr", builtin.resume, { desc = "[F]ind [R]esume" })
    vim.keymap.set("n", "<leader>f.", builtin.oldfiles, { desc = '[F]ind Recent Files ("." for repeat)' })
    vim.keymap.set("n", "<leader><leader>", builtin.buffers, { desc = "[ ] Find existing buffers" })

    -- Slightly advanced example of overriding default behavior and theme
    vim.keymap.set("n", "<leader>/", function()
        -- You can pass additional configuration to Telescope to change the theme, layout, etc.
        builtin.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
            winblend = 10,
            previewer = false,
        }))
    end, { desc = "[/] Fuzzily search in current buffer" })

    -- It's also possible to pass additional configuration options.
    --  See `:help telescope.builtin.live_grep()` for information about particular keys
    vim.keymap.set("n", "<leader>f/", function()
        builtin.live_grep({
            grep_open_files = true,
            prompt_title = "Live Grep in Open Files",
        })
    end, { desc = "[F]ind [/] in Open Files" })

    -- Shortcut for searching your Neovim configuration files
    vim.keymap.set("n", "<leader>fn", function()
        builtin.find_files({ cwd = vim.fn.stdpath("config") })
    end, { desc = "[F]ind [N]eovim files" })

### LSP

    -- Jump to the definition of the word under your cursor.
    --  This is where a variable was first declared, or where a function is defined, etc.
    --  To jump back, press <C-t>.
    map("gd", require("telescope.builtin").lsp_definitions, "[G]oto [D]efinition")

    -- Find references for the word under your cursor.
    map("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")

    -- Jump to the implementation of the word under your cursor.
    --  Useful when your language has ways of declaring types without an actual implementation.
    map("gI", require("telescope.builtin").lsp_implementations, "[G]oto [I]mplementation")

    -- Jump to the type of the word under your cursor.
    --  Useful when you're not sure what type a variable is and you want to see
    --  the definition of its *type*, not where it was *defined*.
    map("<leader>D", require("telescope.builtin").lsp_type_definitions, "Type [D]efinition")

    -- Fuzzy find all the symbols in your current document.
    --  Symbols are things like variables, functions, types, etc.
    map("<leader>ds", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")

    -- Fuzzy find all the symbols in your current workspace.
    --  Similar to document symbols, except searches over your entire project.
    map("<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")

    -- Rename the variable under your cursor.
    --  Most Language Servers support renaming across files, etc.
    map("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")

    -- Execute a code action, usually your cursor needs to be on top of an error
    -- or a suggestion from your LSP for this to activate.
    map("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")

    -- Move forward/backward through diagnostics
    map("<leader>lj", vim.diagnostic.goto_next, "[N]ext [D]iagnostic")
    map("<leader>lk", vim.diagnostic.goto_prev, "[P]rev [D]iagnostic")

    -- Opens a popup that displays documentation about the word under your cursor
    --  See `:help K` for why this keymap.
    map("K", vim.lsp.buf.hover, "Hover Documentation")

    -- this is Goto Declaration.
    --  For example, in C this would take you to the header.
    map("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")

### Harpoon

|Mode|Shortcut|Description|
|----|--------|-----------|
|n| `<TAB>` | Open Harpooon Menu|
|n| `<Meta-m>`|Add the current pageto harpoon list|
|n| `<Meta-n>`| Remove the current page from harppon|
|n| `<Ctrl-q>`| Move to the previous element|
|n| `<Ctrl-w>`| Move to the next element|
