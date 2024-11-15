return {
	"Bekaboo/dropbar.nvim",
	event = { "BufReadPost", "BufNewFile" },

	-- optional, but required for fuzzy finder support
	dependencies = {
		"nvim-telescope/telescope-fzf-native.nvim",
		build = "make",
	},
}
