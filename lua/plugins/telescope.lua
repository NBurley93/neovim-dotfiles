return {
  {
    'nvim-telescope/telescope.nvim',
    cmd = 'Telescope',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-lua/popup.nvim',
      'nvim-telescope/telescope-ui-select.nvim',
      'mrloop/telescope-git-branch.nvim',
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
          -- Solid border
          -- borderchars = { "" },
          prompt_prefix = '  ', -- looks nice in neon; change if your font sulks
          selection_caret = ' ',
          -- borderchars = { '─', '│', '─', '│', '╭', '╮', '╯', '╰' },
          -- borderchars = { '═', '║', '═', '║', '╔', '╗', '╝', '╚' },
          borderchars = {
            prompt = { '━', '┃', '━', '┃', '┏', '┓', '┛', '┗' },
            results = { '━', '┃', '━', '┃', '┏', '┓', '┛', '┗' },
            preview = { '━', '┃', '━', '┃', '┏', '┓', '┛', '┗' },
          },
          -- borderchars = { '━', '┃', '━', '┃', '┏', '┓', '┛', '┗' },
          -- borderchars = {
          --   prompt = { '▀', '▐', '▄', '▌', '▛', '▜', '▟', '▙' },
          --   results = { ' ', '▐', '▄', '▌', '▛', '▜', '▟', '▙' },
          --   preview = { '▀', '▐', '▄', '▌', '▛', '▜', '▟', '▙' },
          -- },
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
      ts.load_extension('git_branch')
    end,
  },
  { 'nvim-telescope/telescope-ui-select.nvim' },
  { 'mrloop/telescope-git-branch.nvim' },
}
