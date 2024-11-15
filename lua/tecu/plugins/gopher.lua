return {
	"olexsmir/gopher.nvim",
	ft = "go",
	-- branch = "develop", -- if you want develop branch
	-- keep in mind, it might break everything
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-treesitter/nvim-treesitter",
		"mfussenegger/nvim-dap", -- (optional) only if you use `gopher.dap`
	},
	-- (optional) will update plugin's deps on every update
	-- build = function()
	-- 	vim.cmd.GoInstallDeps()
	-- end,
	---@type gopher.Config
	opts = {
		commands = {
			go = "go",
			gomodifytags = "gomodifytags",
			gotests = "gotests",
			impl = "impl",
			iferr = "iferr",
		},
		gotests = {
			-- gotests doesn't have template named "default" so this plugin uses "default" to set the default template
			template = "default",
			-- path to a directory containing custom test code templates
			template_dir = nil,
			-- switch table tests from using slice to map (with test name for the key)
			-- works only with gotests installed from develop branch
			named = false,
		},
		gotag = {
			transform = "snakecase",
		},
	},

	config = function(_, opts)
		require("gopher").setup(opts)

		-- Golang KeyMaps
		vim.keymap.set("n", "<leader>ggsj", "<cmd> GoTagAdd json <CR>", { desc = "[G]o Add Json Struct Tags" })
		vim.keymap.set("n", "<leader>ggsy", "<cmd> GoTagAdd yaml <CR>", { desc = "[G]o Add Yaml Struct Tags" })
		vim.keymap.set(
			"n",
			"<leader>ggsv",
			"<cmd> GoTagAdd validate:required <CR>",
			{ desc = "[G]o Add Struct Validation" }
		)

		vim.keymap.set("n", "<leader>ggcmt", "<cmd> GoCmt <CR>", { desc = "[G]o Generate Doc Comments " })
		vim.keymap.set("n", "<leader>gge", "<cmd> GoIfErr <CR>", { desc = "[G]o Generate Error" })

		vim.keymap.set("n", "<leader>ggmt", "<cmd> GoMod tidy <CR>", { desc = "[G]o Mod Tidy" })
		vim.keymap.set("n", "<leader>ggmt", "<cmd> GoMod tidy <CR>", { desc = "[G]o Mod Tidy" })
	end,
}
