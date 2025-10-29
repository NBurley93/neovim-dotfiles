return {
  -- statuscol.nvim: Enhanced status column for Neovim
  {
    'luukvbaal/statuscol.nvim',
    config = function()
      local builtin = require('statuscol.builtin')
      require('statuscol').setup({
        relculright = true,
        segments = {
          -- Diagnostics
          {
            sign = { namespace = { 'diagnostic' } },
          },
          -- Folds
          { text = { builtin.foldfunc }, click = 'v:lua.ScFa' },
          -- Line num
          {
            text = { ' ', builtin.lnumfunc },
            condition = { true, builtin.not_empty },
          },
          -- Gitsigns
          {
            sign = {
              namespace = { 'gitsigns' },
              maxwidth = 1,
              colwidth = 1,
              wrap = true,
              auto = '┃',
              fillchar = '┃',
            },
          },
        },
      })
    end,
  },

  -- gitsigns.nvim: Git integration for sign columns
  {
    'lewis6991/gitsigns.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      require('gitsigns').setup({
        signs = {
          add = { text = '┃' },
          change = { text = '┃' },
          delete = { text = '┃' },
          topdelete = { text = '┃' },
          changedelete = { text = '┃' },
          untracked = { text = '┃' },
        },
        signcolumn = true,
        current_line_blame = true,
        current_line_blame_opts = {
          delay = 500,
          virt_text = true,
          virt_text_pos = 'eol',
        },
      })
    end,
  },
}
