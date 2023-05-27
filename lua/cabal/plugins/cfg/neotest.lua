require('neotest').setup({
	icons = {
		failed = "",
		passed = "",
		running = "",
		skipped = "○",
		unknown = "",
	},
	output = {
		open_on_run = true,
	},
	adapters = {
		require('neotest-python')({
			runner = 'pytest',
		}),
		--[[ require('neotest-gtest'), ]]
	},
	output_panel = {
		enabled = false,
	},
})
