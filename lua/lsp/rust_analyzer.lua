---@type vim.lsp.Config
return {
  cmd = { 'rust-analyzer' },
  root_markers = { 'Cargo.toml', 'Cargo.lock', '.git' },
  filetypes = { 'rust' },
  settings = {
    ['rust-analyzer'] = {
      cargo = {
        allFeatures = true,
      },
      check = {
        command = 'clippy',
        -- extraArgs = { '--no-deps' },
      },
    },
  },
}
