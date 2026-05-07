---@type vim.lsp.Config
return {
  cmd = { 'gh-actions-language-server', '--stdio' },
  filetypes = { 'yaml', 'yaml.github' },
  root_markers = { '.github' },
  root_dir = function(bufnr, on_dir)
    local fname = vim.api.nvim_buf_get_name(bufnr)
    if fname:match('[/\\]%.github[/\\]workflows[/\\]') then
      on_dir(vim.fs.root(fname, '.git') or vim.fn.getcwd())
    end
  end,
}
