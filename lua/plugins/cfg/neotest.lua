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
		open_on_run = true,
	},
	adapters = {
		require("neotest-python")({
			runner = "pytest",
			dap = { justMyCode = false },
		}),
	},
	output_panel = {
		enabled = false,
	},
})
