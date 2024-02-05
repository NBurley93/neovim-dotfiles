require("neodev").setup({
	library = {
		enabled = true,
		runtime = true,
		types = true,
		plugins = {
			"nvim-dap-ui",
			"telescope.nvim",
			"plenary.nvim",
		},
		setup_jsonls = true,
		lspconfig = true,
		pathStrict = true,
	},
})
