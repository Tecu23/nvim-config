local M = {
    "stevearc/conform.nvim",
}

function M.config()
    require("conform").setup({
        lazy = false,
        keys = {
            {
                "<leader>fu",
                function()
                    require("conform").format({ async = true, lsp_fallback = true })
                end,
                mode = "",
                desc = "[F]ormat buffer",
            },
        },
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
            prettierd = {},
        },
        formatters_by_ft = {
            lua = { "stylua" },
            python = { "isort", "black" },
            go = { "gofumpt", "goimports-reviser", "golines" },
            markdown = { "markdownlint" },
            sql = { "sqlfluff" },
            typescript = { { "prettierd", "prettier" } },
            typescriptreact = { { "prettierd", "prettier" } },
            javascript = { { "prettierd", "prettier" } },
            javascriptreact = { { "prettierd", "prettier" } },
            json = { { "prettierd", "prettier" } },
            html = { { "prettierd", "prettier" } },
            css = { { "prettierd", "prettier" } },
        },
    })
end

return M
