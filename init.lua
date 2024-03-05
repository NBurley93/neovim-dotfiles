-- Bootstrap in Lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)
local cfg = require("config")

-- Load configurations
cfg.options.config()
require("lazy").setup("plugins")
cfg.completion.config()
cfg.lsp.config()
cfg.autocommands.config()
cfg.dap.config()
cfg.null_ls.config()
cfg.keymappings.config()
cfg.theming.config()
