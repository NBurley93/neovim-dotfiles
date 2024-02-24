return {
	config = function()
		local null_ls = require("null-ls")

		local diagnostics = null_ls.builtins.diagnostics
		local formatting = null_ls.builtins.formatting

		null_ls.setup({
			sources = {
				-- Python
				-- diagnostics.flake8,
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
				formatting.prettier,
				diagnostics.yamllint,

				-- Markdown
				diagnostics.markdownlint,

				-- Docker
				diagnostics.hadolint,

				-- Shell
				formatting.shfmt,
			},
		})
	end,
}
