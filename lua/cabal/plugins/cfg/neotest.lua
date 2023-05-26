require('neotest').setup({
	icons = {
		failed = "",
		passed = "",
		running = "",
		skipped = "○",
		unknown = "",
	},
	output = {
		open_on_run = false,
	},
	adapters = {
		require 'neotest-python' {
			runner = 'pytest',
		},
	},
})
