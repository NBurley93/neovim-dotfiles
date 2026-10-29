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
        bt_ignore = { 'terminal', 'prompt', 'nofile' },
        segments = {
          -- Folds (click to open/close)
          {
            text = { builtin.foldfunc },
            click = 'v:lua.ScFa',
          },
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
          -- Diagnostics
          {
            sign = {
              namespace = { 'diagnostic' },
              maxwidth = 1,
              auto = false,
              colwidth = 1,
              foldclosed = true,
            },
          },
          -- Breakpoints, in their own column so a diagnostic can't hide them.
          -- Only takes up space in windows that have one.
          {
            sign = {
              name = { 'DapBreakpoint', 'DapBreakpointCondition', 'DapBreakpointRejected', 'DapStopped' },
              maxwidth = 1,
              auto = true,
              colwidth = 1,
            },
            click = 'v:lua.ScSa',
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
        on_attach = function(bufnr)
          local gitsigns = require('gitsigns')
          local function map(mode, lhs, rhs, desc)
            vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
          end

          -- Navigation (falls back to ]c/[c behaviour in diff mode)
          map('n', ']h', function()
            if vim.wo.diff then
              vim.cmd.normal({ ']c', bang = true })
            else
              gitsigns.nav_hunk('next')
            end
          end, 'Next git hunk')
          map('n', '[h', function()
            if vim.wo.diff then
              vim.cmd.normal({ '[c', bang = true })
            else
              gitsigns.nav_hunk('prev')
            end
          end, 'Previous git hunk')

          -- Actions
          map('n', '<leader>hs', gitsigns.stage_hunk, '[H]unk [S]tage/unstage')
          map('n', '<leader>hr', gitsigns.reset_hunk, '[H]unk [R]eset')
          map('v', '<leader>hs', function()
            gitsigns.stage_hunk({ vim.fn.line('.'), vim.fn.line('v') })
          end, '[H]unk [S]tage/unstage selection')
          map('v', '<leader>hr', function()
            gitsigns.reset_hunk({ vim.fn.line('.'), vim.fn.line('v') })
          end, '[H]unk [R]eset selection')
          map('n', '<leader>hp', gitsigns.preview_hunk, '[H]unk [P]review')

          -- Text object
          map({ 'o', 'x' }, 'ih', gitsigns.select_hunk, 'Inner git hunk')
        end,
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
