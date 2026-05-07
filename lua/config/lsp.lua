-- LSP config
return {
  config = function()
    require('common.lsp_backend').setup('warn')
  end,
}
