---@type vim.lsp.Config
return {
  cmd = { 'lua-language-server' },
  root_markers = { '.luarc.json', '.luarc.jsonc', '.git' },
  filetypes = { 'lua' },
  on_init = function(client)
    -- Only apply settings if no .luarc.json exists in the workspace
    if client.workspace_folders then
      local path = client.workspace_folders[1].name
      if vim.loop.fs_stat(path .. '/.luarc.json') or vim.loop.fs_stat(path .. '/.luarc.jsonc') then
        return true
      end
    end
    client.config.settings = vim.tbl_deep_extend('force', client.config.settings or {}, {
      Lua = {
        runtime = { version = 'LuaJIT' },
        workspace = {
          checkThirdParty = false,
          library = vim.api.nvim_get_runtime_file('', true),
        },
      },
    })
    client:notify('workspace/didChangeConfiguration', { settings = client.config.settings })
    return true
  end,
}
