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

			sources = {
				-- Python
				-- diagnostics.flake8,
				-- formatting.ruff,
				-- formatting.autopep8,

				-- Terraform
				diagnostics.terraform_validate,
				formatting.terraform_fmt,

				-- Lua
				formatting.stylua,

				-- CMake
				diagnostics.cmake_lint,
				formatting.gersemi,

				-- Go
				diagnostics.golangci_lint,
				formatting.gofmt,

				-- Rust
				-- formatting.rustfmt,

				-- Yaml
				formatting.yamlfmt,
				diagnostics.yamllint,

				-- Markdown
				diagnostics.markdownlint,

				-- Docker
				diagnostics.hadolint,

				-- Shell
				formatting.shfmt,

				-- XML
				formatting.tidy,

				-- CSharp
				formatting.csharpier,
			},
		})
	end,
}
