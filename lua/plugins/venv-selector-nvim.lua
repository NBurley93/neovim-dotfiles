return {
	{
		"linux-cultist/venv-selector.nvim",
        event = 'VeryLazy',
		dependencies = { "neovim/nvim-lspconfig", "nvim-telescope/telescope.nvim" },
		opts = { dap_enabled = false },
		branch = "regexp",
	},
}
