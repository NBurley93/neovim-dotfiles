return {
	config = function()
		local dap, dapui, dappython = require("dap"), require("dapui"), require("dap-python")
		dappython.setup(vim.g.python3_host_prog)
		local commonPytestConfig = {
			type = "python",
			request = "launch",
			name = "Pytest all (coverage installed)",
			module = "pytest",
			args = { "tests", "--no-cov" },
			cwd = "${workspaceFolder}",
			console = "integratedTerminal",
			logToFile = false,
		}
		local nocovPytestConfig = {
			type = commonPytestConfig.type,
			request = commonPytestConfig.request,
			name = "Pytest all (coverage not installed)",
			module = commonPytestConfig.module,
			args = { "tests" },
			cwd = commonPytestConfig.cwd,
			console = commonPytestConfig.console,
			logToFile = commonPytestConfig.logToFile,
		}
		table.insert(dap.configurations.python, commonPytestConfig)
		table.insert(dap.configurations.python, nocovPytestConfig)

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

		vim.fn.sign_define("DapBreakpoint", { text = "", texthl = "DiagnosticError", linehl = "", numhl = "" })
		vim.fn.sign_define(
			"DapBreakpointCondition",
			{ text = "", texthl = "DiagnosticWarn", linehl = "", numhl = "" }
		)
		dap.listeners.after.event_initialized["dapui_config"] = dapui.open
	end,
}
