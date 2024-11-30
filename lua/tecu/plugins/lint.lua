return {
	{ -- Linting
		"mfussenegger/nvim-lint",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			local lint = require("lint")
			lint.linters_by_ft = {
				markdown = { "markdownlint" },
				javascript = { "eslint" },
				typescript = { "eslint" },
				go = { "revive" },
				json = { "jsonlint" },
				-- ruby = { "rubocop" },
			}

			lint.linters.golangci_lint = {
				name = "golangci_lint",
				cmd = "golangci-lint",
				stdin = false,
				args = { "run", "--out-format", "json", "--issues-exit-code=1" },
				stream = "stdout",
				ignore_exitcode = true,
				parser = function(output, bufnr)
					local diagnostics = {}
					local decoded = vim.fn.json_decode(output)
					if not decoded or not decoded.Issues then
						return diagnostics
					end
					for _, issue in ipairs(decoded.Issues) do
						table.insert(diagnostics, {
							lnum = issue.Pos.Line - 1,
							col = issue.Pos.Column - 1,
							end_lnum = issue.Pos.EndLine and issue.Pos.EndLine - 1 or nil,
							end_col = issue.Pos.EndColumn and issue.Pos.EndColumn - 1 or nil,
							severity = vim.lsp.protocol.DiagnosticSeverity.Warning,
							message = issue.Text,
							source = "golangci-lint",
						})
					end
					return diagnostics
				end,
			}

			-- To allow other plugins to add linters to require('lint').linters_by_ft,
			-- instead set linters_by_ft like this:
			-- lint.linters_by_ft = lint.linters_by_ft or {}
			-- lint.linters_by_ft['markdown'] = { 'markdownlint' }
			--
			-- However, note that this will enable a set of default linters,
			-- which will cause errors unless these tools are available:
			-- {
			--   clojure = { "clj-kondo" },
			--   dockerfile = { "hadolint" },
			--   inko = { "inko" },
			--   janet = { "janet" },
			--   json = { "jsonlint" },
			--   markdown = { "vale" },
			--   rst = { "vale" },
			--   ruby = { "ruby" },
			--   terraform = { "tflint" },
			--   text = { "vale" }
			-- }
			--
			-- You can disable the default linters by setting their filetypes to nil:
			-- lint.linters_by_ft['clojure'] = nil
			-- lint.linters_by_ft['dockerfile'] = nil
			-- lint.linters_by_ft['inko'] = nil
			-- lint.linters_by_ft['janet'] = nil
			-- lint.linters_by_ft['json'] = nil
			-- lint.linters_by_ft['markdown'] = nil
			-- lint.linters_by_ft['rst'] = nil
			-- lint.linters_by_ft['ruby'] = nil
			-- lint.linters_by_ft['terraform'] = nil
			-- lint.linters_by_ft['text'] = nil

			-- Create autocommand which carries out the actual linting
			-- on the specified events.
			local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })
			vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
				group = lint_augroup,
				callback = function()
					-- Only run the linter in buffers that you can modify in order to
					-- avoid superfluous noise, notably within the handy LSP pop-ups that
					-- describe the hovered symbol using Markdown.
					if vim.opt_local.modifiable:get() then
						lint.try_lint()
					end
				end,
			})
		end,
	},
}
