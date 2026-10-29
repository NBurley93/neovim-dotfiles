return {
  -- Mini.nvim: A collection of minimal and fast Neovim plugins

  -- Better Around/Inside textobjects
  --
  -- Examples:
  -- - va) - [V]isually select [A]round [)]parens
  -- - yinq - [Y]ank [I]nside [N]ext [']quote
  -- - ci' - [C]hange [I]nside [']quote
  --
  -- Treesitter textobjects (queries from nvim-treesitter-textobjects):
  -- - vaf / vif - [A]round / [I]nside [F]unction definition
  -- - vac / vic - [A]round / [I]nside [C]lass
  -- - vau / viu - function call [U]sage (mini.ai's default `f`, moved to make room)
  {
    'nvim-mini/mini.ai',
    dependencies = { 'nvim-treesitter/nvim-treesitter-textobjects' },
    opts = function()
      local ai = require('mini.ai')
      return {
        n_lines = 500,
        custom_textobjects = {
          f = ai.gen_spec.treesitter({ a = '@function.outer', i = '@function.inner' }),
          c = ai.gen_spec.treesitter({ a = '@class.outer', i = '@class.inner' }),
          u = ai.gen_spec.function_call(),
        },
      }
    end,
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
  -- Text operators: g= evaluate, gx exchange (built-in gx moves to gX), gm multiply, gs sort,
  -- cr replace with register. Replace is moved off its default `gr`, because that prefix makes
  -- mini.operators delete Neovim's built-in gra/grn/gri/grt LSP mappings.
  {
    'nvim-mini/mini.operators',
    event = 'VeryLazy',
    opts = {
      replace = { prefix = 'cr' },
    },
    version = false,
  },
  {
    'nvim-mini/mini.pairs',
    event = 'VeryLazy',
    opts = true,
    version = false,
  },
  -- Icon provider for everything, including plugins that ask for nvim-web-devicons:
  -- requiring 'nvim-web-devicons' loads mini.icons and its devicons-compatible mock instead
  {
    'nvim-mini/mini.icons',
    lazy = true,
    opts = true,
    init = function()
      package.preload['nvim-web-devicons'] = function()
        require('mini.icons').mock_nvim_web_devicons()
        return package.loaded['nvim-web-devicons']
      end
    end,
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
