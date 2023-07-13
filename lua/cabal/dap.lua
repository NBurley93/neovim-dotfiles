return {
	config = function()
		local dap, dapui, dappython = require('dap'), require('dapui'), require('dap-python')
		dappython.setup('~/.nvimenv/.venv/bin/python')
		table.insert(dap.configurations.python, {
			type = 'python',
			request = 'launch',
			name = 'Pytest all',
			module = 'pytest',
			args = { 'tests', '--no-cov' },
			cwd = '${workspaceFolder}',
		})

		dap.adapters.cppdbg = {
			id = "cppdbg",
			type = "executable",
			command = vim.fn.stdpath("data") .. "/mason/packages/cpptools/extension/debugAdapters/bin/OpenDebugAD7",
			options = {
				detached = false,
			},
		}
		dap.configurations.cpp = {
			{
				name = "Launch file",
				type = "cppdbg",
				request = "launch",
				program = function()
					return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
				end,
				cwd = "${workspaceFolder}",
				stopAtEntry = true,
				setupCommands = {
					{
						text = "-enable-pretty-printing",
						description = "enable pretty printing",
						ignoreFailures = false,
					},
				},
			},
		}
		dap.configurations.c = dap.configurations.cpp

		-- dap.adapters.python = {
		-- 	type = 'executable',
		-- 	-- command = vim.fn.stdpath('data')..'/mason/packages/debugpy/venv/bin/python',
		-- 	command = vim.g.python3_host_prog,
		-- 	args = { '-m', 'debugpy.adapter' },
		-- }
		-- dap.configurations.python = {
		-- 	{
		-- 		type = "python",
		-- 		request = "launch",
		-- 		name = "Debug with pytest",
		-- 		module = "pytest",
		-- 		args = { "tests" },
		-- 		cwd = "${workspaceFolder}",
		-- 	},
		-- }

		vim.fn.sign_define("DapBreakpoint", { text = "", texthl = "DiagnosticError", linehl = "", numhl = "" })
		vim.fn.sign_define(
			"DapBreakpointCondition",
			{ text = "", texthl = "DiagnosticWarn", linehl = "", numhl = "" }
		)

		dap.listeners.after.event_initialized["dapui_config"] = dapui.open
		dap.listeners.before.event_terminated["dapui_config"] = dapui.close
		dap.listeners.before.event_exited["dapui_config"] = dapui.close
	end,
}
