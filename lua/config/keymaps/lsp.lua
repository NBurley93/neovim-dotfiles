local M = {}

local lsp_map = function(keys, func, bufnr, desc)
  vim.keymap.set('n', keys, func, { buffer = bufnr, desc = 'LSP: ' .. desc })
end

function M.config(client, bufnr)
  lsp_map('gd', function()
    vim.cmd 'Glance definitions'
  end, bufnr, 'View definitions')
  lsp_map('gr', function()
    vim.cmd 'Glance references'
  end, bufnr, 'View references')
  lsp_map('gy', function()
    vim.cmd 'Glance type_definitions'
  end, bufnr, 'View type definitions')
  lsp_map('gm', function()
    vim.cmd 'Glance implementations'
  end, bufnr, 'View implementations')

  lsp_map('K', function()
    require('pretty_hover').hover()
  end, bufnr, 'Hover LSP Docs')

  lsp_map('<leader>rn', vim.lsp.buf.rename, bufnr, 'Rename symbol')
end

return M
