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

-- hack to deal with bug in telescope-cheat.nvim
-- https://github.com/nvim-telescope/telescope-cheat.nvim/issues/7
local cheat_dbdir = vim.fn.stdpath("data") .. "/databases"
if not vim.loop.fs_stat(cheat_dbdir) then
	vim.loop.fs_mkdir(cheat_dbdir, 493)
end

-- Bootstrap in external depencencies (tidy)
if vim.fn.executable("tidy") == 0 then
	-- Install tidy if on linux, otherwise, warn the user
	if vim.fn.has("win32") == 0 then
		os.execute("sudo apt-get install tidy -y")
	end
end

-- Load configurations
require("config").config_all()
