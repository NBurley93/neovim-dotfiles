require("fidget").setup({
	progress = {
		display = {
			done_icon = "✅",
			progress_icon = {
				pattern = "circle_quarters",
				period = 1,
			},
		},
	},
	notification = {
		window = {
			winblend = 0,
			relative = "editor",
			x_padding = 2,
			y_padding = 1,
		},
	},
})
