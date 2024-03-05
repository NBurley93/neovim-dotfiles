local icons = require("common.icons")

return {
	{
		"folke/trouble.nvim",
		dependencies = { require("common.defines").WEB_DEVICONS_PROVIDER },
		opts = {
			fold_open = "", -- icon used for open folds
			fold_closed = "", -- icon used for closed folds
			signs = {
				error = icons.diagnostics.Error,
				warning = icons.diagnostics.Warning,
				hint = icons.diagnostics.Hint,
				information = icons.diagnostics.Information,
				other = icons.diagnostics.Information,
			},
		},
	},
	{ "folke/lsp-colors.nvim" },
	{ "nvie/vim-flake8" },
}
