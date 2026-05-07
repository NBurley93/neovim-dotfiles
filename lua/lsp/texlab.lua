---@type vim.lsp.Config
return {
  cmd = { 'texlab' },
  filetypes = { 'tex', 'plaintex', 'bib' },
  root_dir = function(bufnr, on_dir)
    local fname = vim.api.nvim_buf_get_name(bufnr)
    on_dir(
      vim.fs.root(fname, { '.git', '.latexmkrc', 'latexmkrc', '.texlabroot', 'texlabroot', 'Tectonic.toml' })
        or vim.fn.fnamemodify(fname, ':h')
    )
  end,
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
}
