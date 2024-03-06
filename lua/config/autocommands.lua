local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

return {
	config = function()
		-- Highlight on yank
		autocmd("TextYankPost", {
			desc = "Highlight when yanking text",
			group = augroup("highlight-yank", { clear = true }),
			callback = function()
				vim.highlight.on_yank({ higroup = "DiffAdd", timeout = 250 })
			end,
		})
	end,
}
