return {
  -- nvim-ufo: code folding
  {
    'kevinhwang91/nvim-ufo',
    event = {
      'BufReadPost',
      'BufNewFile',
    },
    opts = {
      provider_selector = function(bufnr, filetype, buftype)
        return { 'treesitter', 'indent' }
      end,
    },
    dependencies = {
      'kevinhwang91/promise-async',
    },
    keys = {
      {
        'zR',
        function()
          require('ufo').openAllFolds()
        end,
        mode = 'n',
        desc = 'Open all folds',
      },
      {
        'zM',
        function()
          require('ufo').closeAllFolds()
        end,
        mode = 'n',
        desc = 'Close all folds',
      },
    },
  },

  -- oil.nvim: a file explorer
  {
    'stevearc/oil.nvim',
    config = function()
      require('oil').setup({
        view_options = {
          show_hidden = true,
        },
      })
    end,
    keys = {
      {
        '<leader>pv',
        '<cmd>Oil<cr>',
        mode = 'n',
        desc = '[V]iew cwd with Oil',
      },
    },
    dependencies = { require('common.defines').WEB_DEVICONS_PROVIDER },
  },

  {
    'folke/flash.nvim',
    event = 'VeryLazy',
    keys = {
      {
        's',
        function()
          require('flash').jump()
        end,
        mode = { 'n', 'x', 'o' },
        desc = 'Flash',
      },
      {
        'S',
        function()
          require('flash').treesitter()
        end,
        mode = { 'n', 'x', 'o' },
        desc = 'Flash Treesitter',
      },
    },
    opts = {
      modes = {
        char = {
          jump_labels = true,
        },
      },
    },
  },

  -- glance.nvim: preview definitions, references, etc.
  {
    'DNLHC/glance.nvim',
    cmd = 'Glance',
    opts = {
      preview_win_opts = {
        cursorline = true,
        number = true,
        wrap = true,
      },
      border = {
        enable = true,
      },
    },
  },
}
