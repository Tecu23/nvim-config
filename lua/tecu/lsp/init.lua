-- ============================================================================
-- LSP Main Initialization Module
-- ============================================================================
local M = {}

-- ============================================================================
-- Setup Function
-- ============================================================================
function M.setup()
    -- Load LSP modules
    require("tecu.lsp.setup").setup()

    -- Setup diagnostic configuration
    M.setup_diagnostics()

    -- Setup LSP handlers
    M.setup_handlers()

    -- Setup autocommands
    M.setup_autocmds()

    -- Setup user commands
    M.setup_commands()
end

-- ============================================================================
-- Diagnostic Configuration
-- ============================================================================
function M.setup_diagnostics()
    -- Configure diagnostic display
    vim.diagnostic.config({
        virtual_text = {
            prefix = function(diagnostic)
            local icons = {
                [vim.diagnostic.severity.ERROR] = "✘",
                [vim.diagnostic.severity.WARN] = "▲",
                [vim.diagnostic.severity.INFO] = "»",
                [vim.diagnostic.severity.HINT] = "⚑",
            }
            return icons[diagnostic.severity] or "●"
            end,
            spacing = 4,
            source = "if_many",
            format =  function(diagnostic)
                -- Show error code if available
                if diagnostic.code then
                    return string.format("%s [%s]", diagnostic.message, diagnostic.code)
                end

                return diagnostic.message
            end,
        },
        signs = {
            text = {
                [vim.diagnostic.severity.ERROR] = "✘",
                [vim.diagnostic.severity.WARN] = "▲",
                [vim.diagnostic.severity.HINT] = "⚑",
                [vim.diagnostic.severity.INFO] = "»",
            },
            linehl = {
                [vim.diagnostic.severity.ERROR] = 'DiagnosticSignError',
            },
            numhl = {
                [vim.diagnostic.severity.ERROR] = 'DiagnosticSignError',
            },
        },
        update_in_insert = false,
		severity_sort = true,
        float = {
            border = "rounded",
            max_width = 80,
            max_height = 20,
            source = "always",
            format = function(diagnostic)
                return string.format("%s: %s", diagnostic.source or "LSP", diagnostic.message)
            end,
        },
    })
end

-- ============================================================================
-- LSP Handlers Configuration
-- ============================================================================
function M.setup_handlers()
end

-- ============================================================================
-- Autocommands
-- ============================================================================
function M.setup_autocmds()
end

-- ============================================================================
-- On Attach Function
-- ============================================================================
function M.on_attach(event)
end

-- ============================================================================
-- On Detach Function
-- ============================================================================
function M.on_detach(event)
end

-- ============================================================================
-- Setup Keymaps
-- ============================================================================
function M.setup_keymaps(bufnr)
end

-- ============================================================================
-- Setup Buffer Settings
-- ============================================================================
function M.setup_buffer_settings(client, bufnr)
end

-- ============================================================================
-- Setup Document Highlight
-- ============================================================================
function M.setup_document_highlight(bufnr)
end

-- ============================================================================
-- Setup Code Lens
-- ============================================================================
function M.setup_codelens(bufnr)
end

-- ============================================================================
-- User Commands
-- ============================================================================
function M.setup_commands()
end


-- ============================================================================
-- Utility Functions
-- ============================================================================

-- Get LSP capabilities
function M.get_capabilities()
end

-- Get common on_attach function
function M.get_on_attach()
	return function(client, bufnr)
		-- This is kept for compatibility with servers that might use it directly
		-- The actual logic is handled by the LspAttach autocmd
	end
end

return M
