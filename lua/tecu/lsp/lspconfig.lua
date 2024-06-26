local M = {
    "neovim/nvim-lspconfig",
    dependencies = {
        -- Automatically install LSPs and related tools to stdpath for Neovim
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "WhoIsSethDaniel/mason-tool-installer.nvim",
        -- Useful status updates for LSP.
        {
            "j-hui/fidget.nvim",
            tag = "v1.4.1",
            opts = {
                notification = {
                    window = {
                        normal_hl = "Comment", -- Base highlight group in the notification window
                        winblend = 0, -- Background color opacity in the notification window
                        border = "none", -- Border around the notification window
                        zindex = 45, -- Stacking priority of the notification window
                        max_width = 0, -- Maximum width of the notification window
                        max_height = 0, -- Maximum height of the notification window
                        x_padding = 1, -- Padding from right edge of window boundary
                        y_padding = 0, -- Padding from bottom edge of window boundary
                        align = "bottom", -- How to align the notification window
                        relative = "editor", -- What the notification window position is relative to
                    },
                },
            },
        },

        -- `neodev` configures Lua LSP for your Neovim config, runtime and plugins
        -- used for completion, annotations and signatures of Neovim apis
        { "folke/neodev.nvim", opts = {} },
    },
}

local function keymaps(buf)
    -- In this case, we create a function that lets us more easily define mappings specific
    -- for LSP related items. It sets the mode, buffer and description for us each time.
    local map = function(keys, func, desc)
        vim.keymap.set("n", keys, func, { buffer = buf, desc = "LSP: " .. desc })
    end

    -- Jump to the definition of the word under your cursor.
    --  This is where a variable was first declared, or where a function is defined, etc.
    --  To jump back, press <C-t>.
    map("gd", require("telescope.builtin").lsp_definitions, "[G]oto [D]efinition")

    -- Find references for the word under your cursor.
    map("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")

    -- Jump to the implementation of the word under your cursor.
    --  Useful when your language has ways of declaring types without an actual implementation.
    map("gI", require("telescope.builtin").lsp_implementations, "[G]oto [I]mplementation")

    -- Jump to the type of the word under your cursor.
    --  Useful when you're not sure what type a variable is and you want to see
    --  the definition of its *type*, not where it was *defined*.
    map("<leader>D", require("telescope.builtin").lsp_type_definitions, "Type [D]efinition")

    -- Fuzzy find all the symbols in your current document.
    --  Symbols are things like variables, functions, types, etc.
    map("<leader>ds", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")

    -- Fuzzy find all the symbols in your current workspace.
    --  Similar to document symbols, except searches over your entire project.
    map("<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")

    -- Rename the variable under your cursor.
    --  Most Language Servers support renaming across files, etc.
    map("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")

    -- Execute a code action, usually your cursor needs to be on top of an error
    -- or a suggestion from your LSP for this to activate.
    map("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")

    -- Move forward/backward through diagnostics
    map("<leader>lj", vim.diagnostic.goto_next, "[N]ext [D]iagnostic")
    map("<leader>lk", vim.diagnostic.goto_prev, "[P]rev [D]iagnostic")

    -- Opens a popup that displays documentation about the word under your cursor
    --  See `:help K` for why this keymap.
    map("K", vim.lsp.buf.hover, "Hover Documentation")

    -- this is Goto Declaration.
    --  For example, in C this would take you to the header.
    map("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
end

function M.config()
    vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
        callback = function(event)
            -- Setting the keymaps for the LSP
            keymaps(event.buf)

            -- The following two autocommands are used to highlight references of the
            -- word under your cursor when your cursor rests there for a little while.
            --    See `:help CursorHold` for information about when this is executed
            --
            -- When you move your cursor, the highlights will be cleared (the second autocommand).
            local client = vim.lsp.get_client_by_id(event.data.client_id)
            if client and client.server_capabilities.documentHighlightProvider then
                vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
                    buffer = event.buf,
                    callback = vim.lsp.buf.document_highlight,
                })

                vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
                    buffer = event.buf,
                    callback = vim.lsp.buf.clear_references,
                })
            end

            -- The following autocommand is used to enable inlay hints in your
            -- code, if the language server you are using supports them
            --
            -- This may be unwanted, since they displace some of your code
            if client and client.server_capabilities.inlayHintProvider and vim.lsp.inlay_hint then
                vim.keymap.set("n", "<leader>th", function()
                    vim.lsp.inlay_hint.enable(0, not vim.lsp.inlay_hint.is_enabled())
                end, { desc = "[T]oggle Inlay [H]ints" })
            end
        end,
    })

    vim.api.nvim_create_autocmd("BufWritePre", {
        pattern = { "*.go" },
        callback = function()
            local params = vim.lsp.util.make_range_params(nil, "utf-16")
            params.context = { only = { "source.organizeImports" } }
            local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, 3000)
            for _, res in pairs(result or {}) do
                for _, r in pairs(res.result or {}) do
                    if r.edit then
                        vim.lsp.util.apply_workspace_edit(r.edit, "utf-16")
                    else
                        vim.lsp.buf.execute_command(r.command)
                    end
                end
            end
        end,
    })

    local util = require("lspconfig.util")
    -- LSP servers and clients are able to communicate to each other what features they support.
    --  By default, Neovim doesn't support everything that is in the LSP specification.
    --  When you add nvim-cmp, luasnip, etc. Neovim now has *more* capabilities.
    --  So, we create new capabilities with nvim cmp, and then broadcast that to the servers.
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())

    -- Enable the following language servers
    --  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
    --
    --  Add any additional override configuration in the following tables. Available keys are:
    --  - cmd (table): Override the default command used to start the server
    --  - filetypes (table): Override the default list of associated filetypes for the server
    --  - capabilities (table): Override fields in capabilities. Can be used to disable certain LSP features.
    --  - settings (table): Override the default settings passed when initializing the server.
    --        For example, to see the options for `lua_ls`, you could go to: https://luals.github.io/wiki/settings/
    local servers = {
        cssls = {},
        dockerls = {},
        eslint = {},
        gopls = {
            cmd = { "gopls" },
            filetypes = { "go", "gomod", "gowork", "gotmpl" },
            root_dir = util.root_pattern("go.work", "go.mod", ".git"),
            settings = {
                -- https://go.googlesource.com/vscode-go/+/HEAD/docs/settings.md#settings-for
                -- https://www.lazyvim.org/extras/lang/go (borrowed some ideas from here)
                gopls = {
                    analyses = {
                        fieldalignment = false, -- find structs that would use less memory if their fields were sorted
                        nilness = true,
                        unusedparams = true,
                        unusedwrite = true,
                        useany = true,
                    },
                    codelenses = {
                        gc_details = false,
                        generate = true,
                        regenerate_cgo = true,
                        run_govulncheck = true,
                        test = true,
                        tidy = true,
                        upgrade_dependency = true,
                        vendor = true,
                    },
                    experimentalPostfixCompletions = true,
                    hints = {
                        assignVariableTypes = true,
                        compositeLiteralFields = true,
                        compositeLiteralTypes = true,
                        constantValues = true,
                        functionTypeParameters = true,
                        parameterNames = true,
                        rangeVariableTypes = true,
                    },
                    gofumpt = true,
                    semanticTokens = true,
                    -- DISABLED: staticcheck
                    --
                    -- gopls doesn't invoke the staticcheck binary.
                    -- Instead it imports the analyzers directly.
                    -- This means it can report on issues the binary can't.
                    -- But it's not a good thing (like it initially sounds).
                    -- You can't then use line directives to ignore issues.
                    --
                    -- Instead of using staticcheck via gopls.
                    -- We have golangci-lint execute it instead.
                    --
                    -- For more details:
                    -- https://github.com/golang/go/issues/36373#issuecomment-570643870
                    -- https://github.com/golangci/golangci-lint/issues/741#issuecomment-1488116634
                    --
                    -- staticcheck = true,
                    usePlaceholders = true,
                },
            },
        },
        html = {},
        jsonls = {},
        lua_ls = {
            -- cmd = {...},
            -- filetypes = { ...},
            -- capabilities = {},
            settings = {
                Lua = {
                    completion = {
                        callSnippet = "Replace",
                    },
                    -- You can toggle below to ignore Lua_LS's noisy `missing-fields` warnings
                    -- diagnostics = { disable = { 'missing-fields' } },
                },
            },
        },
        pyright = {},
        sqls = {},
        tailwindcss = {},
        tsserver = {},
        yamlls = {},
    }

    -- Ensure the servers and tools above are installed
    --  To check the current status of installed tools and/or manually install
    --  other tools, you can run
    --    :Mason
    --
    --  You can press `g?` for help in this menu.
    require("mason").setup()

    -- You can add other tools here that you want Mason to install
    -- for you, so that they are available from within Neovim.
    local ensure_installed = vim.tbl_keys(servers or {})
    vim.list_extend(ensure_installed, {

        -- Linters
        "biome",
        "revive",
        "gofumpt",
        "gomodifytags",
        "markdownlint",
        "sqlfluff",
        "codespell",

        -- Formatters
        "stylua", -- Used to format Lua code
        "isort",
        "black",
        "goimports-reviser",
        "golines",
        "prettierd",
        "prettier",
    })

    require("mason-tool-installer").setup({ ensure_installed = ensure_installed })

    require("mason-lspconfig").setup({
        handlers = {
            function(server_name)
                local server = servers[server_name] or {}
                -- This handles overriding only values explicitly passed
                -- by the server configuration above. Useful when disabling
                -- certain features of an LSP (for example, turning off formatting for tsserver)
                server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
                require("lspconfig")[server_name].setup(server)
            end,
        },
    })
end

return M
