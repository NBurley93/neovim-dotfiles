return {
	config = function()
		local null_ls = require("null-ls")

		null_ls.setup({
			sources = {
				null_ls.builtins.diagnostics.cpplint,
				null_ls.builtins.diagnostics.flake8,
				null_ls.builtins.diagnostics.pylint,
				null_ls.builtins.diagnostics.terraform_validate,
				null_ls.builtins.diagnostics.markdownlint,
				null_ls.builtins.diagnostics.cmake_lint,
				null_ls.builtins.formatting.autopep8,
				null_ls.builtins.formatting.clang_format,
				null_ls.builtins.formatting.terraform_fmt,
				null_ls.builtins.formatting.stylua,
				null_ls.builtins.formatting.isort,
				null_ls.builtins.formatting.cmake_format,
			},
		})
	end,
}
