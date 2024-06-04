return {
	{
		"linux-cultist/venv-selector.nvim",
		dependencies = { "neovim/nvim-lspconfig", "nvim-telescope/telescope.nvim", "mfussenegger/nvim-dap-python" },
		opts = { dap_enabled = true },
		branch = "regexp",
		config = function()
			require("venv-selector").setup()
		end,
	},
}
