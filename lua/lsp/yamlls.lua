---@type vim.lsp.Config
return {
  cmd = { 'yaml-language-server', '--stdio' },
  filetypes = { 'yaml', 'yaml.github', 'yaml.docker-compose' },
  root_dir = function(bufnr, on_dir)
    local fname = vim.api.nvim_buf_get_name(bufnr)
    on_dir(vim.fs.root(fname, { '.git' }) or vim.fn.fnamemodify(fname, ':h'))
  end,
  on_attach = function(client, bufnr)
    -- Force YAML to permit formatting (it disables it by default)
    client.server_capabilities.documentFormattingProvider = true
    require('common.lsp_backend').lsp_onattach_baseline(client, bufnr)
  end,
}
