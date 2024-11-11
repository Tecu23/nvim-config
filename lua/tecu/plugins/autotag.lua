---@type NvPluginSpec
return {
	"windwp/nvim-ts-autotag",
	filetypes = {
		"javascript",
		"javascriptreact",
		"typescript",
		"typescriptreact",
	},
	config = function()
		require("nvim-ts-autotag").setup()
	end,
}
