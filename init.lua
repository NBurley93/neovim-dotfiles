-- Bootstrap in Lazy.nvim
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

local C = require('init')

C.configure_neovim_options()
C.configure_lazy()
C.configure_lsps('warn')
C.configure_autocmds()
C.configure_keymaps()

vim.cmd.colorscheme('girlfailure')
