local cfg = require("config")
local plugins = require("plugins")

cfg.options.config()
plugins.config()
cfg.completion.config()
cfg.lsp.config()
cfg.autocommands.config()
cfg.dap.config()
cfg.null_ls.config()
cfg.keymappings.config()
cfg.theming.config()
