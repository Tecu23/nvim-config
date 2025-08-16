-- ============================================================================
-- Neovim Keymaps Configuration for Full-Stack Development
-- ============================================================================
local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

-- ============================================================================
-- Helper Functions
-- ============================================================================

-- Add description to opts
local function with_desc(desc)
	return vim.tbl_extend("force", opts, { desc = desc })
end

-- ============================================================================
-- General Keymaps
-- ============================================================================

-- Disable arrow keys in normal mode
keymap("n", "<left>", '<cmd>echo "Use h to move!!"<CR>')
keymap("n", "<right>", '<cmd>echo "Use l to move!!"<CR>')
keymap("n", "<up>", '<cmd>echo "Use k to move!!"<CR>')
keymap("n", "<down>", '<cmd>echo "Use j to move!!"<CR>')

-- Better escape (jk or jj to exit insert mode)
keymap("i", "jk", "<ESC>", with_desc("Exit insert mode"))
keymap("i", "jj", "<ESC>", with_desc("Exit insert mode"))

-- Clear search highlights
keymap("n", "<Esc>", "<cmd>nohlsearch<CR>", with_desc("Clear search highlights"))
keymap("n", "<leader>h", "<cmd>nohlsearch<CR>", with_desc("Clear highlights"))

-- Save with Ctrl+S (works in all modes)
keymap({ "n", "i", "v" }, "<C-s>", "<cmd>w<CR>", with_desc("Save file"))

-- Select all
keymap("n", "<C-a>", "gg<S-v>G", with_desc("Select all"))

-- Save and quit shortcuts
keymap("n", "<leader>w", "<cmd>w<CR>", with_desc("Save file"))
keymap("n", "<leader>W", "<cmd>wa<CR>", with_desc("Save all files"))
keymap("n", "<leader>q", "<cmd>q<CR>", with_desc("Quit"))
keymap("n", "<leader>Q", "<cmd>qa<CR>", with_desc("Quit all"))
keymap("n", "<leader>x", "<cmd>x<CR>", with_desc("Save and quit"))

-- Delete without yanking
keymap({ "n", "v" }, "<leader>d", '"_d', with_desc("Delete without yanking"))
keymap({ "n", "v" }, "<leader>D", '"_D', with_desc("Delete line without yanking"))
keymap({ "n", "v" }, "<leader>c", '"_c', with_desc("Change without yanking"))
keymap({ "n", "v" }, "<leader>C", '"_C', with_desc("Change line without yanking"))

