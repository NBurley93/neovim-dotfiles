---@type vim.lsp.Config
return {
  cmd = { 'ruff', 'server' },
  filetypes = { 'python' },
  root_dir = function(bufnr, on_dir)
    local fname = vim.api.nvim_buf_get_name(bufnr)
    on_dir(
      vim.fs.root(fname, { 'pyproject.toml', 'ruff.toml', '.ruff.toml', '.git' }) or vim.fn.fnamemodify(fname, ':h')
    )
  end,
}
