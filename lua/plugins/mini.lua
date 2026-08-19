return {
  -- Mini.nvim: A collection of minimal and fast Neovim plugins

  -- Better Around/Inside textobjects
  --
  -- Examples:
  -- - va) - [V]isually select [A]round [)]parens
  -- - yinq - [Y]ank [I]nside [N]ext [']quote
  -- - ci' - [C]hange [I]nside [']quote
  {
    'nvim-mini/mini.ai',
    opts = {
      n_lines = 500,
    },
    version = false,
  },
  -- Add/delete/replace surroundings
  --
  --  - saiw) - [S]urround [A]dd [I]nner [W]ord [)]paren
  --  - sd' - [S]urround [D]elete [']quotes
  --  - sr)' - [S]urround [R]eplace [)] [']
  {
    'nvim-mini/mini.surround',
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
  {
    'nvim-mini/mini.comment',
    event = 'VeryLazy',
    opts = true,
    version = false,
  },
  {
    'nvim-mini/mini.splitjoin',
    event = 'VeryLazy',
    opts = true,
    version = false,
  },
  {
    'nvim-mini/mini.indentscope',
    event = 'VeryLazy',
    opts = {
      symbol = '┆',
    },
    version = false,
  },
}
