local M = {}

local lsp_map = function(keys, func, bufnr, desc)
  vim.keymap.set('n', keys, func, { buffer = bufnr, desc = 'LSP: ' .. desc })
end

function M.config(client, bufnr)
  lsp_map('gd', function()
    vim.cmd('Glance definitions')
  end, bufnr, 'View definitions')
  lsp_map('gr', function()
    vim.cmd('Glance references')
  end, bufnr, 'View references')

  lsp_map('<leader>ds', require('telescope.builtin').lsp_document_symbols, bufnr, 'View [D]ocument [S]ymbols')

  lsp_map('K', function()
    require('pretty_hover').hover()
  end, bufnr, 'Hover LSP Docs')

  lsp_map('<leader>rn', vim.lsp.buf.rename, bufnr, 'Rename symbol')
end

return M
