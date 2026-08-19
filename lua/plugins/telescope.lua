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
        require('telescope.builtin').find_files,
        mode = 'n',
        desc = '[S]earch [F]iles',
      },
      {
        '<leader>sg',
        require('telescope.builtin').live_grep,
        mode = 'n',
        desc = '[S]earch [G]rep',
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
        desc = '[ ] Find buffers',
      },
      {
        '<leader>sh',
        require('telescope.builtin').help_tags,
        mode = 'n',
        desc = '[S]earch [H]elp',
      },
      {
        '<leader>/',
        function()
          require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown({
            winblend = 10,
            previewer = false,
          }))
        end,
        mode = 'n',
        desc = '[/] Fuzzy search in current buffer',
      },
      {
        '<leader>s/',
        function()
          require('telescope.builtin').live_grep({
            grep_open_files = true,
            prompt_title = 'Live Grep in Open Files',
          })
        end,
        mode = 'n',
        desc = '[S]earch [/] in Open Files',
      },
      {
        '<leader>sn',
        function()
          require('telescope.builtin').find_files({ cwd = vim.fn.stdpath('config') })
        end,
        mode = 'n',
        desc = '[S]earch [N]eovim files',
      },
      {
        '<leader>sk',
        require('telescope.builtin').keymaps,
        mode = 'n',
        desc = '[S]earch [K]eymaps',
      },
      {
        '<leader>ss',
        require('telescope.builtin').builtin,
        mode = 'n',
        desc = '[S]earch [S]elect Telescope',
      },
      {
        '<leader>sw',
        require('telescope.builtin').grep_string,
        mode = 'n',
        desc = '[S]earch current [W]ord',
      },
      {
        '<leader>sd',
        require('telescope.builtin').diagnostics,
        mode = 'n',
        desc = '[S]earch [D]iagnostics',
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
