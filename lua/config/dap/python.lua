local M = {}

local dap, dappy = require("dap"), require("dap-python")

function M.setup()
	dappy.setup(vim.g.python3_host_prog)
	local commonPytestConfig = {
		type = "python",
		request = "launch",
		name = "Pytest all (coverage)",
		module = "pytest",
		args = { "tests", "--no-cov" },
		cwd = "${workspaceFolder}",
		console = "integratedTerminal",
		logToFile = false,
	}

	local nocovPytestConfig = {
		type = commonPytestConfig.type,
		request = commonPytestConfig.request,
		name = "Pytest all (no coverage)",
		module = commonPytestConfig.module,
		args = { "tests" },
		cwd = commonPytestConfig.cwd,
		console = commonPytestConfig.console,
		logToFile = commonPytestConfig.logToFile,
	}
	table.insert(dap.configurations.python, commonPytestConfig)
	table.insert(dap.configurations.python, nocovPytestConfig)
end

return M
