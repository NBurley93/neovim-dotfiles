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

  -- Miki
  -- {
  --   'NBurley93/miki-assistant.nvim',
  --   dev = true,
  --   dependencies = {
  --     'CopilotC-Nvim/CopilotChat.nvim',
  --   },
  --   opts = {
  --     model = 'claude-sonnet-4.5',
  --     personality = {
  --       sass_level = 7, -- 1-10, how snarky
  --       profanity_level = 6, -- 1-10, how much profanity
  --       innuendo_frequency = 6, -- 1-10, how suggestive
  --       emoji_frequency = 'moderate', -- none, low, moderate, high
  --     },
  --   },
  -- },

  -- -- Copilot Chat AI chat interface
  -- {
  --   'CopilotC-Nvim/CopilotChat.nvim',
  --   event = 'VimEnter',
  --   dependencies = {
  --     'nvim-lua/plenary.nvim',
  --     'zbirenbaum/copilot.lua',
  --   },
  --   build = (function()
  --     local uname = vim.loop.os_uname().sysname
  --     if uname == 'Darwin' or uname == 'Linux' then
  --       return 'make tiktoken'
  --     end
  --     return nil
  --   end)(),
  --   config = function()
  --     local ai_backend = require('common.ai_backend')
  --     require('CopilotChat').setup(ai_backend.provision_config())
  --   end,
  -- },
}
