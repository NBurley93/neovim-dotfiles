---@type vim.lsp.Config
return {
  filetypes = { 'css', 'scss', 'less' },
  cmd = { 'vscode-css-language-server', '--stdio' },
  root_dir = function(bufnr, on_dir)
    local fname = vim.api.nvim_buf_get_name(bufnr)
    on_dir(vim.fs.root(fname, { 'package.json', '.git' }) or vim.fn.fnamemodify(fname, ':h'))
  end,
}
