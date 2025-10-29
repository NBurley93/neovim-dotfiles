return {
  -- nvim-colorizer: Display color codes with their actual color
  {
    'catgoose/nvim-colorizer.lua',
    event = 'BufReadPre',
    opts = {
      user_default_options = {
        names = false,
        mode = 'virtualtext',
        virtualtext = '●',
        virtualtext_inline = true,
        virtualtext_mode = 'foreground',
      },
    },
  },

  -- indent-blankline: Display indentation levels with vertical lines
  {
    'lukas-reineke/indent-blankline.nvim',
    main = 'ibl',
    config = function()
      require('ibl').setup({
        indent = {
          char = '│',
          tab_char = '│',
          --highlight = { "Define" },
        },
        scope = {
          char = '│',
        },
        exclude = {
          buftypes = {
            'nvimtree',
          },
          filetypes = {
            'dashboard',
            'mason',
            'toggleterm',
          },
        },
      })
    end,
  },

  -- pretty_hover: A plugin to enhance LSP hover with a prettier UI
  {
    'Fildo7525/pretty_hover',
    event = 'LspAttach',
    opts = {},
  },

  -- rainbow-csv: Highlight CSV and TSV files with rainbow colors
  { 'mechatroner/rainbow_csv' },
}
