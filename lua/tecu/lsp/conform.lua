local M = {
    "stevearc/conform.nvim",
}

function M.config()
    require("conform").setup({
        lazy = false,
        notify_on_error = false,
        format_on_save = function(bufnr)
            -- Disable "format_on_save lsp_fallback" for languages that don't
            -- have a well standardized coding style. You can add additional
            -- languages here or re-enable it for the disabled ones.
            local disable_filetypes = { c = true, cpp = true }
            return {
                timeout_ms = 500,
                lsp_fallback = not disable_filetypes[vim.bo[bufnr].filetype],
            }
        end,
        formatters = {
            stylua = {
                prepend_args = { "--indent-type", "Spaces", "--indent-width", "4" },
            },
            biome = {
                prepend_args = {
                    "format",
                    "--indent-style",
                    "space",
                    "--indent-width",
                    "4",
                    "--line-width",
                    "180",
                },
            },
        },
        formatters_by_ft = {
            css = { "biome", "prettierd", "prettier", stop_after_first = true },
            go = { "gofumpt", "goimports-reviser", "golines" },
            html = { "biome", "prettierd", "prettier", stop_after_first = true },
            json = { "biome", "prettierd", "prettier", stop_after_first = true },
            javascript = { "biome", "prettierd", "prettier", stop_after_first = true },
            javascriptreact = { "biome", "prettierd", "prettier", stop_after_first = true },
            lua = { "stylua" },
            markdown = { "prettier", "markdownlint", stop_after_first = true },
            python = { "isort", "black" },
            sql = { "sqlfmt", "sqlfluff" },
            typescript = { "biome", "prettierd", "prettier", stop_after_first = true },
            typescriptreact = { "biome", "prettierd", "prettier", stop_after_first = true },
            yaml = { "yamlfmt" },
        },
    })
end

return M
