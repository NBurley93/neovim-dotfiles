return {
	{
		"Wansmer/treesj",
		config = function()
			require("treesj").setup({})
		end,
		dependencies = { "nvim-treesitter/nvim-treesitter" },
	},
}
