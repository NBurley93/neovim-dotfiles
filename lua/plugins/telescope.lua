return {
  {
    'nvim-telescope/telescope.nvim',
    cmd = 'Telescope',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-lua/popup.nvim',
      'nvim-telescope/telescope-ui-select.nvim',
    },
    keys = {
      {
        '<leader>sf',
        function()
          require('telescope.builtin').find_files()
        end,
        mode = 'n',
        desc = 'Search [F]iles',
      },
      {
        '<leader>ss',
        function()
          require('telescope.builtin').live_grep()
        end,
        mode = 'n',
        desc = 'Grep Search [S]tring',
      },
      {
        '<leader><leader>',
        function()
          require('telescope.builtin').buffers(
            require('telescope.themes').get_dropdown({ previewer = false }),
            { sort_lastused = true, ignore_current_buffer = true }
          )
        end,
        mode = 'n',
        desc = 'Search open buffers',
      },
      {
        '<leader>sh',
        function()
          require('telescope.builtin').help_tags()
        end,
        mode = 'n',
        desc = 'Search [H]elp Tags',
      },
    },
    config = function()
      local ts = require('telescope')

      ts.setup({
        ['ui-select'] = {
          require('telescope.themes').get_dropdown({}),
        },
        defaults = {
          layout_config = { prompt_position = 'top', height = 0.92, width = 0.92 },
          layout_strategy = 'flex',
          sorting_strategy = 'ascending',
          -- winblend = 20,
          -- prompt_prefix = " ".. icons.ui.Telescope .. " ",
          -- selection_caret = "  ",
          show_line = false,
          results_title = '',
          prompt_title = '',
          preview_title = '',
          dynamic_preview_title = false,
          border = true,
          color_devicons = true,
          prompt_prefix = '  ', -- looks nice in neon; change if your font sulks
          selection_caret = ' ',
          borderchars = {
            prompt = { '━', '┃', '━', '┃', '┏', '┓', '┛', '┗' },
            results = { '━', '┃', '━', '┃', '┏', '┓', '┛', '┗' },
            preview = { '━', '┃', '━', '┃', '┏', '┓', '┛', '┗' },
          },
        },
        pickers = {
          find_files = { hidden = true },
          buffers = { sort_lastused = true, ignore_current_buffer = true },
          live_grep = { only_sort_text = true },
          diagnostics = { theme = 'dropdown' },
        },
        extensions = {
          aerial = {
            show_nesting = {
              ['_'] = false,
              json = true,
              yaml = true,
              lua = true,
              xml = true,
            },
          },
        },
      })
      ts.load_extension('ui-select')
    end,
  },
}
