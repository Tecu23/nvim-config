-- ============================================================================
-- LSP Setup Module - Handles server installation and configuration
-- ============================================================================
local M = {}

-- ============================================================================
-- Server List
-- ============================================================================
local servers = {
    -- Go
    "gopls",

    -- Ruby
    "ruby_lsp",

    -- Web Development
    "html",
    "cssls",
    "tailwindcss",
    "eslint",

    -- JSON/YAML
    "jsonls",
    "yamlls",

    -- Docker
    "dockerls",
    "docker_compose_language_service",

    -- Lua
    "lua_ls",

    -- Bash
    "bashls",

    -- SQL
    "sqls",

    -- Prisma
    -- "prismals",

    -- Postgres
    -- "postgrestools",

    -- GraphQL
    -- "graphsql",
}

-- ============================================================================
-- Main Setup Function
-- ============================================================================
function M.setup()
    -- Setup Mason for automatic installation
    local mason_available = M.setup_mason()

    if mason_available then
        -- Wait a bit for Mason to initialize
        vim.defer_fn(function()
            M.setup_servers()
        end, 100)
    else
        -- Setup servers directly without Mason
        M.setup_servers()
    end
end

-- ============================================================================
-- Mason Setup
-- ============================================================================
function M.setup_mason()
    local mason_ok, mason = pcall(require, "mason")
    if not mason_ok then
        vim.notify("Mason not found. Install mason.nvim for automatic LSP installation.", vim.log.levels.WARN)
        return false
    end

    local mason_lspconfig_ok, mason_lspconfig = pcall(require, "mason-lspconfig")
    if not mason_lsp_config_ok then
        vim.notify("mason-lspconfig not found.", vim.log.levels.WARN)
        return false
    end

    -- Setup Mason
    mason.setup()

    -- Setup mason-lspconfig
    mason_lspconfig.setup({
        ensure_installed = servers,
        automatic_installation = true,
    })

    -- Install additional tools (formatters, linters, DAP)
    local mason_registry = require("mason-registry")
    local tools = {
        -- Formatters
        "stylua",

        "prettierd",
        "prettier",

        "yamlfmt",

        "gofumpt",
        "goimports",
        "goimports-revisers",
        "golines",

        "rubocop",

        "shfmt",

        "sqlfmt",

        -- Linters
        "eslint",

        "yamllint",
        "jsonlint",
        "markdownlint",

        "pylint",

        "shellcheck",

        "revive",
        "golangci-lint",

        -- DAP
    }

    for _, tools in ipairs(tools) do
        local package = mason_registry.get_package(tool)
        if not package:is_installed() then
            vim.notify("Installing " .. tool, vim.log.levels.INFO)
            package:install()
        end
    end

    return true
end

-- ============================================================================
-- Setup Individual Servers
-- ============================================================================
function M.setup_servers()
    local lspconfig = require("lspconfig")
    local lsp = require("tecu.lsp")

    -- Get common capabilities and on_attach
    local capabilities = lsp.get_capabilities()
    local on_attach = lsp.get_on_attach()

    -- Setup each server
    for _, server_name in ipairs(servers) do
        -- Load server-specific configuration
        local server_config = M.get_server_config(server_name)

        -- Merge with default config
        local config = vim.tbl_deep_extend("force", {
            capabilities = capabilities,
            on_attach = on_attach,
        }, server_config or {})

        -- Setup the server
        if lspconfig[server_name] then
            lspconfig[server_name].setup(config)
        else
            vim.notify("Server " .. server_name .. " not found in lspconfig", vim.log.levels.WARN)
        end
    end

    -- Setup TypeScript tools (special case, not using lspconfig)
    M.setup_typescript_tools()
end

-- ============================================================================
-- Get Server Configuration
-- ============================================================================
function M.get_server_config(server_name)
    -- Try to load server_specific configuration

    local config_path = "tecu.lsp.servers."  .. server_name
    local ok, config = pcall(require, config_path)

    if ok then
        return config
    end

    vim.notify("Could not load server " .. server_name, vim.log.levels.WARN)
end

-- ============================================================================
-- Setup TypeScript Tools
-- ============================================================================
function M.setup_typescript_tools()
    local ok, typescript_tools = pcall(require, "typescript-tools")
    if not ok then
        vim.notify("typescript-tools.nvim not found", vim.log.levels.WARN)
        return
    end

    -- Typescript tools is configured in the plugin spec
    -- but we can add additional setup here if needed
    typescript_tools.setup({
        on_attach = require("tecu.lsp").get_on_attach(),
        capabilities = require("tecu.lsp").get_capabilities(),
    })
end
