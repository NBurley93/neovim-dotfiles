return {
  {
    'folke/lazydev.nvim',
    event = {
      'BufReadPost *.lua',
      'BufNewFile *.lua',
    },
    ft = { 'lua' },
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
  {
    'neovim/nvim-lspconfig',
    event = { 'BufReadPost', 'BufNewFile' },
    dependencies = {
      'mason-org/mason-lspconfig.nvim',
    },
    config = function()
      require('mason-lspconfig').setup({
        ensure_installed = {
          'clangd',
          'lua_ls',
          'ruff',
          'cmake',
          'jsonls',
          'dockerls',
          'terraformls',
          'yamlls',
          'lemminx',
          'rust_analyzer',
          'glsl_analyzer',
          'sqlls',
          'gh_actions_ls',
          'bashls',
          'powershell_es',
          'taplo',
          'docker_compose_language_service',
          'texlab',
        },
      })
    end,
  },
  { 'p00f/clangd_extensions.nvim', ft = { 'c', 'cpp', 'rust' }, event = { 'BufReadPost', 'BufNewFile' } },
}
