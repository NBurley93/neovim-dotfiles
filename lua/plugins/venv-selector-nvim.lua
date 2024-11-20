return {
	{
		"linux-cultist/venv-selector.nvim",
        event = 'VeryLazy',
		dependencies = { "neovim/nvim-lspconfig", "nvim-telescope/telescope.nvim", "mfussenegger/nvim-dap-python" },
		opts = { dap_enabled = true },
		branch = "regexp",
	},
}
