-- LSP config
local lsp_config_backend = require('common.lsp_backend')

return {
  config = function()
    -- Setup lsp server configurations
    lsp_config_backend.setup({
      {
        name = 'clangd',
        ---@type vim.lsp.Config
        config = {
          filetypes = { 'c', 'cpp', 'objc', 'objcpp', 'cuda' },
          keys = {
            { '<leader>ch', '<cmd>Lsp_clangd_switch_source_header<cr>', desc = 'Switch between source/header (C/C++)' },
          },
          cmd = {
            'clangd',
            '--background-index',
            '--clang-tidy',
            '--header-insertion=never',
            '--completion-style=detailed',
            '--function-arg-placeholders',
            '--fallback-style=google',
          },
          init_options = {
            usePlaceholders = true,
            completeUnimported = true,
            clangdFileStatus = true,
          },
        },
      },
      {
        name = 'lua_ls',
        ---@type vim.lsp.Config
        config = {
          filetypes = { 'lua' },
          on_init = function(client)
            local path = client.workspace_folders[1].name
            if not vim.loop.fs_stat(path .. '/.luarc.json') and not vim.loop.fs_stat(path .. '/.luarc.jsonc') then
              ---@type lspconfig.settings.lua_ls
              local lua_conf = {
                Lua = {
                  runtime = {
                    version = 'LuaJIT',
                  },
                  workspace = {
                    checkThirdParty = false,
                    library = vim.api.nvim_get_runtime_file('', true),
                  },
                },
              }
              client.config.settings = vim.tbl_deep_extend('force', client.config.settings, lua_conf)
              client.notify('workspace/didChangeConfiguration', { settings = client.config.settings })
            end
            return true
          end,
        },
      },
      { name = 'ruff', config = { filetypes = { 'python' } } },
      { name = 'cmake', config = { filetypes = { 'cmake' } } },
      { name = 'jsonls', config = { filetypes = { 'json', 'jsonc' } } },
      { name = 'dockerls', config = { filetypes = { 'dockerfile' } } },
      { name = 'terraformls', config = { filetypes = { 'terraform' } } },
      { name = 'cssls', config = { filetypes = { 'css', 'scss', 'less' } } },
      {
        name = 'yamlls',
        config = {
          on_attach = lsp_config_backend.lsp_extend_baseline_onattach(function(client, bufnr)
            -- Force YAML to permit formatting
            client.server_capabilities.documentFormattingProvider = true
          end),
          filetypes = { 'yaml.github', 'yaml', 'yaml.docker-compose' },
        },
      },
      { name = 'lemminx' },
      { name = 'rust_analyzer', config = { filetypes = { 'rust' } } },
      { name = 'glsl_analyzer' },
      { name = 'sqlls' },
      {
        name = 'gh_actions_ls',
        config = {
          filetypes = { 'yaml.github', 'yaml' },
        },
      },
      { name = 'bashls' },
      { name = 'gopls' },
      { name = 'powershell_es' },
      { name = 'taplo' },
      { name = 'eslint' },
      { name = 'typescript-language-server' },
      { name = 'vue_ls' },
      {
        name = 'html',
        config = {
          filetypes = { 'html' },
          capabilities = {
            textDocument = {
              completion = {
                completionItem = {
                  snippetSupport = true,
                },
              },
            },
          },
        },
      },
      {
        name = 'texlab',
        config = {
          root_markers = { '.git', '.latexmkrc', 'latexmkrc', '.texlabroot', 'texlabroot', 'Tectonic.toml' },
          filetypes = { 'tex', 'plaintex', 'bib' },
          settings = {
            texlab = {
              build = {
                executable = 'tectonic',
                args = {
                  '-X',
                  'compile',
                  '%f',
                  '--synctex',
                  '--keep-logs',
                  '--keep-intermediates',
                },
              },
              latexFormatter = 'tex-fmt',
              bibtexFormatter = 'tex-fmt',
            },
          },
        },
      },
      {
        name = 'docker_compose_language_service',
        config = {
          config = {
            cmd = { 'docker-compose-langserver', '--stdio' },
            single_file_support = true,
          },
          filetypes = { 'yaml.docker-compose' },
        },
      },
      {
        name = 'gdscript',
      },
    }, 'warn')
  end,
}
