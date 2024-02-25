local data_path = vim.fn.stdpath("data")
local nvim_input = vim.fn.input

local function setup_dap_cpp(dap)
	dap.adapters.cppdbg = {
		id = "cppdbg",
		type = "executable",
		command = data_path .. "/mason/packages/cpptools/extension/debugAdapters/bin/OpenDebugAD7",
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
				return nvim_input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
			end,
			cwd = "${workspaceFolder}",
			stopAtEntry = false,
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
	dap.configurations.rust = dap.configurations.cpp -- Rust is a C-based language, so we can just copy the cfg
end

local function setup_dap_python(dap, dap_python)
	dap_python.setup(vim.g.python3_host_prog)
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
end

local function setup_signs()
	local nvim_sign_define = vim.fn.sign_define
	local icons = require("common.icons")
	nvim_sign_define("DapBreakpoint", { text = icons.ui.Circle, texthl = "DiagnosticError", linehl = "", numhl = "" })
	nvim_sign_define(
		"DapStopped",
		{ text = icons.ui.ChevronRight, texthl = "Error", linehl = "DapStoppedLinehl", numhl = "" }
	)
	nvim_sign_define(
		"DapBreakpointCondition",
		{ text = icons.ui.CircleWithGap, texthl = "DiagnosticWarn", linehl = "", numhl = "" }
	)
end

return {
	config = function()
		local dap, dapui = require("dap"), require("dapui")

		setup_dap_python(dap, require("dap-python"))
		setup_dap_cpp(dap)
		setup_signs()

		dap.listeners.after.event_initialized["dapui_config"] = dapui.open
	end,
}
