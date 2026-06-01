return {
  {
    'williamboman/mason.nvim',
    cmd = 'Mason',
    opts = {
      ui = {
        icons = {
          package_installed = '',
          package_pending = '󱑤',
          package_uninstalled = '',
        },
        border = 'solid',
      },
    },
    build = ':MasonUpdate',
  },
  {
    'WhoIsSethDaniel/mason-tool-installer.nvim',
    -- Defer to avoid blocking startup
    event = 'VeryLazy',
    opts = {
      start_delay = 3000,
      ensure_installed = {
        -- LSP servers (Mason registry names)
        'clangd',
        'lua-language-server',
        'ruff',
        'cmake-language-server',
        'json-lsp',
        'dockerfile-language-server',
        'terraform-ls',
        'css-lsp',
        'yaml-language-server',
        'lemminx',
        'rust-analyzer',
        'sql-language-server',
        'gh-actions-language-server',
        'bash-language-server',
        'gopls',
        'powershell-editor-services',
        'taplo',
        'eslint-lsp',
        'typescript-language-server',
        'vue-language-server',
        'html-lsp',
        'texlab',
        'docker-compose-language-service',
        -- gdscript is a local TCP server, not installed via Mason

        -- Linters
        'cmakelint',
        'commitlint',
        'cpplint',
        'golangci-lint',
        'hadolint',
        'tflint',
        'vale',
        'yamllint',
        'flake8',
        'stylelint',
        'gdtoolkit',

        -- DAP adapters
        'debugpy',
        'delve',
        'codelldb',
      },
    },
  },
}
