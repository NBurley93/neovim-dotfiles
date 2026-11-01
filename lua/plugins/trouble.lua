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
        desc = 'Diagnostics (Trouble) [:Trouble diagnostics toggle]',
      },
      {
        '<leader>xb',
        function()
          vim.cmd.Trouble('diagnostics', 'toggle', 'filter.buf=0')
        end,
        desc = 'Buffer Diagnostics (Trouble) [:Trouble diagnostics toggle filter.buf=0]',
      },
      {
        '<leader>xs',
        function()
          vim.cmd.Trouble('symbols', 'toggle', 'focus=false')
        end,
        desc = 'Symbols (Trouble) [:Trouble symbols toggle focus=false]',
      },
      {
        '<leader>xd',
        function()
          vim.cmd.Trouble('lsp', 'toggle', 'focus=false', 'win.position=right')
        end,
        desc = 'LSP Symbols (Trouble) [:Trouble lsp toggle focus=false win.position=right]',
      },
      {
        '<leader>xL',
        function()
          vim.cmd.Trouble('loclist', 'toggle')
        end,
        desc = 'Location List (Trouble) [:Trouble loclist toggle]',
      },
      {
        '<leader>xQ',
        function()
          vim.cmd.Trouble('qflist', 'toggle')
        end,
        desc = 'Quickfix List (Trouble) [:Trouble qflist toggle]',
      },
    },
    opts = {},
  },
}
