return {
  -- Conform.nvim: an opinionated code formatter
  {
    'stevearc/conform.nvim',
    event = { 'BufWritePre' },
    cmd = { 'ConformInfo' },
    keys = {
      {
        '<leader>f',
        function()
          require('conform').format({
            lsp_format = 'fallback',
            async = false,
            timeout_ms = 500,
          })
        end,
        mode = { 'n', 'v' },
        desc = '[F]ormat current buffer or visual range',
      },
    },
    opts = {
      formatters = {
        odinfmt = {
          command = 'odinfmt',
          args = { '-stdin' },
          stdin = true,
        },
      },
      formatters_by_ft = {
        lua = { 'stylua' },
        yaml = { 'yamlfmt' },
        markdown = { 'prettier' },
        terraform = { 'terraform_fmt' },
        cmake = { 'cmake_format' },
        css = { 'prettier' },
        html = { 'prettier' },
        python = { 'ruff_format' },
        xml = { 'xmlformatter' },
      },
      default_format_opts = {
        lsp_format = 'fallback',
      },
      format_on_save = {
        lsp_format = 'fallback',
        timeout_ms = 3000,
      },
      notify_no_formatters = false,
    },
  },
}
