return {
  {
    'rcarriga/nvim-notify',
    config = function()
      require('notify').setup {
        render = 'default',
        stages = 'fade_in_slide_out',
        fps = 60,
        timeout = 3000,
        top_down = false,
        -- background_colour = require('mallgoth.palette').bg0,
        -- background_colour = "#000000",
      }
      vim.notify = require 'notify'
    end,
  },
}
