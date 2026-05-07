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

  lsp_map('<leader>ds', function()
    require('telescope.builtin').lsp_document_symbols()
  end, bufnr, 'View [D]ocument [S]ymbols')

  lsp_map('K', function()
    require('pretty_hover').hover()
  end, bufnr, 'Hover LSP Docs')

  lsp_map('<leader>rn', vim.lsp.buf.rename, bufnr, 'Rename symbol')

  if client.name == 'clangd' then
    lsp_map('<leader>ch', function()
      vim.cmd('LspClangdSwitchSourceHeader')
    end, bufnr, 'Switch between source/header (C/C++)')
  end
end

return M
