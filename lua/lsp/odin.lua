---@type vim.lsp.Config
return {
  filetypes = { 'odin' },
  root_markers = { 'ols.json' },
  cmd = { 'ols' },
  --@type vim.lsp.Config.Opts
  init_options = {
    checker_args = 'strict-style',
  },
}
