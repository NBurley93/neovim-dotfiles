return {
	{
		"williamboman/mason.nvim",
		config = function()
			require("mason").setup({
				ui = {
					icons = {
						package_installed = "",
						package_pending = "󱑤",
						package_uninstalled = "",
					},
				},
			})
		end,
		build = ":MasonUpdate",
	},
	{
		"jay-babu/mason-nvim-dap.nvim",
		config = function()
			local mason = require("mason-nvim-dap")
			local masonregistry = require("mason-registry")
			mason.setup({
				automatic_setup = true,

				handlers = {
					function(config)
						mason.default_setup(config)
					end,
					python = function(config)
						config.adapters = {
							type = "executable",
							command = masonregistry.get_package("debugpy"):get_install_path() .. "/venv/bin/python3",
							args = {
								"-m",
								"-debugpy.adapter",
							},
						}
						mason.default_setup(config)
					end,
				},

				ensure_installed = {
					"debugpy",
					"cpptools",
				},
			})
		end,
		dependencies = { "mfussenegger/nvim-dap", "williamboman/mason.nvim" },
	},
}
