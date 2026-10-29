return {
  -- Noice.nvim: Enhanced UI for Neovim's command line and messages
  {
    'folke/noice.nvim',
    event = 'VeryLazy',
    opts = {
      cmdline = {
        view = 'cmdline_popup',
        format = {
          cmdline = { icon = '󰆍' },
          help = { icon = '󰠗' },
        },
      },
      routes = {
        {
          view = 'notify',
          filter = { event = 'msg_showmode' },
        },
      },
      presets = {
        long_message_to_split = true,
        inc_rename = false,
        lsp_doc_border = true,
      },
      lsp = {
        -- fidget.nvim shows LSP progress
        progress = { enabled = false },
        override = {
          ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
          ['vim.lsp.util.stylize_markdown'] = true,
        },
      },
    },
    dependencies = {
      'MunifTanjim/nui.nvim',
      'rcarriga/nvim-notify',
    },
  },

  -- nvim-notify: A fancy notification manager for Neovim
  {
    'rcarriga/nvim-notify',
    config = function()
      require('notify').setup({
        render = 'default',
        stages = 'fade_in_slide_out',
        fps = 60,
        timeout = 3000,
        top_down = false,
        merge_duplicates = true,
      })
      vim.notify = require('notify')
    end,
  },

  -- fidget.nvim: A status indicator for LSP progress
  {
    'j-hui/fidget.nvim',
    event = { 'BufReadPost', 'BufNewFile' },
    opts = {
      progress = {
        display = {
          done_icon = '✅',
          progress_icon = {
            pattern = 'circle_quarters',
            period = 1,
          },
        },
      },
      notification = {
        window = {
          winblend = 0,
          relative = 'editor',
          x_padding = 2,
          y_padding = 1,
        },
      },
    },
  },
}
