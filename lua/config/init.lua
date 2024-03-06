local config_entries = {
	options = require("config.options"),
	completion = require("config.completion"),
	lsp = require("config.lsp"),
	autocommands = require("config.autocommands"),
	dap = require("config.dap"),
	null_ls = require("config.null_ls"),
	keymappings = require("config.keymaps"),
	theming = require("config.theming"),
}

return {
	config_all = function()
		config_entries.options.config()
		require("lazy").setup("plugins")
		config_entries.completion.config()
		config_entries.lsp.config()
		config_entries.autocommands.config()
		config_entries.dap.config()
		config_entries.null_ls.config()
		config_entries.keymappings.config()
		config_entries.theming.config()
	end,
}
