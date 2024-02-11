local commonicons = require("common.icons")
require("neotest").setup({

	icons = {
		failed = commonicons.diagnostics.Error,
		passed = commonicons.ui.Check,
		running = commonicons.ui.Gear,
		skipped = commonicons.diagnostics.Information,
		unknown = commonicons.diagnostics.Question,
	},
	output = {
		enabled = true,
		open_on_run = "short",
	},
	status = {
		virtual_text = true,
	},
	adapters = {
		require("neotest-python")({
			runner = "pytest",
			dap = { justMyCode = false },
			pytest_discover_instances = true,
			args = { "--log-level", "DEBUG" },
		}),
	},
	output_panel = {
		enabled = false,
	},
	summary = {
		mappings = {},
	},
})
