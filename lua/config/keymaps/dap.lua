return {
	config = function()
		local map = function(keys, action, desc)
			vim.keymap.set("n", keys, action, { desc = desc })
		end

		local dap = require("dap")
		local dapui = require("dapui")
		map("<F5>", function()
			if vim.fn.filereadable(".vscode/launch.json") then
				local dap_vscode = require("dap.ext.vscode")
				dap_vscode.load_launchjs(nil, {
					["cppdbg"] = {
						"cpp",
						"c",
						"rust",
					},
				})
			end
			dap.continue()
		end, "Continue")
		map("<F1>", dap.step_into, "Step into")
		map("<F2>", dap.step_over, "Step over")
		map("<F3>", dap.step_out, "Step out")
		map("<leader>dbb", dap.toggle_breakpoint, "Set breakpoint")
		map("<leader>dbB", function()
			dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
		end, "Set conditional breakpoint")
		map("<leader>dbo", dapui.open, "Open")
		map("<leader>dbc", dapui.close, "Close")
		map("<leader>dbe", dapui.eval, "Evaluate")
	end,
}
