local icons = require("common.icons")
local options = {
	fold_open = "", -- icon used for open folds
	fold_closed = "", -- icon used for closed folds
	signs = {
		error = icons.diagnostics.Error,
		warning = icons.diagnostics.Warning,
		hint = icons.diagnostics.Hint,
		information = icons.diagnostics.Information,
		other = icons.diagnostics.Information,
	},
}
return options
