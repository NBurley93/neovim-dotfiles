return {
  -- harpoon: quick file navigation
  {
    'ThePrimeagen/harpoon',
    branch = 'harpoon2',
    requires = { { 'nvim-lua/plenary.nvim' }, { 'telescope/telescope.nvim' } },
  },

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
    dependencies = { require('common.defines').WEB_DEVICONS_PROVIDER },
  },

  {
    'folke/flash.nvim',
    event = 'VeryLazy',
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
