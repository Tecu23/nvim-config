return {
	"rcarriga/nvim-notify",
	-- lazy = false,
	event = "VeryLazy",
	opts = {
		level = 2,
		minimum_width = 50,
		render = "default",
		stages = "fade",
		timeout = 3000,
		top_down = false,
	},
	config = function(_, opts)
		require("notify").setup(opts)
	end,
}
