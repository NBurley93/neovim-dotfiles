return {
  -- statuscol.nvim: Enhanced status column for Neovim
  {
    'luukvbaal/statuscol.nvim',
    event = 'BufReadPost',
    dependencies = { 'mfussenegger/nvim-dap', 'lewis6991/gitsigns.nvim' },
    config = function()
      local builtin = require('statuscol.builtin')
      require('statuscol').setup({
        relculright = true,
        ft_ignore = {},
        bt_ignore = { 'terminal', 'prompt', 'nofile' },
        segments = {
          -- Gitsigns
          {
            sign = {
              namespace = { 'gitsigns' },
              maxwidth = 1,
              colwidth = 1,
              wrap = true,
              auto = ' ',
              fillchar = ' ',
            },
          },
          -- Diagnostics & Debugging
          {
            sign = {
              name = { 'DapBreakpoint', 'DapBreakpointCondition', 'DapBreakpointRejected', 'DapStopped' },
              namespace = { 'diagnostic' },
              maxwidth = 1,
              auto = false,
              colwidth = 1,
              foldclosed = true,
            },
          },
          -- Line num
          {
            text = { builtin.lnumfunc, ' ' },
            condition = { true, builtin.not_empty },
          },
        },
      })
    end,
  },

  -- gitsigns.nvim: Git integration for sign columns
  {
    'lewis6991/gitsigns.nvim',
    event = 'BufReadPost',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      require('gitsigns').setup({
        signs = {
          add = { text = '▎' },
          change = { text = '▎' },
          delete = { text = '▁' },
          topdelete = { text = '▔' },
          changedelete = { text = '▎' },
          untracked = { text = '▎' },
        },
        signs_staged = {
          add = { text = '┇' },
          change = { text = '┇' },
          changedelete = { text = '┇' },
          untracked = { text = '┇' },
        },
        signcolumn = true,
        current_line_blame = false,
        current_line_blame_opts = {
          delay = 1000,
          virt_text = true,
          virt_text_pos = 'right_align',
        },
      })
    end,
    keys = {
      {
        '<leader>gb',
        function()
          require('gitsigns').blame_line()
        end,
        desc = 'Git Blame Line',
      },
      {
        '<leader>gB',
        function()
          require('gitsigns').blame()
        end,
        desc = 'Show Git Blame',
      },
    },
  },
}
