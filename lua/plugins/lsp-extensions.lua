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
        'lazy.nvim',
        'nvim-dap',
        'nvim-dap-ui',
        'overseer.nvim',
        {
          path = 'wezterm-types',
          mods = { 'wezterm' },
        },
      },
    },
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
