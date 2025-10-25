-- LSP config
local lsp_config_backend = require 'common.lsp_backend'

return {
  config = function()
    -- Setup lsp server configurations
    lsp_config_backend.setup({
      {
        name = 'clangd',
        config = {
          cmd = {
            'clangd',
            '--clang-tidy',
            '--completion-style=bundled',
            '--fallback-style=file',
          },
        },
      },

      {
        name = 'lua_ls',
        config = {
          on_init = function(client)
            local path = client.workspace_folders[1].name
            if not vim.loop.fs_stat(path .. '/.luarc.json') and not vim.loop.fs_stat(path .. '/.luarc.jsonc') then
              client.config.settings = vim.tbl_deep_extend('force', client.config.settings, {
                Lua = {
                  runtime = {
                    version = 'LuaJIT',
                  },
                  workspace = {
                    checkThirdParty = false,
                    library = {
                      vim.env.VIMRUNTIME,
                    },
                  },
                },
              })
              client.notify('workspace/didChangeConfiguration', { settings = client.config.settings })
            end
            return true
          end,
        },
      },
      { name = 'ruff' },
      { name = 'cmake' },
      { name = 'jsonls' },
      { name = 'dockerls' },
      { name = 'terraformls' },
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
      { name = 'rust_analyzer' },
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
    }, 'warn')
  end,
}