-- keep yanked text when pasting in visual mode
keymap("v", "p", [["_dP]], with_desc("Keep the yanked text when pasting in visual  mode"))

-- Replace word under cursor
keymap(
	"n",
	"<leader>rw",
	[[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],
	with_desc("Replace word under cursor")
)

-- Toggle wrap
keymap("n", "<leader>uw", "<cmd>set wrap!<CR>", with_desc("Toggle word wrap"))

-- Toggle spell check
keymap("n", "<leader>us", "<cmd>set spell!<CR>", with_desc("Toggle spell check"))

-- Toggle relative numbers
keymap("n", "<leader>un", "<cmd>set relativenumber!<CR>", with_desc("Toggle relative numbers"))

-- Inspect
keymap("n", "<leader>ni", function()
	if vim.version().minor >= 9 then
		vim.cmd("Inspect")
	else
		vim.notify("Inspect isn't available in this neovim version", vim.log.levels.WARN, { title = "Inspect" })
	end
end, with_desc("[N]eovim Inspect")) -- only available on neovim >= 0.9

-- Messages
keymap("n", "<leader>nm", "<cmd>messages<cr>", with_desc("[N]eovim Messages"))

-- Health
keymap("n", "<leader>nh", "<cmd>checkhealth<cr>", with_desc("[N]eovim Health"))

-- Version
keymap("n", "<leader>nv", function()
	local version = vim.version().major .. "." .. vim.version().minor .. "." .. vim.version().patch
	return vim.notify(version, vim.log.levels.INFO, { title = "Neovim Version" })
end, with_desc("[N]eovim Version"))

-- ============================================================================
-- Movement Keymaps
-- ============================================================================

-- Better up/down (works with word wrap)
keymap({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
keymap({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })

-- Move to beginning/end of line
keymap({ "n", "v" }, "H", "^", with_desc("Move to beginning of line"))
keymap({ "n", "v" }, "L", "$", with_desc("Move to end of line"))

-- Center cursor after jumping
keymap("n", "<C-d>", "<C-d>zz", with_desc("Jump down half page"))
keymap("n", "<C-u>", "<C-u>zz", with_desc("Jump up half page"))
keymap("n", "n", "nzzzv", with_desc("Next search result"))
keymap("n", "N", "Nzzzv", with_desc("Previous search result"))
keymap("n", "*", "*zzzv", with_desc("Search word under cursor"))
keymap("n", "#", "#zzzv", with_desc("Search word under cursor backwards"))
keymap("n", "g*", "g*zzzv", with_desc("Search partial word under cursor"))
keymap("n", "g#", "g#zzzv", with_desc("Search partial word backwards"))

-- Jump between paragraphs
keymap("n", "}", "}zz", with_desc("Next paragraph"))
keymap("n", "{", "{zz", with_desc("Previous paragraph"))

-- tailwind bearable to work with
keymap({ "n", "x" }, "j", "gj", {})
keymap({ "n", "x" }, "k", "gk", {})
keymap("n", "<leader>w", ":lua vim.wo.wrap = not vim.wo.wrap<CR>", {})

-- ============================================================================
-- Window Management
-- ============================================================================

-- Split windows
keymap("n", "<leader>sv", "<C-w>v", with_desc("Split window vertically"))
keymap("n", "<leader>sh", "<C-w>s", with_desc("Split window horizontally"))
keymap("n", "<leader>se", "<C-w>=", with_desc("Make splits equal size"))
keymap("n", "<leader>sx", "<cmd>close<CR>", with_desc("Close current split"))
keymap("n", "<leader>sm", "<cmd>MaximizerToggle<CR>", with_desc("Maximize/minimize split"))

-- Navigate between windows
keymap("n", "<C-h>", "<C-w>h", with_desc("Move to left window"))
keymap("n", "<C-j>", "<C-w>j", with_desc("Move to lower window"))
keymap("n", "<C-k>", "<C-w>k", with_desc("Move to upper window"))
keymap("n", "<C-l>", "<C-w>l", with_desc("Move to right window"))

-- Resize windows with arrow keys
keymap("n", "<C-Up>", "<cmd>resize +2<CR>", with_desc("Increase window height"))
keymap("n", "<C-Down>", "<cmd>resize -2<CR>", with_desc("Decrease window height"))
keymap("n", "<C-Left>", "<cmd>vertical resize -2<CR>", with_desc("Decrease window width"))
keymap("n", "<C-Right>", "<cmd>vertical resize +2<CR>", with_desc("Increase window width"))

-- Alternative resize with Alt + hjkl
keymap("n", "<M-j>", "<cmd>resize -2<CR>", with_desc("Decrease window height"))
keymap("n", "<M-k>", "<cmd>resize +2<CR>", with_desc("Increase window height"))
keymap("n", "<M-h>", "<cmd>vertical resize -2<CR>", with_desc("Decrease window width"))
keymap("n", "<M-l>", "<cmd>vertical resize +2<CR>", with_desc("Increase window width"))

-- ============================================================================
-- Tab Management
-- ============================================================================

keymap("n", "<leader>to", "<cmd>tabnew<CR>", with_desc("Open new tab"))
keymap("n", "<leader>tx", "<cmd>tabclose<CR>", with_desc("Close current tab"))
keymap("n", "<leader>tn", "<cmd>tabn<CR>", with_desc("Next tab"))
keymap("n", "<leader>tp", "<cmd>tabp<CR>", with_desc("Previous tab"))
keymap("n", "<leader>tf", "<cmd>tabnew %<CR>", with_desc("Open current buffer in new tab"))

-- Quick tab navigation
keymap("n", "<leader>1", "1gt", with_desc("Go to tab 1"))
keymap("n", "<leader>2", "2gt", with_desc("Go to tab 2"))
keymap("n", "<leader>3", "3gt", with_desc("Go to tab 3"))
keymap("n", "<leader>4", "4gt", with_desc("Go to tab 4"))
keymap("n", "<leader>5", "5gt", with_desc("Go to tab 5"))

-- ============================================================================
-- Buffer Management
-- ============================================================================

keymap("n", "<leader>bd", "<cmd>bdelete<CR>", with_desc("Delete buffer"))
keymap("n", "<leader>bD", "<cmd>bdelete!<CR>", with_desc("Force delete buffer"))
keymap("n", "<leader>bn", "<cmd>bnext<CR>", with_desc("Next buffer"))
keymap("n", "<leader>bp", "<cmd>bprevious<CR>", with_desc("Previous buffer"))
keymap("n", "<leader>bb", "<cmd>b#<CR>", with_desc("Toggle between buffers"))
keymap("n", "<leader>ba", "<cmd>%bd|e#<CR>", with_desc("Close all buffers except current"))

-- Quick buffer navigation with Tab
keymap("n", "<Tab>", "<cmd>bnext<CR>", with_desc("Next buffer"))
keymap("n", "<S-Tab>", "<cmd>bprevious<CR>", with_desc("Previous buffer"))

-- ============================================================================
-- Visual Mode Keymaps
-- ============================================================================

-- Stay in visual mode after indenting
keymap("v", "<", "<gv", with_desc("Indent left"))
keymap("v", ">", ">gv", with_desc("Indent right"))

-- Move selected lines up/down
keymap("v", "J", ":m '>+1<CR>gv=gv", with_desc("Move selection down"))
keymap("v", "K", ":m '<-2<CR>gv=gv", with_desc("Move selection up"))

-- Alternative with Alt key
keymap("v", "<M-j>", ":m '>+1<CR>gv=gv", with_desc("Move selection down"))
keymap("v", "<M-k>", ":m '<-2<CR>gv=gv", with_desc("Move selection up"))

-- Better paste in visual mode (doesn't yank replaced text)
keymap("v", "p", '"_dP', with_desc("Paste without yanking"))

-- Search for selected text
keymap("v", "//", 'y/<C-R>"<CR>', with_desc("Search for selection"))

-- ============================================================================
-- Insert Mode Keymaps
-- ============================================================================

-- Better navigation in insert mode
keymap("i", "<C-h>", "<Left>", with_desc("Move left"))
keymap("i", "<C-j>", "<Down>", with_desc("Move down"))
keymap("i", "<C-k>", "<Up>", with_desc("Move up"))
keymap("i", "<C-l>", "<Right>", with_desc("Move right"))

-- Quick insertion
keymap("i", "<C-a>", "<ESC>^i", with_desc("Jump to beginning of line"))
keymap("i", "<C-e>", "<End>", with_desc("Jump to end of line"))

-- Add undo break points
keymap("i", ",", ",<c-g>u", opts)
keymap("i", ".", ".<c-g>u", opts)
keymap("i", ";", ";<c-g>u", opts)

-- ============================================================================
-- Terminal Mode Keymaps
-- ============================================================================

-- Exit terminal mode
keymap("t", "<Esc><Esc>", "<C-\\><C-n>", with_desc("Exit terminal mode"))
keymap("t", "jk", "<C-\\><C-n>", with_desc("Exit terminal mode"))

-- Navigate from terminal
keymap("t", "<C-h>", "<C-\\><C-n><C-w>h", with_desc("Move to left window"))
keymap("t", "<C-j>", "<C-\\><C-n><C-w>j", with_desc("Move to lower window"))
keymap("t", "<C-k>", "<C-\\><C-n><C-w>k", with_desc("Move to upper window"))
keymap("t", "<C-l>", "<C-\\><C-n><C-w>l", with_desc("Move to right window"))

-- Open terminal
keymap("n", "<leader>tt", "<cmd>terminal<CR>", with_desc("Open terminal"))
keymap("n", "<leader>tv", "<cmd>vsplit | terminal<CR>", with_desc("Open terminal in vertical split"))
keymap("n", "<leader>th", "<cmd>split | terminal<CR>", with_desc("Open terminal in horizontal split"))
keymap("n", "<leader>tn", "<cmd>tabnew | terminal<CR>", with_desc("Open terminal in new tab"))

-- ============================================================================
-- Quickfix and Location List
-- ============================================================================

keymap("n", "<leader>co", "<cmd>copen<CR>", with_desc("Open quickfix"))
keymap("n", "<leader>cc", "<cmd>cclose<CR>", with_desc("Close quickfix"))
keymap("n", "<leader>cn", "<cmd>cnext<CR>zz", with_desc("Next quickfix item"))
keymap("n", "<leader>cp", "<cmd>cprev<CR>zz", with_desc("Previous quickfix item"))

keymap("n", "<leader>lo", "<cmd>lopen<CR>", with_desc("Open location list"))
keymap("n", "<leader>lc", "<cmd>lclose<CR>", with_desc("Close location list"))
keymap("n", "<leader>ln", "<cmd>lnext<CR>zz", with_desc("Next location item"))
keymap("n", "<leader>lp", "<cmd>lprev<CR>zz", with_desc("Previous location item"))

-- ============================================================================
-- Code Navigation & Editing
-- ============================================================================

-- Code folding
keymap("n", "<leader>za", "za", with_desc("Toggle fold"))
keymap("n", "<leader>zA", "zA", with_desc("Toggle all folds"))
keymap("n", "<leader>zc", "zc", with_desc("Close fold"))
keymap("n", "<leader>zo", "zo", with_desc("Open fold"))
keymap("n", "<leader>zM", "zM", with_desc("Close all folds"))
keymap("n", "<leader>zR", "zR", with_desc("Open all folds"))

-- Jump to matching bracket
keymap({ "n", "v" }, "<leader>m", "%", with_desc("Jump to matching bracket"))

-- Add blank lines without entering insert mode
keymap("n", "<leader>o", "o<Esc>", with_desc("Add line below"))
keymap("n", "<leader>O", "O<Esc>", with_desc("Add line above"))

-- Duplicate lines
keymap("n", "<leader>dd", "yyp", with_desc("Duplicate line"))
keymap("v", "<leader>dd", "y`>p", with_desc("Duplicate selection"))

-- ============================================================================
-- LSP Keymaps (will be active when LSP is attached)
-- ============================================================================

-- These will be set up per buffer when LSP attaches
-- Including them here for reference
local lsp_keymaps = function(bufnr)
	local buf_opts = function(desc)
		return vim.tbl_extend("force", opts, { buffer = bufnr, desc = desc })
	end

	-- Navigation
	keymap("n", "gd", vim.lsp.buf.definition, buf_opts("Go to definition"))
	keymap("n", "gD", vim.lsp.buf.declaration, buf_opts("Go to declaration"))
	keymap("n", "gi", vim.lsp.buf.implementation, buf_opts("Go to implementation"))
	keymap("n", "gr", vim.lsp.buf.references, buf_opts("Show references"))
	keymap("n", "gt", vim.lsp.buf.type_definition, buf_opts("Go to type definition"))

	-- Hover and signature
	keymap("n", "K", vim.lsp.buf.hover, buf_opts("Show hover"))
	keymap("n", "gK", vim.lsp.buf.signature_help, buf_opts("Show signature help"))
	keymap("i", "<C-k>", vim.lsp.buf.signature_help, buf_opts("Show signature help"))

	-- Actions
	keymap("n", "<leader>ca", vim.lsp.buf.code_action, buf_opts("Code action"))
	keymap("v", "<leader>ca", vim.lsp.buf.code_action, buf_opts("Code action"))
	keymap("n", "<leader>rn", vim.lsp.buf.rename, buf_opts("Rename symbol"))
	keymap("n", "<leader>f", vim.lsp.buf.format, buf_opts("Format code"))
	keymap("v", "<leader>f", vim.lsp.buf.format, buf_opts("Format selection"))

	-- Diagnostics
	keymap("n", "<leader>e", vim.diagnostic.open_float, buf_opts("Show diagnostics"))
	keymap("n", "[d", vim.diagnostic.goto_prev, buf_opts("Previous diagnostic"))
	keymap("n", "]d", vim.diagnostic.goto_next, buf_opts("Next diagnostic"))
	keymap("n", "<leader>dl", vim.diagnostic.setloclist, buf_opts("Diagnostics to location list"))

	-- Workspace
	keymap("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, buf_opts("Add workspace folder"))
	keymap("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, buf_opts("Remove workspace folder"))
	keymap("n", "<leader>wl", function()
		print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
	end, buf_opts("List workspace folders"))
end

-- Export LSP keymaps function for use in LSP config
_G.lsp_keymaps = lsp_keymaps

-- ============================================================================
-- Plugin-Specific Keymaps (to be configured when plugins are installed)
-- ============================================================================

-- Telescope (fuzzy finder)
keymap("n", "<leader>sf", "<cmd>Telescope find_files<CR>", with_desc("[S]earch [F]iles"))
keymap("n", "<leader>sg", "<cmd>Telescope live_grep<CR>", with_desc("[S]earch by [G]rep"))
keymap("n", "<leader>sb", "<cmd>Telescope buffers<CR>", with_desc("[S]earch [B]uffers"))
keymap("n", "<leader>sh", "<cmd>Telescope help_tags<CR>", with_desc("[S]earch [H]elp Tags"))
keymap("n", "<leader>sr", "<cmd>Telescope oldfiles<CR>", with_desc("[S]earch [R]ecent Files"))
keymap("n", "<leader>sp", "<cmd>Telescope projects<CR>", with_desc("[S]earch [P]rojects"))
keymap("n", "<leader>sc", "<cmd>Telescope commands<CR>", with_desc("[S]earch [C]ommands"))
keymap("n", "<leader>sk", "<cmd>Telescope keymaps<CR>", with_desc("[S]earch [K]eymaps"))
keymap("n", "<leader>sd", "<cmd>Telescope diagnostics<CR>", with_desc("[S]earch [D]iagnostics"))
keymap("n", "<leader>ss", "<cmd>Telescope builtin<CR>", with_desc("[S]earch [S]elect Telescope"))
keymap("n", "<leader>shi", "<cmd>Telescope highlights<CR>", with_desc("[S]earch [Hi]ghlights"))
keymap("n", "<leader>sw", "<cmd>Telescope grep_string<CR>", with_desc("[S]earch current [W]ord"))
keymap("n", "<leader>sr", "<cmd>Telescope resume<CR>", with_desc("[S]earch [R]esume"))
keymap("n", "<leader>sgs", "<cmd>Telescope git_status<CR>", with_desc("[S]earch [G]it [S]tatus"))
keymap("n", "<leader>sgc", "<cmd>Telescope git_commits<CR>", with_desc("[S]earch [G]it [C]ommits"))
keymap("n", "<leader>sgb", "<cmd>Telescope git_branches<CR>", with_desc("[S]earch [G]it [B]ranches"))

-- NvimTree (file explorer)
keymap("n", "<leader>ee", "<cmd>NvimTreeToggle<CR>", with_desc("Toggle file explorer"))
keymap("n", "<leader>ef", "<cmd>NvimTreeFindFile<CR>", with_desc("Find current file"))
keymap("n", "<leader>ec", "<cmd>NvimTreeCollapse<CR>", with_desc("Collapse file explorer"))
keymap("n", "<leader>er", "<cmd>NvimTreeRefresh<CR>", with_desc("Refresh file explorer"))

-- Gitsigns (inline git signs)
keymap("n", "]g", "<cmd>Gitsigns next_hunk<CR>", with_desc("Next git hunk"))
keymap("n", "[g", "<cmd>Gitsigns prev_hunk<CR>", with_desc("Previous git hunk"))
keymap("n", "<leader>ghs", "<cmd>Gitsigns stage_hunk<CR>", with_desc("Stage hunk"))
keymap("n", "<leader>ghu", "<cmd>Gitsigns undo_stage_hunk<CR>", with_desc("Undo stage hunk"))
keymap("n", "<leader>ghr", "<cmd>Gitsigns reset_hunk<CR>", with_desc("Reset hunk"))
keymap("n", "<leader>ghp", "<cmd>Gitsigns preview_hunk<CR>", with_desc("Preview hunk"))
keymap("n", "<leader>ghb", "<cmd>Gitsigns blame_line<CR>", with_desc("Blame line"))

-- Comment.nvim
keymap("n", "gcc", "<cmd>lua require('Comment.api').toggle.linewise.current()<CR>", with_desc("Toggle comment"))
keymap(
	"v",
	"gc",
	"<cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>",
	with_desc("Toggle comment")
)

-- ============================================================================
-- Development Specific (Go, Ruby, React/TS)
-- ============================================================================

-- Go specific (requires Go LSP and tools)
vim.api.nvim_create_autocmd("FileType", {
	pattern = "go",
	callback = function()
		keymap("n", "<leader>gt", "<cmd>GoTest<CR>", with_desc("Run Go tests"))
		keymap("n", "<leader>gT", "<cmd>GoTestFunc<CR>", with_desc("Run Go test function"))
		keymap("n", "<leader>gc", "<cmd>GoCoverage<CR>", with_desc("Show Go coverage"))
		keymap("n", "<leader>gi", "<cmd>GoImplements<CR>", with_desc("Go implements"))
		keymap("n", "<leader>ge", "<cmd>GoIfErr<CR>", with_desc("Add if err != nil"))
	end,
})

-- Ruby specific
vim.api.nvim_create_autocmd("FileType", {
	pattern = "ruby",
	callback = function()
		keymap("n", "<leader>rb", "<cmd>!bundle install<CR>", with_desc("Bundle install"))
		keymap("n", "<leader>rt", "<cmd>!rspec %<CR>", with_desc("Run current spec"))
		keymap("n", "<leader>rT", "<cmd>!rspec<CR>", with_desc("Run all specs"))
		keymap("n", "<leader>rc", "<cmd>!rubocop %<CR>", with_desc("Run RuboCop on current file"))
	end,
})

-- TypeScript/JavaScript specific
vim.api.nvim_create_autocmd("FileType", {
	pattern = { "typescript", "typescriptreact", "javascript", "javascriptreact" },
	callback = function()
		keymap("n", "<leader>ji", "<cmd>TSImport<CR>", with_desc("TS import"))
		keymap("n", "<leader>jo", "<cmd>TSOrganizeImports<CR>", with_desc("TS organize imports"))
		keymap("n", "<leader>jsi", "<cmd>TSToolsSortImports<cr>", with_desc("TS sort imports"))
		keymap("n", "<leader>ju", "<cmd>TSRemoveUnused<CR>", with_desc("TS remove unused"))
		keymap("n", "<leader>jf", "<cmd>TSFixAll<CR>", with_desc("TS fix all"))
		keymap("n", "<leader>jri", "<cmd>TSToolsRemoveUnusedImports<cr>", with_desc("TS remove unused imports"))
		keymap("n", "<leader>jai", "<cmd>TSToolsAddMissingImports<cr>", with_desc("TS add missing imports"))
		keymap("n", "<leader>jrf", "<cmd>TSToolsRenameFile<cr>", with_desc("TS rename current file"))
		keymap("n", "<leader>jfr", "<cmd>TSToolsFileReferences<cr>", with_desc("TS find all references"))
	end,
})

-- ============================================================================
-- Debugging Keymaps (DAP)
-- ============================================================================

-- These will work when nvim-dap is installed
keymap("n", "<F5>", "<cmd>lua require'dap'.continue()<CR>", with_desc("Debug: Continue"))
keymap("n", "<F10>", "<cmd>lua require'dap'.step_over()<CR>", with_desc("Debug: Step over"))
keymap("n", "<F11>", "<cmd>lua require'dap'.step_into()<CR>", with_desc("Debug: Step into"))
keymap("n", "<F12>", "<cmd>lua require'dap'.step_out()<CR>", with_desc("Debug: Step out"))
keymap("n", "<leader>db", "<cmd>lua require'dap'.toggle_breakpoint()<CR>", with_desc("Toggle breakpoint"))
keymap(
	"n",
	"<leader>dB",
	"<cmd>lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>",
	with_desc("Set conditional breakpoint")
)
keymap("n", "<leader>dr", "<cmd>lua require'dap'.repl.open()<CR>", with_desc("Open debug REPL"))
keymap("n", "<leader>dl", "<cmd>lua require'dap'.run_last()<CR>", with_desc("Run last debug"))

-- ============================================================================
-- Macro Helpers
-- ============================================================================

-- Execute macro over visual selection
keymap("v", "@", ":norm @", with_desc("Execute macro over selection"))

-- Quick macro recording/playback
keymap("n", "Q", "@q", with_desc("Play macro q"))
keymap("v", "Q", ":norm @q<CR>", with_desc("Play macro q over selection"))

-- ============================================================================
-- Command Mode Shortcuts
-- ============================================================================

-- Navigate command history without arrows
keymap("c", "<C-j>", "<Down>", opts)
keymap("c", "<C-k>", "<Up>", opts)
