-- ============================================================================
-- Neovim Improved Search Configuration (flash.nvim)
-- ============================================================================

return {
	"folke/flash.nvim",
	event = "VeryLazy",
	opts = {
		-- The `opts` table is where the magic happens. We'll add the
		-- `mappings` table to ensure the keybindings are set.
		-- This is in addition to the `modes` table which configures
		-- the behavior *of* those keybindings.
		mappings = {
			-- Maps the 's' key to trigger flash in normal, visual, and operator-pending modes
			s = {
				mode = { "n", "x", "o" },
				fn = function()
					require("flash").jump()
				end,
				desc = "Flash Jump",
			},
			-- Explicitly map 'f' and 'F' to trigger character flash
			f = {
				mode = { "n", "o" },
				fn = function()
					require("flash").jump({ char_jump = true })
				end,
				desc = "Flash forward",
			},
			F = {
				mode = { "n", "o" },
				fn = function()
					require("flash").jump({ char_jump = true, backwards = true })
				end,
				desc = "Flash backward",
			},
		},
		labels = "asdfghjklqwertyuiopzxcvbnm",
		search = {
			-- search/jump in all windows
			multi_window = true,
			-- search direction
			forward = true,
			-- when `false`, find only matches in the given direction
			wrap = true,
			-- Each mode will take ignorecase and smartcase into account.
			-- * exact: exact match
			-- * search: regular search
			-- * fuzzy: fuzzy search
			-- * fun(str): custom function that returns a pattern
			--   For example, to only match at the beginning of a word:
			--   mode = function(str)
			--     return "\\<" .. str
			--   end,
			mode = "exact",
			-- behave like `incsearch`
			incremental = true,
			-- Excluded filetypes and custom window filters
			exclude = {
				"notify",
				"noice",
				"cmp_menu",
				function(win)
					-- exclude non-focusable windows
					return not vim.api.nvim_win_get_config(win).focusable
				end,
			},
			-- Optional trigger character that needs to be typed before
			-- a jump label can be used. It's NOT recommended to set this,
			-- unless you know what you're doing
			trigger = "",
		},
		jump = {
			-- save location in the jumplist
			jumplist = true,
			-- jump position
			pos = "start", ---@type "start" | "end" | "range"
			-- add pattern to search history
			history = false,
			-- add pattern to search register
			register = false,
			-- clear highlight after jump
			nohlsearch = true,
			-- automatically jump when there is only one match
			autojump = false,
		},
		modes = {
			-- options used when flash is activated through
			-- a regular search with `/` or `?`
			search = {
				enabled = true, -- enable flash for search
				highlight = { backdrop = false },
				jump = { history = true, register = true, nohlsearch = true },
				search = {
					-- `forward` will be automatically set to the search direction
					-- `mode` is always set to `search`
					-- `incremental` is set to `true` when `incsearch` is enabled
				},
			},
			-- options used when flash is activated through
			-- `f`, `F`, `t`, `T`, and `,` motions
			char = {
				enabled = true,
				-- by default all keymaps are enabled, but you can disable some of them,
				-- by removing them from the list.
				keys = { ",", ";" },
				search = { wrap = false },
				highlight = { backdrop = true },
				jump = { register = false },
				jump_labels = true,
			},
			-- options used for remote flash
			remote = {},
		},
	},
}
