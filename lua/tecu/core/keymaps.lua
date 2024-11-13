-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- Diagnostic keymaps
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })

-- Delete / Yank All text
vim.keymap.set("n", "<leader>D", "<cmd>%d+<cr>", { desc = "General | Delete All Text", silent = true })
vim.keymap.set("n", "<leader>Y", "<cmd>%y+<cr>", { desc = "General | Yank All Text", silent = true })

-- Keep screen centered
vim.keymap.set("n", "n", "nzz", {})
vim.keymap.set("n", "N", "Nzz", {})
vim.keymap.set("n", "<C-d>", "<C-d>zz", {})
vim.keymap.set("n", "<C-u>", "<C-u>zz", {})

vim.keymap.set("v", "<", "<gv", { desc = "Stay in indent mode" })
vim.keymap.set("v", ">", ">gv", { desc = "Stay in indent mode" })

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move block down in visual mode" })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move block up in visual mode" })

vim.keymap.set({ "n", "o", "x" }, "<s-h>", "^", { desc = "Move to start of the line" })
vim.keymap.set({ "n", "o", "x" }, "<s-l>", "g_", { desc = "Move to start of the line" })

-- tailwind bearable to work with
vim.keymap.set({ "n", "x" }, "j", "gj", {})
vim.keymap.set({ "n", "x" }, "k", "gk", {})
vim.keymap.set("n", "<leader>w", ":lua vim.wo.wrap = not vim.wo.wrap<CR>", {})

-- keep yanked text when pasting in visual mode
vim.keymap.set("v", "p", [["_dP]], { desc = "Keep the yanked text when pasting in visual  mode" })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- TIP: Disable arrow keys in normal mode
vim.keymap.set("n", "<left>", '<cmd>echo "Use h to move!!"<CR>')
vim.keymap.set("n", "<right>", '<cmd>echo "Use l to move!!"<CR>')
vim.keymap.set("n", "<up>", '<cmd>echo "Use k to move!!"<CR>')
vim.keymap.set("n", "<down>", '<cmd>echo "Use j to move!!"<CR>')

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

-- Inspect
vim.keymap.set("n", "<leader>ni", function()
	if vim.version().minor >= 9 then
		vim.cmd("Inspect")
	else
		vim.notify("Inspect isn't available in this neovim version", vim.log.levels.WARN, { title = "Inspect" })
	end
end, { desc = "[N]eovim Inspect", silent = true }) -- only available on neovim >= 0.9

-- Messages
vim.keymap.set("n", "<leader>nm", "<cmd>messages<cr>", { desc = "[N]eovim Messages", silent = true })

-- Health
vim.keymap.set("n", "<leader>nh", "<cmd>checkhealth<cr>", { desc = "[N]eovim Health", silent = true })

-- Version
vim.keymap.set("n", "<leader>nv", function()
	local version = vim.version().major .. "." .. vim.version().minor .. "." .. vim.version().patch
	return vim.notify(version, vim.log.levels.INFO, { title = "Neovim Version" })
end, { desc = "[N]eovim Version", silent = true })

-- Golang KeyMaps
vim.keymap.set("n", "<leader>gsj", "<cmd> GoTagAdd json <CR>", { desc = "Add json struct tags" })
vim.keymap.set("n", "<leader>gsy", "<cmd> GoTagAdd yaml <CR>", { desc = "Add yaml struct tags" })

--  Typescript Tools Code Actions
vim.keymap.set("n", "<leader>cto", "<cmd>TSToolsOrganizeImports<cr>", { desc = "[C]ode [T]ypeScript Organize Imports" })
vim.keymap.set("n", "<leader>cts", "<cmd>TSToolsSortImports<cr>", { desc = "[C]ode [T]ypeScript Sort Imports" })
vim.keymap.set(
	"n",
	"<leader>ctu",
	"<cmd>TSToolsRemoveUnusedImports<cr>",
	{ desc = "[C]ode [T]ypeScript Remove Unused Imports" }
)
vim.keymap.set("n", "<leader>ctU", "<cmd>TSToolsRemoveUnused<cr>", { desc = "[C]ode [T]ypeScript Remove All Unused" })
vim.keymap.set(
	"n",
	"<leader>cta",
	"<cmd>TSToolsAddMissingImports<cr>",
	{ desc = "[C]ode [T]ypeScript Add Missing Imports" }
)
vim.keymap.set("n", "<leader>ctf", "<cmd>TSToolsFixAll<cr>", { desc = "[C]ode [T]ypeScript Fix All Fixable Errors" })
vim.keymap.set("n", "<leader>ctr", "<cmd>TSToolsRenameFile<cr>", { desc = "[C]ode [T]ypeScript Rename Current File" })
vim.keymap.set(
	"n",
	"<leader>ctR",
	"<cmd>TSToolsFileReferences<cr>",
	{ desc = "[C]ode [T]ypeScript Find All References" }
)
