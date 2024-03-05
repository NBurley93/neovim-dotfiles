return {
	{
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
		config = function()
			require("ibl").setup({
				indent = {
					char = "│",
					tab_char = "│",
					--highlight = { "Define" },
				},
				scope = {
					char = "│",
				},
				exclude = {
					buftypes = {
						"nvimtree",
					},
					filetypes = {
						"dashboard",
						"mason",
						"toggleterm",
					},
				},
			})
		end,
	},
}
