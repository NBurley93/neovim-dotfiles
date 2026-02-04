return {
  -- Copilot suckless
  {
    'zbirenbaum/copilot.lua',
    cmd = 'Copilot',
    event = 'InsertEnter',
    config = function()
      require('copilot').setup({
        suggestion = { enabled = false },
        panel = { enabled = false },
        filetypes = {
          gitcommit = true,
        },
      })
    end,
  },
  -- Blink.cmp Copilot source
  {
    'giuxtaposition/blink-cmp-copilot',
  },

  -- Opencode
  {
    'NickvanDyke/opencode.nvim',
    dependencies = {
      ---@module 'snacks'
      { 'folke/snacks.nvim' },
    },

    config = function()
      vim.g.opencode_opts = {}

      vim.o.autoread = true
    end,
  },
}
