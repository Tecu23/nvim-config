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
