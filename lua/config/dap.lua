local M = {}

function M.config()
	local dap, dapui, icons = require("dap"), require("dapui"), require("common.icons")

	require("config.dap.cpp").setup()
	require("config.dap.python").setup()

	vim.fn.sign_define("DapBreakpoint", { text = icons.ui.Circle, texthl = "DiagnosticError", linehl = "", numhl = "" })
	vim.fn.sign_define(
		"DapStopped",
		{ text = icons.ui.ChevronRight, texthl = "Error", linehl = "DapStoppedLinehl", numhl = "" }
	)
	vim.fn.sign_define(
		"DapBreakpointCondition",
		{ text = icons.ui.CircleWithGap, texthl = "DiagnosticWarn", linehl = "", numhl = "" }
	)

	dap.listeners.before.attach.dapui_config = function()
		dapui.open()
	end
	dap.listeners.before.launch.dapui_config = function()
		dapui.open()
	end
end

return M
