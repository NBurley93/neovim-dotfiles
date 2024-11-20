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

-- Bootstrap in external depencencies (tidy)
if vim.fn.executable("tidy") == 0 then
	-- Install tidy if on linux, otherwise, warn the user
	if vim.fn.has("win32") == 0 then
		os.execute("sudo apt-get install tidy -y")
	end
end

-- Load configurations
require("config").config_all()
