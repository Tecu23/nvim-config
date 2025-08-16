return {
	"folke/which-key.nvim",
	event = "VeryLazy",
	init = function()
		vim.o.timeout = true
		vim.o.timeoutlen = 300
	end,
	opts = {
		plugins = {
			marks = true, -- shows a list of your marks on ' and `
			registers = true, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
			spelling = {
				enabled = true, -- enabling this will show WhichKey when pressinh z= to select spelling suggestions
				suggestions = 20, -- how many suggestions should be shown in the list
			},
			presets = {
				operators = true, -- adds help for operators like d, y, c ...
				motions = true, -- adds help for motions
				text_objects = true, -- help for text objects triggered after entering an operator
				windows = true, -- default binding on <c-w>
				nav = true, -- misc bindings to work with windows
				z = true, -- bindings for folds spelling and others prefixed with z
				g = true, -- bindings for prefixed with g
			},
		},
		operators = { gc = "Comments" },
		key_labels = {
			["<space>"] = "SPC",
			["<cr>"] = "RET",
			["<tab>"] = "TAB",
		},
		motions = {
			count = true,
		},
		icons = {
			-- set icon mappings to true if you have a Nerd Font
			mappings = vim.g.have_nerd_font,
			breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
			separator = "➜", -- symbol used between a key and it's label
			group = "+", -- symbol prepended to a group
		},
		popup_mappings = {
			scroll_down = "<c-d>", -- binding to scroll down inside the popup
			scroll_up = "<c-u>", -- binding to scroll up inside the popup
		},
		window = {
			border = "rounded", -- none, single, double, shadow, rounded
			position = "bottom", -- bottom, top
			margin = { 1, 0, 1, 0 }, -- extra window margin [top, riht, bottom, left]
			padding = { 1, 2, 1, 2 }, -- extra window padding [top, right, bottom, left]
			winblend = 0, -- value between 0-100 0 for fully opaque and 100 for fully transparent
			zindex = 1000, -- positive value to position WhichKey above other floating windows.
		},
		layout = {
			height = { min = 4, max = 25 }, -- min and max height of the columns
			width = { min = 20, max = 50 }, -- min and max width of the columns
			spacing = 3, -- spacing between columns
			align = "left", -- align columns left, center or right
		},
		ignore_missing = false, -- enable this to hide mappings for which you didn't specify a label
		hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "^:", "^ ", "^call ", "^lua " }, -- hide mapping boilerplate
		show_help = true, -- show a help message in the command line for using WhichKey
		show_keys = true, -- show the currently pressed key and its label as a message in the command line
		triggers = "auto", -- automatically setup triggers
		triggers_nowait = {
			-- marks
			"`",
			"'",
			"g`",
			"g'",
			-- registers
			'"',
			"<c-r>",
			-- spelling
			"z=",
		},
		triggers_blacklist = {
			-- list of mode / prefixes that should never be hooked by WhichKey
			i = { "j", "k" },
			v = { "j", "k" },
		},
		disable = {
			buftypes = {},
			filetypes = {},
		},

		config = function(_, opts)
			local wk = require("which-key")
			wk.setup(opts)

			-- ============================================================================
			-- Normal Mode Mappings
			-- ============================================================================
			wk.register({
				-- Single key mappings
				["<Esc>"] = { "<cmd>nohlsearch<CR>", "Clear search highlights" },
				["Q"] = { "@q", "Play macro q" },
				["K"] = { vim.lsp.buf.hover, "Hover documentation" },
				["}"] = { "}zz", "Next paragraph" },
				["{"] = { "{zz", "Previous paragraph" },

				-- Leader mappings
				["<leader>"] = {
					-- Direct leader mappings
					w = { "<cmd>w<CR>", "Save file" },
					W = { "<cmd>wa<CR>", "Save all files" },
					q = { "<cmd>q<CR>", "Quit" },
					Q = { "<cmd>qa<CR>", "Quit all" },
					x = { "<cmd>x<CR>", "Save and quit" },
					h = { "<cmd>nohlsearch<CR>", "Clear highlights" },
					o = { "o<Esc>", "Add line below" },
					O = { "O<Esc>", "Add line above" },
					m = { "%", "Jump to matching bracket" },

					-- Groups
					-- Buffer management
					b = {
						name = "+buffer",
						d = { "<cmd>bdelete<CR>", "Delete buffer" },
						D = { "<cmd>bdelete!<CR>", "Force delete buffer" },
						n = { "<cmd>bnext<CR>", "Next buffer" },
						p = { "<cmd>bprevious<CR>", "Previous buffer" },
						b = { "<cmd>b#<CR>", "Toggle buffers" },
						a = { "<cmd>%bd|e#<CR>", "Close all except current" },
						l = { "<cmd>ls<CR>", "List buffers" },
						s = { "<cmd>w<CR>", "Save buffer" },
					},

					-- Code actions
					c = {
						name = "+code",
						a = { vim.lsp.buf.code_action, "Code action" },
						d = { vim.diagnostic.open_float, "Line diagnostics" },
						f = {
							function()
								require("conform").format({ async = true, lsp_fallback = true })
							end,
							"Format",
						},
						l = { vim.lsp.codelens.run, "Run code lens" },
						r = { vim.lsp.codelens.refresh, "Refresh code lens" },
						s = { vim.lsp.buf.signature_help, "Signature help" },
						n = { vim.lsp.buf.rename, "Rename symbol" },
						o = { "<cmd>copen<CR>", "Open quickfix" },
						c = { "<cmd>cclose<CR>", "Close quickfix" },
						p = { "<cmd>cprev<CR>zz", "Previous quickfix" },
						n = { "<cmd>cnext<CR>zz", "Next quickfix" },
					},

					-- Diagnostics
					d = {
						name = "+diagnostics",
						d = { vim.diagnostic.open_float, "Show diagnostics" },
						l = { vim.diagnostic.setloclist, "Location list" },
						q = { vim.diagnostic.setqflist, "Quickfix list" },
						n = { vim.diagnostic.goto_next, "Next diagnostic" },
						p = { vim.diagnostic.goto_prev, "Previous diagnostic" },
						D = { "<cmd>DiagnosticsToggle<CR>", "Toggle diagnostics" },
					},

					-- Find (Telescope)
					f = {
						name = "+find",
						f = { "<cmd>Telescope find_files<CR>", "Find files" },
						g = { "<cmd>Telescope live_grep<CR>", "Live grep" },
						b = { "<cmd>Telescope buffers<CR>", "Find buffers" },
						h = { "<cmd>Telescope help_tags<CR>", "Find help" },
						r = { "<cmd>Telescope oldfiles<CR>", "Recent files" },
						c = { "<cmd>Telescope commands<CR>", "Find commands" },
						k = { "<cmd>Telescope keymaps<CR>", "Find keymaps" },
						s = { "<cmd>Telescope git_status<CR>", "Git status" },
						C = { "<cmd>Telescope git_commits<CR>", "Git commits" },
						B = { "<cmd>Telescope git_branches<CR>", "Git branches" },
						d = { "<cmd>Telescope diagnostics<CR>", "Diagnostics" },
						R = { "<cmd>Telescope registers<CR>", "Registers" },
						m = { "<cmd>Telescope marks<CR>", "Marks" },
						M = { "<cmd>Telescope man_pages<CR>", "Man pages" },
						t = { "<cmd>Telescope treesitter<CR>", "Treesitter symbols" },
						l = { "<cmd>Telescope lsp_references<CR>", "LSP references" },
						i = { "<cmd>Telescope lsp_implementations<CR>", "LSP implementations" },
						D = { "<cmd>Telescope lsp_definitions<CR>", "LSP definitions" },
						T = { "<cmd>Telescope lsp_type_definitions<CR>", "LSP type definitions" },
					},

					-- Git
					g = {
						name = "+git",
						s = { "<cmd>Git<CR>", "Git status" },
						d = { "<cmd>Gdiffsplit<CR>", "Git diff" },
						l = { "<cmd>Git log<CR>", "Git log" },
						p = { "<cmd>Git push<CR>", "Git push" },
						P = { "<cmd>Git pull<CR>", "Git pull" },
						a = { "<cmd>Gwrite<CR>", "Git add file" },
						c = { "<cmd>Git commit<CR>", "Git commit" },
						C = { "<cmd>Git commit --amend<CR>", "Git commit amend" },
						b = { "<cmd>Telescope git_branches<CR>", "Git branches" },
						B = { "<cmd>Git blame<CR>", "Git blame" },
						r = { "<cmd>Gread<CR>", "Git read (checkout file)" },
						R = { "<cmd>Git rebase -i<CR>", "Git rebase interactive" },
						h = {
							name = "+hunks",
							s = { "<cmd>Gitsigns stage_hunk<CR>", "Stage hunk" },
							u = { "<cmd>Gitsigns undo_stage_hunk<CR>", "Undo stage hunk" },
							r = { "<cmd>Gitsigns reset_hunk<CR>", "Reset hunk" },
							p = { "<cmd>Gitsigns preview_hunk<CR>", "Preview hunk" },
							b = { "<cmd>Gitsigns blame_line<CR>", "Blame line" },
							S = { "<cmd>Gitsigns stage_buffer<CR>", "Stage buffer" },
							R = { "<cmd>Gitsigns reset_buffer<CR>", "Reset buffer" },
						},
					},

					-- LSP
					l = {
						name = "+lsp",
						i = { "<cmd>LspInfo<CR>", "LSP info" },
						I = { "<cmd>Mason<CR>", "Mason installer" },
						r = { "<cmd>LspRestart<CR>", "Restart LSP" },
						s = { "<cmd>LspStart<CR>", "Start LSP" },
						S = { "<cmd>LspStop<CR>", "Stop LSP" },
						l = { "<cmd>LspLog<CR>", "LSP log" },
						f = { vim.lsp.buf.format, "Format buffer" },
						a = { vim.lsp.buf.code_action, "Code action" },
						d = { vim.diagnostic.open_float, "Line diagnostics" },
						n = { vim.lsp.buf.rename, "Rename" },
						o = { "<cmd>lopen<CR>", "Open location list" },
						c = { "<cmd>lclose<CR>", "Close location list" },
						p = { "<cmd>lprev<CR>zz", "Previous location" },
						n = { "<cmd>lnext<CR>zz", "Next location" },
					},

					-- Debugging (DAP)
					D = {
						name = "+debug",
						b = { "<cmd>lua require'dap'.toggle_breakpoint()<CR>", "Toggle breakpoint" },
						B = {
							"<cmd>lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>",
							"Conditional breakpoint",
						},
						c = { "<cmd>lua require'dap'.continue()<CR>", "Continue" },
						i = { "<cmd>lua require'dap'.step_into()<CR>", "Step into" },
						o = { "<cmd>lua require'dap'.step_over()<CR>", "Step over" },
						O = { "<cmd>lua require'dap'.step_out()<CR>", "Step out" },
						r = { "<cmd>lua require'dap'.repl.open()<CR>", "Open REPL" },
						l = { "<cmd>lua require'dap'.run_last()<CR>", "Run last" },
						t = { "<cmd>lua require'dap'.terminate()<CR>", "Terminate" },
					},

					-- Replace
					r = {
						name = "+replace",
						w = { [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], "Replace word" },
						W = { [[:%s/\<<C-r><C-W>\>/<C-r><C-W>/gI<Left><Left><Left>]], "Replace WORD" },
						r = { ":%s///g<Left><Left>", "Replace" },
						c = { ":%s///gc<Left><Left><Left>", "Replace with confirm" },
						n = { vim.lsp.buf.rename, "Rename symbol" },
					},

					-- Split windows
					s = {
						name = "+split",
						v = { "<C-w>v", "Split vertically" },
						h = { "<C-w>s", "Split horizontally" },
						e = { "<C-w>=", "Equal splits" },
						x = { "<cmd>close<CR>", "Close split" },
						m = { "<cmd>MaximizerToggle<CR>", "Maximize toggle" },
						r = { "<C-w>r", "Rotate windows" },
						R = { "<C-w>R", "Rotate windows reverse" },
					},

					-- Tabs
					t = {
						name = "+tabs",
						o = { "<cmd>tabnew<CR>", "New tab" },
						x = { "<cmd>tabclose<CR>", "Close tab" },
						n = { "<cmd>tabn<CR>", "Next tab" },
						p = { "<cmd>tabp<CR>", "Previous tab" },
						f = { "<cmd>tabnew %<CR>", "Open file in tab" },
						["1"] = { "1gt", "Go to tab 1" },
						["2"] = { "2gt", "Go to tab 2" },
						["3"] = { "3gt", "Go to tab 3" },
						["4"] = { "4gt", "Go to tab 4" },
						["5"] = { "5gt", "Go to tab 5" },
					},

					-- Toggle settings
					u = {
						name = "+toggle",
						w = { "<cmd>set wrap!<CR>", "Toggle wrap" },
						s = { "<cmd>set spell!<CR>", "Toggle spell" },
						n = { "<cmd>set relativenumber!<CR>", "Toggle relative numbers" },
						l = { "<cmd>set list!<CR>", "Toggle list chars" },
						h = { "<cmd>set hlsearch!<CR>", "Toggle search highlight" },
						i = {
							function()
								vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
							end,
							"Toggle inlay hints",
						},
						d = { "<cmd>DiagnosticsToggle<CR>", "Toggle diagnostics" },
						f = { "<cmd>FormatToggle<CR>", "Toggle format on save" },
						c = { "<cmd>set cursorline!<CR>", "Toggle cursor line" },
						C = { "<cmd>set cursorcolumn!<CR>", "Toggle cursor column" },
					},

					-- Trouble
					x = {
						name = "+trouble",
						x = { "<cmd>TroubleToggle<CR>", "Toggle trouble" },
						w = { "<cmd>TroubleToggle workspace_diagnostics<CR>", "Workspace diagnostics" },
						d = { "<cmd>TroubleToggle document_diagnostics<CR>", "Document diagnostics" },
						l = { "<cmd>TroubleToggle loclist<CR>", "Location list" },
						q = { "<cmd>TroubleToggle quickfix<CR>", "Quickfix list" },
						r = { "<cmd>TroubleToggle lsp_references<CR>", "LSP references" },
					},

					-- Folding
					z = {
						name = "+fold",
						a = { "za", "Toggle fold" },
						A = { "zA", "Toggle all folds" },
						c = { "zc", "Close fold" },
						o = { "zo", "Open fold" },
						M = { "zM", "Close all folds" },
						R = { "zR", "Open all folds" },
						v = { "zv", "View cursor line" },
						x = { "zx", "Update folds" },
					},

					-- Terminal
					T = {
						name = "+terminal",
						t = { "<cmd>terminal<CR>", "Open terminal" },
						v = { "<cmd>vsplit | terminal<CR>", "Terminal vsplit" },
						h = { "<cmd>split | terminal<CR>", "Terminal split" },
						n = { "<cmd>tabnew | terminal<CR>", "Terminal tab" },
					},

					-- Quickfix/Location list navigation (already covered above)
					["["] = { name = "+prev" },
					["]"] = { name = "+next" },
				},

				-- Go to mappings
				g = {
					d = { vim.lsp.buf.definition, "Go to definition" },
					D = { vim.lsp.buf.declaration, "Go to declaration" },
					i = { vim.lsp.buf.implementation, "Go to implementation" },
					o = { vim.lsp.buf.type_definition, "Go to type definition" },
					r = { vim.lsp.buf.references, "Show references" },
					s = { vim.lsp.buf.signature_help, "Signature help" },
					p = { "<cmd>Lspsaga peek_definition<CR>", "Peek definition" },
					K = { "<cmd>Lspsaga hover_doc<CR>", "Hover doc (Saga)" },
					["*"] = { "g*zzzv", "Search partial word" },
					["#"] = { "g#zzzv", "Search partial word backward" },
				},

				-- Navigation brackets
				["["] = {
					d = { vim.diagnostic.goto_prev, "Previous diagnostic" },
					g = { "<cmd>Gitsigns prev_hunk<CR>", "Previous git hunk" },
					c = {
						function()
							require("treesitter-context").go_to_context()
						end,
						"Go to context",
					},
					f = { vim.lsp.buf.definition, "Go to definition" },
					t = { "<cmd>tabprevious<CR>", "Previous tab" },
					b = { "<cmd>bprevious<CR>", "Previous buffer" },
					q = { "<cmd>cprev<CR>", "Previous quickfix" },
					l = { "<cmd>lprev<CR>", "Previous location" },
				},

				["]"] = {
					d = { vim.diagnostic.goto_next, "Next diagnostic" },
					g = { "<cmd>Gitsigns next_hunk<CR>", "Next git hunk" },
					t = { "<cmd>tabnext<CR>", "Next tab" },
					b = { "<cmd>bnext<CR>", "Next buffer" },
					q = { "<cmd>cnext<CR>", "Next quickfix" },
					l = { "<cmd>lnext<CR>", "Next location" },
				},

				-- Window navigation
				["<C-h>"] = { "<C-w>h", "Move to left window" },
				["<C-j>"] = { "<C-w>j", "Move to lower window" },
				["<C-k>"] = { "<C-w>k", "Move to upper window" },
				["<C-l>"] = { "<C-w>l", "Move to right window" },

				-- Resize windows
				["<C-Up>"] = { "<cmd>resize +2<CR>", "Increase height" },
				["<C-Down>"] = { "<cmd>resize -2<CR>", "Decrease height" },
				["<C-Left>"] = { "<cmd>vertical resize -2<CR>", "Decrease width" },
				["<C-Right>"] = { "<cmd>vertical resize +2<CR>", "Increase width" },

				-- Other mappings
				["<Tab>"] = { "<cmd>bnext<CR>", "Next buffer" },
				["<S-Tab>"] = { "<cmd>bprevious<CR>", "Previous buffer" },
				["<C-s>"] = { "<cmd>w<CR>", "Save file" },
				["<C-a>"] = { "gg<S-v>G", "Select all" },
			}, { mode = "n" })

			-- ============================================================================
			-- Visual Mode Mappings
			-- ============================================================================
			wk.register({
				["<"] = { "<gv", "Indent left" },
				[">"] = { ">gv", "Indent right" },
				["J"] = { ":m '>+1<CR>gv=gv", "Move selection down" },
				["K"] = { ":m '<-2<CR>gv=gv", "Move selection up" },
				["p"] = { '"_dP', "Paste without yanking" },
				["//"] = { 'y/<C-R>"<CR>', "Search for selection" },
				["@"] = { ":norm @", "Execute macro" },
				["Q"] = { ":norm @q<CR>", "Execute macro q" },

				["<leader>"] = {
					c = {
						name = "+code",
						a = { vim.lsp.buf.code_action, "Code action" },
						f = {
							function()
								require("conform").format({ async = true, lsp_fallback = true })
							end,
							"Format selection",
						},
					},
					d = { '"_d', "Delete without yanking" },
					D = { '"_D', "Delete line without yanking" },
					r = {
						name = "+replace",
						r = { '"hy:%s/<C-r>h//g<Left><Left>', "Replace selection" },
					},
					f = { vim.lsp.buf.format, "Format selection" },
				},

				-- Git hunks in visual mode
				["<leader>g"] = {
					h = {
						name = "+hunks",
						s = { ":Gitsigns stage_hunk<CR>", "Stage hunk" },
						r = { ":Gitsigns reset_hunk<CR>", "Reset hunk" },
					},
				},
			}, { mode = "v" })

			-- ============================================================================
			-- Insert Mode Mappings
			-- ============================================================================
			wk.register({
				["<C-h>"] = { "<Left>", "Move left" },
				["<C-j>"] = { "<Down>", "Move down" },
				["<C-k>"] = { "<Up>", "Move up" },
				["<C-l>"] = { "<Right>", "Move right" },
				["<C-a>"] = { "<ESC>^i", "Beginning of line" },
				["<C-e>"] = { "<End>", "End of line" },
				["<C-s>"] = { "<cmd>w<CR>", "Save file" },
				["jk"] = { "<ESC>", "Exit insert mode" },
				["jj"] = { "<ESC>", "Exit insert mode" },
			}, { mode = "i" })

			-- ============================================================================
			-- Terminal Mode Mappings
			-- ============================================================================
			wk.register({
				["<Esc><Esc>"] = { "<C-\\><C-n>", "Exit terminal mode" },
				["jk"] = { "<C-\\><C-n>", "Exit terminal mode" },
				["<C-h>"] = { "<C-\\><C-n><C-w>h", "Move to left window" },
				["<C-j>"] = { "<C-\\><C-n><C-w>j", "Move to lower window" },
				["<C-k>"] = { "<C-\\><C-n><C-w>k", "Move to upper window" },
				["<C-l>"] = { "<C-\\><C-n><C-w>l", "Move to right window" },
			}, { mode = "t" })

			-- ============================================================================
			-- Operator Mode Mappings
			-- ============================================================================
			wk.register({
				["ih"] = { ":<C-U>Gitsigns select_hunk<CR>", "Select git hunk" },
			}, { mode = "o" })

			-- ============================================================================
			-- Language-Specific Mappings (will be loaded per filetype)
			-- ============================================================================

			-- Go mappings
			vim.api.nvim_create_autocmd("FileType", {
				pattern = "go",
				callback = function()
					wk.register({
						["<leader>g"] = {
							name = "+go",
							t = { "<cmd>!go test -v ./...<CR>", "Run all tests" },
							T = { "<cmd>!go test -v -run ^%:t:r$ ./...<CR>", "Test under cursor" },
							b = { "<cmd>!go test -bench=.<CR>", "Run benchmarks" },
							r = { "<cmd>!go run %<CR>", "Run current file" },
							B = { "<cmd>!go build<CR>", "Build project" },
							a = {
								function()
									local file = vim.fn.expand("%")
									local alt_file = file:match("_test%.go$") and file:gsub("_test%.go$", ".go")
										or file:gsub("%.go$", "_test.go")
									vim.cmd("edit " .. alt_file)
								end,
								"Go to alternate file",
							},
							g = { "<cmd>!go generate ./...<CR>", "Run go generate" },
							m = { "<cmd>!go mod tidy<CR>", "Run go mod tidy" },
							v = { "<cmd>!go mod vendor<CR>", "Run go mod vendor" },
							c = {
								function()
									vim.cmd("!go test -coverprofile=coverage.out ./...")
									vim.cmd("!go tool cover -html=coverage.out -o coverage.html")
									vim.notify("Coverage report: coverage.html")
								end,
								"Generate coverage",
							},
							e = { "<cmd>GoIfErr<CR>", "Add if err != nil" },
							i = { "<cmd>GoImplements<CR>", "Go implements" },
						},
					}, { buffer = 0 })
				end,
			})

			-- Ruby mappings
			vim.api.nvim_create_autocmd("FileType", {
				pattern = "ruby",
				callback = function()
					wk.register({
						["<leader>r"] = {
							name = "+ruby/rails",
							t = { "<cmd>!bundle exec rspec %<CR>", "Run current spec" },
							T = { "<cmd>!bundle exec rspec<CR>", "Run all specs" },
							l = {
								function()
									vim.cmd("!bundle exec rspec %:" .. vim.fn.line("."))
								end,
								"Run spec at line",
							},
							f = { "<cmd>!bundle exec rspec --fail-fast<CR>", "Run specs (fail fast)" },
							c = { "<cmd>!rails console<CR>", "Rails console" },
							s = { "<cmd>!rails server<CR>", "Rails server" },
							g = { "<cmd>!rails generate ", "Rails generate" },
							m = { "<cmd>!rails db:migrate<CR>", "Rails migrate" },
							C = { "<cmd>!bundle exec rubocop %<CR>", "RuboCop current" },
							A = { "<cmd>!bundle exec rubocop -A %<CR>", "RuboCop auto-correct" },
							i = { "<cmd>!irb<CR>", "Start IRB" },
							p = { "<cmd>!pry<CR>", "Start Pry" },
							a = {
								function()
									local file = vim.fn.expand("%")
									local alt_file = file:match("_spec%.rb$")
											and file:gsub("spec/", "app/"):gsub("_spec%.rb$", ".rb")
										or file:gsub("app/", "spec/"):gsub("%.rb$", "_spec.rb")
									if alt_file and vim.fn.filereadable(alt_file) == 1 then
										vim.cmd("edit " .. alt_file)
									else
										vim.notify("Alternate file not found", vim.log.levels.WARN)
									end
								end,
								"Go to alternate file",
							},
						},
						["<leader>b"] = {
							name = "+bundler",
							i = { "<cmd>!bundle install<CR>", "Bundle install" },
							u = { "<cmd>!bundle update<CR>", "Bundle update" },
							e = { "<cmd>!bundle exec ", "Bundle exec" },
						},
					}, { buffer = 0 })
				end,
			})

			-- TypeScript/JavaScript mappings
			vim.api.nvim_create_autocmd("FileType", {
				pattern = { "typescript", "typescriptreact", "javascript", "javascriptreact" },
				callback = function()
					wk.register({
						["<leader>j"] = {
							name = "+js/ts",
							i = { "<cmd>TSImport<CR>", "TS import" },
							o = { "<cmd>TSOrganizeImports<CR>", "TS organize imports" },
							u = { "<cmd>TSRemoveUnused<CR>", "TS remove unused" },
							f = { "<cmd>TSFixAll<CR>", "TS fix all" },
							r = { "<cmd>TSRename<CR>", "TS rename" },
							g = { "<cmd>TSGoToSourceDefinition<CR>", "Go to source definition" },
							t = { "<cmd>TSTypeDefinition<CR>", "Type definition" },
							d = { "<cmd>TSDiagnostics<CR>", "TS diagnostics" },
						},
						["<leader>n"] = {
							name = "+npm",
							i = { "<cmd>!npm install<CR>", "npm install" },
							r = { "<cmd>!npm run ", "npm run" },
							s = { "<cmd>!npm start<CR>", "npm start" },
							t = { "<cmd>!npm test<CR>", "npm test" },
							b = { "<cmd>!npm run build<CR>", "npm build" },
							d = { "<cmd>!npm run dev<CR>", "npm dev" },
							l = { "<cmd>!npm list<CR>", "npm list" },
							o = { "<cmd>!npm outdated<CR>", "npm outdated" },
							u = { "<cmd>!npm update<CR>", "npm update" },
						},
					}, { buffer = 0 })
				end,
			})

			-- Docker mappings
			vim.api.nvim_create_autocmd("FileType", {
				pattern = { "dockerfile", "yaml.docker-compose" },
				callback = function()
					wk.register({
						["<leader>d"] = {
							name = "+docker",
							b = { "<cmd>!docker build -t %:t:r .<CR>", "Build image" },
							r = { "<cmd>!docker run %:t:r<CR>", "Run container" },
							p = { "<cmd>!docker push %:t:r<CR>", "Push image" },
							i = { "<cmd>!docker images<CR>", "List images" },
							c = { "<cmd>!docker ps<CR>", "List containers" },
							a = { "<cmd>!docker ps -a<CR>", "List all containers" },
							s = { "<cmd>!docker stop ", "Stop container" },
							d = { "<cmd>!docker rm ", "Remove container" },
							D = { "<cmd>!docker rmi ", "Remove image" },
							l = { "<cmd>!docker logs ", "Show logs" },
							e = { "<cmd>!docker exec -it ", "Execute in container" },
							u = { "<cmd>!docker-compose up<CR>", "Compose up" },
							U = { "<cmd>!docker-compose up -d<CR>", "Compose up detached" },
							o = { "<cmd>!docker-compose down<CR>", "Compose down" },
						},
					}, { buffer = 0 })
				end,
			})

			-- ============================================================================
			-- Function Keys
			-- ============================================================================
			wk.register({
				["<F1>"] = { "<cmd>help<CR>", "Help" },
				["<F2>"] = { vim.lsp.buf.rename, "Rename symbol" },
				["<F3>"] = { "<cmd>Telescope find_files<CR>", "Find files" },
				["<F4>"] = { vim.lsp.buf.code_action, "Code action" },
				["<F5>"] = { "<cmd>lua require'dap'.continue()<CR>", "Debug: Continue" },
				["<F6>"] = { "<cmd>lua require'dap'.step_over()<CR>", "Debug: Step over" },
				["<F7>"] = { "<cmd>lua require'dap'.step_into()<CR>", "Debug: Step into" },
				["<F8>"] = { "<cmd>lua require'dap'.step_out()<CR>", "Debug: Step out" },
				["<F9>"] = { "<cmd>lua require'dap'.toggle_breakpoint()<CR>", "Toggle breakpoint" },
				["<F10>"] = { "<cmd>lua require'dap'.step_over()<CR>", "Debug: Step over" },
				["<F11>"] = { "<cmd>lua require'dap'.step_into()<CR>", "Debug: Step into" },
				["<F12>"] = { "<cmd>lua require'dap'.step_out()<CR>", "Debug: Step out" },
			})

			-- ============================================================================
			-- Custom Commands Descriptions
			-- ============================================================================
			wk.register({
				["<cmd>"] = {
					name = "Commands",
					ReloadConfig = "Reload Neovim configuration",
					EditConfig = "Edit Neovim configuration",
					EditPlugins = "Edit plugin configurations",
					CheckHealth = "Run health checks",
					LspInfo = "Show LSP information",
					LspLog = "Open LSP log file",
					LspRestart = "Restart all LSP servers",
					Format = "Format document or range",
					FormatToggle = "Toggle format on save",
					DiagnosticsToggle = "Toggle diagnostics",
					Mason = "Open Mason installer",
					Lazy = "Open Lazy plugin manager",
					TSUpdate = "Update Tree-sitter parsers",
					TSInstallInfo = "Show Tree-sitter install info",
				},
			})
		end,
	},
}
