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
                prepend_args = { "format", "--indent-style", "space", "--indent-width", "4", "--line-width", "180" },
            },
        },
        formatters_by_ft = {
            lua = { "stylua" },
            python = { "isort", "black" },
            go = { "goimports-reviser", "golines" },
            markdown = { "markdownlint" },
            sql = { "sqlfluff" },
            typescript = { { "biome", "prettierd", "prettier" } },
            typescriptreact = { { "biome", "prettierd", "prettier" } },
            javascript = { { "biome", "prettierd", "prettier" } },
            javascriptreact = { { "biome", "prettierd", "prettier" } },
            json = { { "biome", "prettierd", "prettier" } },
            html = { { "biome", "prettierd", "prettier" } },
            css = { { "biome", "prettierd", "prettier" } },
        },
    })
end

return M
