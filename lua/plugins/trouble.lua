local icons = require('common.icons')

return {
  -- trouble.nvim: A pretty list for showing diagnostics, references, etc.
  {
    'folke/trouble.nvim',
    event = {
      'LspAttach',
    },
    dependencies = { require('common.defines').WEB_DEVICONS_PROVIDER },
    keys = {
      {
        '<leader>xx',
        function()
          vim.cmd.Trouble('diagnostics', 'toggle')
        end,
        desc = 'Diagnostics (Trouble)',
      },
      {
        '<leader>xb',
        function()
          vim.cmd.Trouble('diagnostics', 'toggle', 'filter.buf=0')
        end,
        desc = 'Buffer Diagnostics (Trouble)',
      },
      {
        '<leader>xs',
        function()
          vim.cmd.Trouble('symbols', 'toggle', 'focus=false')
        end,
        desc = 'Symbols (Trouble)',
      },
      {
        '<leader>xd',
        function()
          vim.cmd.Trouble('lsp', 'toggle', 'focus=false', 'win.position=right')
        end,
        desc = 'LSP Symbols (Trouble)',
      },
      {
        '<leader>xL',
        function()
          vim.cmd.Trouble('loclist', 'toggle')
        end,
        desc = 'Location List (Trouble)',
      },
      {
        '<leader>xQ',
        function()
          vim.cmd.Trouble('qflist', 'toggle')
        end,
        desc = 'Quickfix List (Trouble)',
      },
    },
    opts = {
      fold_open = '', -- icon used for open folds
      fold_closed = '', -- icon used for closed folds
      signs = {
        error = icons.diagnostics.Error,
        warning = icons.diagnostics.Warning,
        hint = icons.diagnostics.Hint,
        information = icons.diagnostics.Information,
        other = icons.diagnostics.Information,
      },
    },
  },
}
