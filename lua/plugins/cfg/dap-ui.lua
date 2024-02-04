-- Dap UI setup
-- For more information, see |:help nvim-dap-ui|
require("dapui").setup({
	-- Set icons to characters that are more likely to work in every terminal.
	--    Feel free to remove or use ones that you like more! :)
	--    Don't feel like these are good choices.

	icons = { expanded = "", collapsed = "", current_frame = "" },
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
		element = "repl",
		icons = {
			pause = "󱤳",
			play = "󱤵",
			run_last = "󱑞",
			step_back = "",
			step_into = "󰆹",
			step_out = "󰆸",
			step_over = "󰆷",
			terminate = "󱤷",
		},
	},
	layouts = {
		{
			elements = {
				{ id = "repl", size = 0.5 },
				{ id = "console", size = 0.5 },
			},
			size = 0.25,
			position = "bottom",
		},
		{
			elements = {
				{ id = "scopes", size = 0.25 },
				{ id = "watches", size = 0.25 },
				{ id = "stacks", size = 0.25 },
				{ id = "breakpoints", size = 0.25 },
			},
			size = 0.25,
			position = "left",
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
