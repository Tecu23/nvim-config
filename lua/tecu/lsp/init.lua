-- lua/tecu/lsp/init.lua

local M = {}

local on_attach = require("tecu.lsp.setup")

-- Function to set up LSP servers
function M.setup_servers()
	-- LSP servers and clients are able to communicate to each other what features they support.
	--  By default, Neovim doesn't support everything that is in the LSP specification.
	--  When you add nvim-cmp, luasnip, etc. Neovim now has *more* capabilities.
	--  So, we create new capabilities with nvim cmp, and then broadcast that to the servers.
	local capabilities = vim.lsp.protocol.make_client_capabilities()
	capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())

	local servers = {}

	-- Load server configuration from the 'servers' directory
	local servers_dir = vim.fn.stdpath("config") .. "/lua/tecu/lsp/servers"
	local server_files = vim.fn.readdir(servers_dir)

	for _, file in ipairs(server_files) do
		if file:sub(-4) == ".lua" then
			local server_name = vim.fn.fnamemodify(file, ":r")
			print(server_name)
			servers[server_name] = require("tecu.lsp.servers." .. server_name)
		end
	end

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
		"eslint-lsp",

		-- Formatters
		"stylua", -- Used to format Lua code
		"prettierd",
		"rustywind", -- Tailwind css formatter
		-- "rubocop",
	})
	require("mason-tool-installer").setup({ ensure_installed = ensure_installed })

	require("mason-lspconfig").setup({
		handlers = {
			function(server_name)
				local server = servers[server_name] or {}
				-- This handles overriding only values explicitly passed
				-- by the server configuration above. Useful when disabling
				-- certain features of an LSP (for example, turning off formatting for ts_ls)
				server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
				require("lspconfig")[server_name].setup(server)
			end,
		},
	})
end

return function()
	vim.api.nvim_create_autocmd("LspAttach", {
		group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
		callback = on_attach.setup,
	})

	M.setup_servers()
end
