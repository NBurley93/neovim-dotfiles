return {
  -- snacks.nvim: A plugin for handling large files and quick file operations
  {
    'folke/snacks.nvim',
    priority = 1000,
    lazy = false,
    opts = {
      bigfile = {
        enabled = true,
        size = 1.5 * 1024 * 1024, -- 1.5MB
      },
      quickfile = { enabled = true },
      win = { enabled = true },
    },
  },

  -- which-key.nvim: A plugin that displays available keybindings in a popup
  {
    'folke/which-key.nvim',
    event = 'VeryLazy',
    opts = {},
  },

  -- Mini.nvim: A collection of minimal and fast Neovim plugins
  {
    'nvim-mini/mini.ai',
    opts = true,
    version = false,
  },
  {
    'nvim-mini/mini.surround',
    opts = true,
    version = false,
  },
  {
    'nvim-mini/mini.operators',
    opts = true,
    version = false,
  },
  {
    'nvim-mini/mini.pairs',
    opts = true,
    version = false,
  },
}
