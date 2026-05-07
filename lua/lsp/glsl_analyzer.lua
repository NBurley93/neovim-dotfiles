---@type vim.lsp.Config
return {
  cmd = { 'glsl_analyzer' },
  root_markers = { '.git' },
  filetypes = { 'glsl', 'vert', 'frag', 'geom', 'tesc', 'tese', 'comp' },
}
