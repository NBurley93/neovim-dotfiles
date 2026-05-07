---@type vim.lsp.Config
return {
  cmd = { 'cmake-language-server' },
  root_markers = { 'CMakePresets.json', 'CMakeLists.txt', '.git' },
  filetypes = { 'cmake' },
}
