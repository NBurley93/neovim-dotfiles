---@type vim.lsp.Config
return {
  cmd = { 'typescript-language-server', '--stdio' },
  filetypes = { 'javascript', 'javascriptreact', 'typescript', 'typescriptreact' },
  root_markers = { 'tsconfig.json', 'jsconfig.json', 'package.json', '.git' },
  root_dir = function(bufnr, on_dir)
    local fname = vim.api.nvim_buf_get_name(bufnr)
    -- Skip Deno projects
    if vim.fs.root(fname, { 'deno.json', 'deno.jsonc' }) then
      return
    end
    local root = vim.fs.root(fname, {
      'package-lock.json',
      'yarn.lock',
      'pnpm-lock.yaml',
      'bun.lockb',
      'bun.lock',
    }) or vim.fs.root(fname, 'tsconfig.json') or vim.fs.root(fname, 'jsconfig.json') or vim.fs.root(fname, '.git')
    if root then
      on_dir(root)
    end
  end,
}
