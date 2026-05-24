return {
  -- nvim-rip-substitute: A plugin for performing search and replace operations using ripgrep
  {
    'chrisgrieser/nvim-rip-substitute',
    cmd = 'RipSubstitute',
    opts = {},
    keys = {
      {
        '<leader>sr',
        function()
          require('rip-substitute').sub()
        end,
        mode = { 'n', 'x' },
        desc = ' rip [R]eplace',
      },
    },
  },

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
            lsp_fallback = true,
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
        terraform = { 'terraform_fmt' },
        cmake = { 'cmake_format' },
        json = { 'jq', 'prettier' },
        markdown = { 'prettier' },
        css = { 'prettier' },
        html = { 'prettier' },
        javascript = { 'prettier' },
        python = { 'autopep8' },
        gdscript = { 'gdformat' },
        odin = { 'odinfmt' },
      },
      default_format_ops = {
        lsp_format = 'fallback',
      },
      format_on_save = {
        lsp_format = 'fallback',
        timeout_ms = 3000,
      },
      format_after_save = {
        lsp_fallback = 'fallback',
      },
      notify_no_formatters = false,
    },
  },
}
