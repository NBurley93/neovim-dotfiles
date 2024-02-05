return {
	config = function()
		local null_ls = require("null-ls")

		local diagnostics = null_ls.builtins.diagnostics
		local formatting = null_ls.builtins.formatting

		null_ls.setup({
			sources = {
				-- Cpp
				diagnostics.clang_check,
				diagnostics.cpplint,
				formatting.clang_format,

				-- Python
				diagnostics.pylint.with({
					diagnostics_postprocess = function(diagnostic)
						diagnostic.code = diagnostic.message_id
					end,
				}),
				diagnostics.flake8,
				formatting.autopep8,
				formatting.isort,

				-- Terraform
				diagnostics.terraform_validate,
				formatting.terraform_fmt,

				-- Lua
				formatting.stylua,

				-- CMake
				diagnostics.cmake_lint,
				formatting.gersemi,

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
