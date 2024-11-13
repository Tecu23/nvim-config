return {
	"rcarriga/nvim-notify",
	-- lazy = false,
	event = "VeryLazy",
	opts = {
		level = 2,
		minimum_width = 50,
		render = "compact",
		stages = "fade",
		timeout = 3000,
		top_down = false,
		background_colour = "#00000000",
	},
	config = function(_, opts)
		require("notify").setup(opts)
	end,
}
