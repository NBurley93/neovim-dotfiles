return {
	{
		"nvim-neotest/neotest",
		config = function()
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
						args = { "--log-level", "DEBUG", "-vv", "--no-cov" },
					}),
				},
				output_panel = {
					enabled = false,
				},
				summary = {
					mappings = {},
				},
			})
		end,
		dependencies = {
			"nvim-neotest/nvim-nio",
			"nvim-lua/plenary.nvim",
			"nvim-treesitter/nvim-treesitter",
			"antoinemadec/FixCursorHold.nvim",
			"nvim-neotest/neotest-python",
		},
	},
	{
		"theHamsta/nvim-dap-virtual-text",
		dependencies = {
			"mfussenegger/nvim-dap",
			"nvim-treesitter/nvim-treesitter",
		},
	},
	{
		"rcarriga/nvim-dap-ui",
		dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
		config = function()
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
		end,
	},
}
