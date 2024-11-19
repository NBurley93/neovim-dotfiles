local unwrap_groups = function(groups)
	local sources = {}

	for _, group in ipairs(groups) do
		for _, module in ipairs(group) do
			table.insert(sources, module)
		end
	end

	return sources
end

return {
	config = function()
		local null_ls = require("null-ls")

		local diagnostics = null_ls.builtins.diagnostics
		local formatting = null_ls.builtins.formatting


		local augroup = vim.api.nvim_create_augroup("LspAutoformatting", {})

		null_ls.setup({
			on_attach = function(client, bufnr)
				if client.supports_method("textDocument/formatting") then
					vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
					vim.api.nvim_create_autocmd("BufWritePre", {
						group = augroup,
						buffer = bufnr,
						callback = function()
							vim.lsp.buf.format()
						end,
					})
				end
			end,

			sources = unwrap_groups({
				terraform = {
					diagnostics.terraform_validate,
					formatting.terraform_fmt,
				},
				lua = {
					formatting.stylua,
				},
				cmake = {
					diagnostics.cmake_lint,
					formatting.gersemi,
				},
				go = {
					diagnostics.golangci_lint,
					formatting.gofmt,
				},
				yaml = {
					formatting.yamlfmt,
					diagnostics.yamllint,
				},
				markdown = {
					diagnostics.markdownlint,
				},
				docker = {
					diagnostics.hadolint,
				},
				shell = {
					formatting.shfmt,
				},
				xml = {
					formatting.tidy,
				},
				sql = {
					diagnostics.sqlfluff.with({
						extra_args = { "--dialect", "sqlite" },
					}),
					formatting.sqlfmt,
				},
				csharp = {
					formatting.csharpier,
				},
			}),
		})
	end,
}
