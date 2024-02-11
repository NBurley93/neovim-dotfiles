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
