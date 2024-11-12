return {
	"lukas-reineke/indent-blankline.nvim",
	enabled = false,
	event = "BufReadPost",
	opts = {
		scope = {
			show_start = true,
		},
	},
	config = function(_, opts)
		require("ibl").setup(opts)
	end,
}
