return {
  -- hardtime.nvim: Blocks inefficient key repeats and hints at better motions
  {
    'm4xshen/hardtime.nvim',
    event = 'VeryLazy',
    dependencies = { 'MunifTanjim/nui.nvim' },
    keys = {
      { '<leader>H', '<cmd>Hardtime toggle<cr>', desc = 'Toggle Hardtime' },
    },
    opts = {
      -- 'block' stops the key after max_count repeats, 'hint' only notifies
      restriction_mode = 'block',
      max_count = 3,
      disable_mouse = false,
    },
  },

  -- precognition.nvim: Virtual-text hints for which motions reach where on the current line
  {
    'tris203/precognition.nvim',
    event = 'VeryLazy',
    keys = {
      {
        '<leader>P',
        function()
          require('precognition').toggle()
        end,
        desc = 'Toggle motion hints (Precognition)',
      },
    },
    opts = {
      startVisible = true,
      showBlankVirtLine = false,
    },
  },
}
