---@type vim.lsp.Config
return {
  cmd = { 'sql-language-server', 'up', '--method', 'stdio' },
  filetypes = { 'sql', 'mysql' },
  root_dir = function(bufnr, on_dir)
    local fname = vim.api.nvim_buf_get_name(bufnr)
    on_dir(vim.fs.root(fname, { '.sqllsrc.json', '.git' }) or vim.fn.fnamemodify(fname, ':h'))
  end,
}
