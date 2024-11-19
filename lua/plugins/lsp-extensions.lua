return {
	{ "nvimtools/none-ls.nvim" },
	{ "jay-babu/mason-null-ls.nvim" },
	{
		"folke/lazydev.nvim",
		ft = "lua",
	},
	{ "onsails/lspkind.nvim" },
	{
		"williamboman/mason-lspconfig.nvim",
		dependencies = {
			"williamboman/mason.nvim",
		},
		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = {
					"gopls",
					"cmake",
					"marksman",
					"clangd",
					"lua_ls",
					"ruff_lsp",
					"eslint",
					"rust_analyzer",
					"yamlls",
					"powershell_es",
					"jsonls",
					"terraformls",
					"dockerls",
					"html",
				},
			})
		end,
	},
	{ "neovim/nvim-lspconfig" },
	{
		"j-hui/fidget.nvim",
		config = function()
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
		end,
	},
	{ "p00f/clangd_extensions.nvim" },
}
