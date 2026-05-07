return {
  {
    'folke/lazydev.nvim',
    dependencies = {
      'DrKJeff16/wezterm-types',
    },
    ft = { 'lua' },
    opts = {
      library = {
        { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
        'LazyVim',
        {
          path = 'wezterm-types',
          mods = { 'wezterm' },
        },
      },
    },
  },
  {
    'DNLHC/glance.nvim',
    cmd = 'Glance',
    opts = {
      preview_win_opts = {
        cursorline = true,
        number = true,
        wrap = true,
      },
      border = {
        enable = true,
      },
    },
  },
  {
    'Fildo7525/pretty_hover',
    event = 'LspAttach',
    opts = {},
  },
  { 'p00f/clangd_extensions.nvim', ft = { 'c', 'cpp', 'rust' }, event = { 'BufReadPost', 'BufNewFile' } },
  {
    'dpowling/godot-lsp.nvim',
    ft = 'gdscript',
    config = function()
      require('godot-lsp').setup({
        port = 6005,
        fallback_port = 6006,
        auto_start = true,
        debug = false,
        silent = true,
      })
    end,
  },
}
