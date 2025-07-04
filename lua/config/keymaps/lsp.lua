local M = {}

local lsp_map = function(keys, func, bufnr, desc)
	vim.keymap.set("n", keys, func, { buffer = bufnr, desc = "LSP: " .. desc })
end

function M.config(client, bufnr)
	local builtin = require("telescope.builtin")
	lsp_map("gd", builtin.lsp_definitions, bufnr, "Goto definitions")
	lsp_map("gD", vim.lsp.buf.declaration, bufnr, "Goto declaration")
	lsp_map("gr", builtin.lsp_references, bufnr, "Goto references")
	lsp_map("gI", builtin.lsp_implementations, bufnr, "Goto implementations")

	lsp_map("K", function()
		vim.lsp.buf.hover()
	end, bufnr, "Hover LSP Docs")

	lsp_map("<leader>rn", vim.lsp.buf.rename, bufnr, "Rename symbol")

	lsp_map("<leader>fb", function()
		vim.lsp.buf.format({ async = true })
	end, bufnr, "Format current buffer")
end

return M
