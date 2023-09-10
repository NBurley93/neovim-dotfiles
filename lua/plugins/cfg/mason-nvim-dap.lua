local mason = require("mason-nvim-dap")
mason.setup({
	automatic_setup = true,

	handlers = {
		function(config)
			mason.default_setup(config)
		end,
		python = function(config)
			config.adapters = {
				type = "executable",
				command = vim.fn.stdpath("data") .. "/mason/packages/debugpy/venv/bin/python3",
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
