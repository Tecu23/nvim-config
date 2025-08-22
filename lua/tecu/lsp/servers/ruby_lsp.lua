-- ============================================================================
-- Ruby LSP (Ruby Language Server) Configuration
-- ============================================================================

return {
	cmd = { "ruby-lsp" },
	filetypes = { "ruby" },
	root_dir = function(fname)
		local util = require("lspconfig.util")
		return util.root_pattern("Gemfile", ".git", ".rubocop.yml")(fname) or util.path.dirname(fname)
	end,
	init_options = {
		formatter = "auto", -- "rubocop", "syntax_tree", "auto", or "none"
		linters = { "rubocop" },
		featuresConfiguration = {
			inlayHint = {
				implicitHashValue = true,
				implicitRescue = true,
			},
		},
	},
	settings = {},

	on_attach = function(client, bufnr)
		-- Set up Ruby-specific keymaps
		local map = function(mode, lhs, rhs, desc)
			vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = "Ruby: " .. desc })
		end

		-- Rails navigation
		map("n", "<leader>rc", "<cmd>!rails console<CR>", "Rails console")
		map("n", "<leader>rs", "<cmd>!rails server<CR>", "Rails server")
		map("n", "<leader>rg", "<cmd>!rails generate ", "Rails generate")
		map("n", "<leader>rm", "<cmd>!rails db:migrate<CR>", "Rails migrate")

		-- RSpec testing
		map("n", "<leader>rt", "<cmd>!bundle exec rspec %<CR>", "Run current spec file")
		map("n", "<leader>rT", "<cmd>!bundle exec rspec<CR>", "Run all specs")
		map("n", "<leader>rl", function()
			local line = vim.fn.line(".")
			vim.cmd("!bundle exec rspec %:" .. line)
		end, "Run spec at current line")
		map("n", "<leader>rf", "<cmd>!bundle exec rspec --fail-fast<CR>", "Run specs (fail fast)")

		-- Bundler commands
		map("n", "<leader>rbi", "<cmd>!bundle install<CR>", "Bundle install")
		map("n", "<leader>rbu", "<cmd>!bundle update<CR>", "Bundle update")
		map("n", "<leader>rbe", "<cmd>!bundle exec ", "Bundle exec")

		-- RuboCop
		map("n", "<leader>rC", "<cmd>!bundle exec rubocop %<CR>", "RuboCop current file")
		map("n", "<leader>rA", "<cmd>!bundle exec rubocop -A %<CR>", "RuboCop auto-correct")

		-- IRB/Pry
		map("n", "<leader>ri", "<cmd>!irb<CR>", "Start IRB")
		map("n", "<leader>rp", "<cmd>!pry<CR>", "Start Pry")

		-- Go to alternate file (spec <-> implementation)
		map("n", "<leader>ra", function()
			local file = vim.fn.expand("%")
			local alt_file
			if file:match("_spec%.rb$") then
				alt_file = file:gsub("spec/", "app/"):gsub("_spec%.rb$", ".rb")
			elseif file:match("%.rb$") then
				alt_file = file:gsub("app/", "spec/"):gsub("%.rb$", "_spec.rb")
			end
			if alt_file and vim.fn.filereadable(alt_file) == 1 then
				vim.cmd("edit " .. alt_file)
			else
				vim.notify("Alternate file not found: " .. (alt_file or "none"), vim.log.levels.WARN)
			end
		end, "Go to alternate file")
	end,
}
