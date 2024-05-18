local M = {
    "mfussenegger/nvim-dap",
    dependencies = {
        -- Creates a beautiful debugger UI
        "rcarriga/nvim-dap-ui",

        -- Required dependency for nvim-dap-ui
        "nvim-neotest/nvim-nio",

        -- Installs the debug adapters for you
        "williamboman/mason.nvim",
        "jay-babu/mason-nvim-dap.nvim",

        -- Add your own debuggers here
        "leoluz/nvim-dap-go",
    },
}

function M.config()
    local dap = require("dap")
    local dapui = require("dapui")

    require("mason-nvim-dap").setup({
        automatic_installation = true,
        -- Makes a best effort to setup the various debuggers with
        -- reasonable debug configurations
        automatic_setup = true,

        -- You can provide additional configuration to the handlers,
        -- see mason-nvim-dap README for more information
        handlers = {},

        -- You'll need to check that you have the required things installed
        -- online, please don't ask me how to install them :)
        ensure_installed = {
            -- Update this to ensure that you have the debuggers for the langs you want
            "delve",
        },
    })

    dap.listeners.before.attach.dapui_config = function()
        dapui.open()
    end
    dap.listeners.before.launch.dapui_config = function()
        dapui.open()
    end
    dap.listeners.before.event_terminated.dapui_config = function()
        dapui.close()
    end
    dap.listeners.before.event_exited.dapui_config = function()
        dapui.close()
    end
    dap.listeners.after.event_initialized["dapui_config"] = dapui.open
    dap.listeners.before.event_terminated["dapui_config"] = dapui.close
    dap.listeners.before.event_exited["dapui_config"] = dapui.close

    -- Install golang specific config
    require("dap-go").setup({
        ft = "go",
    })

    -- Dap UI setup
    -- For more information, see |:help nvim-dap-ui|
    dapui.setup({
        -- Set icons to characters that are more likely to work in every terminal.
        --    Feel free to remove or use ones that you like more! :)
        --    Don't feel like these are good choices.
        icons = { expanded = "▾", collapsed = "▸", current_frame = "*" },
        controls = {
            icons = {
                pause = "⏸",
                play = "▶",
                step_into = "⏎",
                step_over = "⏭",
                step_out = "⏮",
                step_back = "b",
                run_last = "▶▶",
                terminate = "⏹",
                disconnect = "⏏",
            },
        },
    })

    -- Basic debugging keymaps, feel free to change to your liking!
    vim.keymap.set("n", "<leader>dc", dap.continue, { desc = "Debug: Start/Continue" })
    vim.keymap.set("n", "<leader>di", dap.step_into, { desc = "Debug: Step Into" })
    vim.keymap.set("n", "<leader>do", dap.step_over, { desc = "Debug: Step Over" })
    vim.keymap.set("n", "<leader>dot", dap.step_out, { desc = "Debug: Step Out" })
    vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint, { desc = "Debug: Toggle Breakpoint" })
    vim.keymap.set("n", "<leader>dB", function()
        dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
    end, { desc = "Debug: Set Breakpoint" })

    vim.keymap.set("n", "<leader>dus", function()
        local widgets = require("dap.ui.widgets")
        local sidebar = widgets.sidebar(widgets.scopes)
        sidebar.open()
    end, { desc = "Open Debugging sidebar" })

    -- Toggle to see last session result. Without this, you can't see session output in case of unhandled exception.
    vim.keymap.set("n", "<leader>ls", dapui.toggle, { desc = "Debug: See last session result." })

    -- Testing Keymaps
    vim.keymap.set("n", "<leader>dgt", function()
        require("dap-go").debug_test()
    end, { desc = "Debug go test" })
    vim.keymap.set("n", "<leader>dgl", function()
        require("dap-go").debug_last_test()
    end, { desc = "Debug last go test" })
end

return M
