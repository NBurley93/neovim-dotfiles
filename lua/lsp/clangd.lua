---@type vim.lsp.Config
return {
  filetypes = { 'c', 'cpp', 'objc', 'objcpp', 'cuda' },
  root_markers = { '.clangd', 'compile_commands.json', 'compile_flags.txt', '.git' },
  cmd = {
    'clangd',
    '--background-index',
    '--clang-tidy',
    '--header-insertion=never',
    '--completion-style=detailed',
    '--fallback-style=google',
  },
  init_options = {
    usePlaceholders = true,
    completeUnimported = true,
    clangdFileStatus = true,
  },
  on_attach = function(client, bufnr)
    local lspbackend = require('common.lsp_backend')
    lspbackend.lsp_onattach_baseline(client, bufnr)

    lspbackend.lsp_map('<leader>ch', function()
      vim.cmd('LspClangdSwitchSourceHeader')
    end, bufnr, 'Switch between source/header (C/C++)')

    local lspkeyfuncs = require('common.lsp_keybind_funcs')

    -- Ctrl+Shift+B to spawn split terminal and generate + build debug
    lspbackend.lsp_map('<C-B>', lspkeyfuncs.cmake_generate_and_build, bufnr, 'CMake Generate + Build (Debug)')
  end,
}
