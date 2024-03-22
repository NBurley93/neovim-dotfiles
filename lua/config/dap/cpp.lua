local M = {}

local dap = require("dap")

local cpp_ftypes = {
	"cpp",
	"c",
	"rust",
}

function M.setup()
	dap.adapters.cppdbg = {
		id = "cppdbg",
		type = "executable",
		command = vim.fn.stdpath("data") .. "/mason/packages/cpptools/extension/debugAdapters/bin/OpenDebugAD7",
		options = {
			detached = false,
		},
	}

	for _, lang in ipairs(cpp_ftypes) do
		dap.configurations[lang] = {
			{
				name = "Default: Launch executable",
				type = "cppdbg",
				request = "launch",
				program = function()
					local co = coroutine.running()
					return coroutine.create(function()
						vim.ui.input({
							prompt = "Enter executable: ",
							default = "",
						}, function(fpath)
							if fpath == nil or fpath == "" then
								return
							else
								coroutine.resume(co, fpath)
							end
						end)
					end)
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
	end
end

return M
