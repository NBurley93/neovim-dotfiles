-- Dap UI setup
-- For more information, see |:help nvim-dap-ui|
require('dapui').setup({
	-- Set icons to characters that are more likely to work in every terminal.
	--    Feel free to remove or use ones that you like more! :)
	--    Don't feel like these are good choices.
	icons = { expanded = "▾", collapsed = "▸", current_frame = "" },
	controls = {
		icons = {
			pause = "",
			play = "",
			step_into = "󰆹",
			step_over = "󰆷",
			step_out = "󰆸",
			step_back = "",
			run_last = "",
			terminate = "",
		},
	},
})
