return {
  {
    'stevearc/conform.nvim',
    event = { 'BufWritePre' },
    cmd = { 'ConformInfo' },
    opts = {
      formatters_by_ft = {
        lua = { 'stylua' },
        yaml = { 'yamlfmt' },
        terraform = { 'terraform_fmt' },
        cmake = { 'cmake_format' },
        json = { 'jq' },
        markdown = { 'prettier' },
        css = { 'prettier' },
        html = { 'prettier' },
      },
      default_format_ops = {
        lsp_format = 'fallback',
      },
      format_on_save = {
        lsp_format = 'fallback',
        timeout_ms = 500,
      },
      format_after_save = {
        lsp_fallback = 'fallback',
      },
      notify_no_formatters = false,
    },
  },
}
