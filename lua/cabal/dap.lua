return {
	config = function()
		local dap = require('dap')
		local dapui = require('dapui')
		local mason = require('mason-nvim-dap')

		mason.setup({
			automatic_setup = true,

			handlers = {
				function(config)
					mason.default_setup(config)
				end,
				python = function(config)
					config.adapters = {
						type = 'executable',
						command = 'python',
						args = {
							'-m',
							'-debugpy.adapter',
						},
					}
					mason.default_setup(config)
				end,
			},

			ensure_installed = {
				'cpplint',
				'clang_format',
				'pylint',
				'flake8',
				'autopep8',
				'isort',
				'terraform_validate',
				'terraform_fmt',
				'stylua',
				'cmake_lint',
				'cmake_format',
				'prettier',
				'yamllint',
				'markdownlint',
				'hadolint',
				'debugpy',
				'cpptools',
			},
		})

		-- Dap UI setup
		-- For more information, see |:help nvim-dap-ui|
		dapui.setup({
			-- Set icons to characters that are more likely to work in every terminal.
			--    Feel free to remove or use ones that you like more! :)
			--    Don't feel like these are good choices.
			icons = { expanded = '▾', collapsed = '▸', current_frame = '*' },
			controls = {
				icons = {
					pause = '⏸',
					play = '▶',
					step_into = '⏎',
					step_over = '⏭',
					step_out = '⏮',
					step_back = 'b',
					run_last = '▶▶',
					terminate = '⏹',
				},
			},
		})

		dap.listeners.after.event_initialized['dapui_config'] = dapui.open
		dap.listeners.before.event_terminated['dapui_config'] = dapui.close
		dap.listeners.before.event_exited['dapui_config'] = dapui.close

		dap.configurations.python = {
			{
			type = 'python',
			request = 'launch',
			name = 'Test with pytest',
			program = 'python',
			args = { '-m', 'pytest', 'tests/' },
			pythonPath = '.',
			},
		}

		dap.adapters.python = {
			type = 'executable',
			command = vim.fn.stdpath('data')..'/mason/packages/debugpy/venv/bin/python3',
			args = { '-m', 'debugpy.adapter' },
		}
	end,
}
