-- Dap UI setup
-- For more information, see |:help nvim-dap-ui|
require("dapui").setup({
	-- Set icons to characters that are more likely to work in every terminal.
	--    Feel free to remove or use ones that you like more! :)
	--    Don't feel like these are good choices.
	icons = { expanded = "▾", collapsed = "▸", current_frame = "" },
	expand_lines = true,
	mappings = {
		expand = { "<CR>", "<2-LeftMouse>" },
		open = "o",
		remove = "d",
		edit = "e",
		repl = "r",
		toggle = "t",
	},
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
	layouts = {
		{
			elements = {
				{ id = "scopes", size = 0.33 },
				{ id = "breakpoints", size = 0.17 },
				{ id = "stacks", size = 0.25 },
				{ id = "watches", size = 0.25 },
			},
			size = 0.33,
			position = "right",
		},
		{
			elements = {
				{ id = "repl", size = 0.45 },
				{ id = "console", size = 0.55 },
			},
			size = 0.27,
			position = "bottom",
		},
	},
	floating = {
		max_height = 0.9,
		max_width = 0.5,
		border = "rounded",
		mappings = {
			close = { "q", "<Esc>" },
		},
	},
})

local dap, dapui = require("dap"), require("dapui")
dap.listeners.before.event_terminated["dapui_config"] = function()
	dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
	dapui.close()
end
