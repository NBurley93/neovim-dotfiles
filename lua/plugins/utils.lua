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
      input = {},
      picker = {},
      terminal = {},
    },
  },

  -- which-key.nvim: A plugin that displays available keybindings in a popup
  {
    'folke/which-key.nvim',
    event = 'VeryLazy',
    opts = {},
    config = function(_, opts)
      local wk = require('which-key')
      wk.setup(opts)
      wk.add({
        { '<leader>z', group = 'Copilot' },
        { '<leader>d', group = '[D]iffview' },
        { '<leader>g', group = '[G]it' },
        { '<leader>s', group = '[S]earch' },
        { '<leader>sg', group = '[G]it' },
        { '<leader>u', group = '[U]nit testing' },
        { '<leader>w', group = '[W]ord' },
        { '<leader>p', group = '[P]roject' },
      })
    end,
  },

  -- Mini.nvim: A collection of minimal and fast Neovim plugins
  {
    'nvim-mini/mini.ai',
    event = 'VeryLazy',
    opts = true,
    version = false,
  },
  {
    'nvim-mini/mini.surround',
    event = 'VeryLazy',
    opts = true,
    version = false,
  },
  {
    'nvim-mini/mini.operators',
    event = 'VeryLazy',
    opts = true,
    version = false,
  },
  {
    'nvim-mini/mini.pairs',
    event = 'VeryLazy',
    opts = true,
    version = false,
  },
  {
    'nvim-mini/mini.icons',
    event = 'VeryLazy',
    opts = true,
    version = false,
  },
}
