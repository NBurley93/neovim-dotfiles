return {
	{
		"rcarriga/nvim-notify",
		config = function()
			require("notify").setup({
				render = "minimal",
				stages = "slide",
				fps = 40,
			})
			vim.notify = require("notify")
		end,
	},
}
