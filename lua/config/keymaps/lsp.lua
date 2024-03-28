local M = {}

local lsp_map = function(keys, func, bufnr, desc)
	vim.keymap.set("n", keys, func, { buffer = bufnr, desc = "LSP: " .. desc })
end

function M.config(client, bufnr)
	local builtin = require("telescope.builtin")
	lsp_map("gd", builtin.lsp_definitions, bufnr, "[G]oto [D]efinition")
	lsp_map("gD", vim.lsp.buf.declaration, bufnr, "[G]oto [D]eclaration")
	lsp_map("gr", builtin.lsp_references, bufnr, "[G]oto [R]eferences")
	lsp_map("gI", builtin.lsp_implementations, bufnr, "[G]oto [I]mplementations")
	lsp_map("<leader>D", builtin.lsp_type_definitions, bufnr, "Type [D]efinition")
	lsp_map("<leader>cs", builtin.lsp_document_symbols, bufnr, "[C]ode [S]ymbols")

	lsp_map("K", function()
		vim.lsp.buf.hover()
	end, bufnr, "Hover Documentation")
	lsp_map("<leader>ca", vim.lsp.buf.code_action, bufnr, "[C]ode [A]ction")

	lsp_map("<leader>rn", vim.lsp.buf.rename, bufnr, "[R]e[n]ame")

	lsp_map("<c-t>", vim.lsp.buf.signature_help, bufnr, "Show signature help in context")

	lsp_map("<leader>fb", function()
		vim.lsp.buf.format({ async = true })
	end, bufnr, "[F]ormat [B]uffer")
end

return M
