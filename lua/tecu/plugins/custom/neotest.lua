local M = {
    "nvim-neotest/neotest",
    dependencies = {
        "nvim-neotest/nvim-nio",
        "nvim-lua/plenary.nvim",
        "antoinemadec/FixCursorHold.nvim",
        "nvim-treesitter/nvim-treesitter",
        "nvim-neotest/neotest-go",
        "haydenmeade/neotest-jest",
        "nvim-neotest/neotest-python",
        "nvim-neotest/neotest-plenary",
    },
    keys = {
        {
            "<Leader>tn",
            function()
                require("neotest").run.run()
            end,
            desc = "Run nearest test",
        },
        {
            "<Leader>tf",
            function()
                require("neotest").run.run(vim.fn.expand("%"))
                require("neotest").summary.open()
            end,
            desc = "Run all tests in file",
        },
        {
            "<Leader>ta",
            function()
                require("neotest").run.run(vim.fn.getcwd())
                require("neotest").summary.open()
            end,
            desc = "Run all tests in suite",
        },
    },
}
function M.config()
    local neotest = require("neotest")
    neotest.setup({
        projects = {},
        consumers = {},
        log_level = 3,
        diagnostic = {
            enabled = false,
            severity = 1,
        },
        floating = {
            options = {},
            border = "rounded",
            max_height = 0.6,
            max_width = 0.6,
        },
        highlights = {
            adapter_name = "NeotestAdapterName",
            border = "NeotestBorder",
            dir = "NeotestDir",
            expand_marker = "NeotestExpandMarker",
            failed = "NeotestFailed",
            file = "NeotestFile",
            focused = "NeotestFocused",
            indent = "NeotestIndent",
            namespace = "NeotestNamespace",
            passed = "NeotestPassed",
            running = "NeotestRunning",
            skipped = "NeotestSkipped",
            test = "NeotestTest",
        },
        icons = {
            child_indent = "│",
            child_prefix = "├",
            collapsed = "─",
            expanded = "╮",
            failed = "✖",
            final_child_indent = " ",
            final_child_prefix = "╰",
            non_collapsible = "─",
            passed = "✔",
            running = "",
            skipped = "ﰸ",
            unknown = "?",
        },
        output = {
            enabled = true,
            open_on_run = true,
        },
        output_panel = {
            enabled = true,
            open = "botright split | resize 15",
        },
        run = {
            enabled = true,
        },
        quickfix = {
            enabled = true,
            open = false,
        },
        state = {
            enabled = true,
        },
        status = {
            enabled = true,
            virtual_text = false,
            signs = true,
        },
        strategies = {
            integrated = {
                height = 40,
                width = 120,
            },
        },
        summary = {
            animated = true,
            enabled = true,
            expand_errors = true,
            open = "botright vsplit | vertical resize 50",
            follow = true,
            mappings = {
                attach = "a",
                clear_marked = "M",
                clear_target = "T",
                debug = "d",
                debug_marked = "D",
                expand = { "<CR>", "<2-LeftMouse>" },
                expand_all = "e",
                help = "?",
                jumpto = "i",
                mark = "m",
                next_failed = "J",
                output = "o",
                prev_failed = "K",
                run = "r",
                run_marked = "R",
                short = "O",
                stop = "u",
                target = "t",
                watch = "w",
            },
        },

        watch = {
            enabled = true,
            symbol_queries = {
                go = "        ;query\n        ;Captures imported types\n        (qualified_type name: (type_identifier) @symbol)\n        ;Captures package-local and built-in types\n        (type_identifier)@symbol\n        ;Captures imported function calls and variables/constants\n        (selector_expression field: (field_identifier) @symbol)\n        ;Captures package-local functions calls\n        (call_expression function: (identifier) @symbol)\n      ",
                haskell = "        ;query\n        ;explicit import\n        ((import_item [(variable)]) @symbol)\n        ;symbols that may be imported implicitly\n        ((type) @symbol)\n        (qualified_variable (variable) @symbol)\n        (exp_apply (exp_name (variable) @symbol))\n        ((constructor) @symbol)\n        ((operator) @symbol)\n      ",
                javascript = '  ;query\n  ;Captures named imports\n  (import_specifier name: (identifier) @symbol)\n  ;Captures default import\n  (import_clause (identifier) @symbol)\n  ;Capture require statements\n  (variable_declarator \n  name: (identifier) @symbol\n  value: (call_expression (identifier) @function  (#eq? @function "require")))\n  ;Capture namespace imports\n  (namespace_import (identifier) @symbol)\n',
                lua = '        ;query\n        ;Captures module names in require calls\n        (function_call\n          name: ((identifier) @function (#eq? @function "require"))\n          arguments: (arguments (string) @symbol))\n      ',
                python = "        ;query\n        ;Captures imports and modules they're imported from\n        (import_from_statement (_ (identifier) @symbol))\n        (import_statement (_ (identifier) @symbol))\n      ",
                ruby = '        ;query\n        ;rspec - class name\n        (call\n          method: (identifier) @_ (#match? @_ "^(describe|context)")\n          arguments: (argument_list (constant) @symbol )\n        )\n\n        ;rspec - namespaced class name\n        (call\n          method: (identifier)\n          arguments: (argument_list\n            (scope_resolution\n              name: (constant) @symbol))\n        )\n      ',
                rust = "        ;query\n        ;submodule import\n        (mod_item\n          name: (identifier) @symbol)\n        ;single import\n        (use_declaration\n          argument: (scoped_identifier\n            name: (identifier) @symbol))\n        ;import list\n        (use_declaration\n          argument: (scoped_use_list\n            list: (use_list\n                [(scoped_identifier\n                   path: (identifier)\n                   name: (identifier) @symbol)\n                 ((identifier) @symbol)])))\n        ;wildcard import\n        (use_declaration\n          argument: (scoped_use_list\n            path: (identifier)\n            [(use_list\n              [(scoped_identifier\n                path: (identifier)\n                name: (identifier) @symbol)\n                ((identifier) @symbol)\n              ])]))\n      ",
                tsx = '  ;query\n  ;Captures named imports\n  (import_specifier name: (identifier) @symbol)\n  ;Captures default import\n  (import_clause (identifier) @symbol)\n  ;Capture require statements\n  (variable_declarator \n  name: (identifier) @symbol\n  value: (call_expression (identifier) @function  (#eq? @function "require")))\n  ;Capture namespace imports\n  (namespace_import (identifier) @symbol)\n',
                typescript = '  ;query\n  ;Captures named imports\n  (import_specifier name: (identifier) @symbol)\n  ;Captures default import\n  (import_clause (identifier) @symbol)\n  ;Capture require statements\n  (variable_declarator \n  name: (identifier) @symbol\n  value: (call_expression (identifier) @function  (#eq? @function "require")))\n  ;Capture namespace imports\n  (namespace_import (identifier) @symbol)\n',
            },
        },

        adapters = {
            require("neotest-go"),
            require("neotest-jest"),
            require("neotest-plenary"),
            require("neotest-python"),
        },
    })

    vim.keymap.set("n", "<Leader>tu", function()
        neotest.summary.toggle()
    end, { desc = "Toggle testing UI" })
end

return M
