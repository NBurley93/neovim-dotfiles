return {
	config = function()
		local null_ls = require('null-ls')

		local diagnostics = null_ls.builtins.diagnostics
		local formatting = null_ls.builtins.formatting

		null_ls.setup({
			sources = {
				-- Cpp
				diagnostics.cppcheck,
				formatting.clang_format,

				-- Python
				diagnostics.flake8,
				formatting.autopep8,
				formatting.isort,

				-- Terraform
				diagnostics.terraform_validate,
				formatting.terraform_fmt,

				-- Lua
				formatting.stylua,
				diagnostics.luacheck,

				-- CMake
				diagnostics.cmake_lint,
				formatting.cmake_format,

				-- Yaml
				formatting.prettier,
				diagnostics.yamllint,

				-- Markdown
				diagnostics.markdownlint,

				-- Docker
				diagnostics.hadolint,
			},
		})
	end,
}
