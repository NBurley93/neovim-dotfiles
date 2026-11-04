-- Snacks.picker: fuzzy finding, and the backend for vim.ui.select
-- Merged by lazy.nvim with the main snacks.nvim spec in utils.lua
return {
  {
    'folke/snacks.nvim',
    keys = {
      {
        '<leader>sf',
        function()
          Snacks.picker.files()
        end,
        desc = '[S]earch [F]iles',
      },
      {
        '<leader>sg',
        function()
          Snacks.picker.grep()
        end,
        desc = '[S]earch [G]rep',
      },
      {
        '<leader><leader>',
        function()
          Snacks.picker.buffers()
        end,
        desc = '[ ] Find buffers',
      },
      {
        '<leader>sh',
        function()
          Snacks.picker.help()
        end,
        desc = '[S]earch [H]elp',
      },
      {
        '<leader>/',
        function()
          Snacks.picker.lines()
        end,
        desc = '[/] Fuzzy search in current buffer',
      },
      {
        '<leader>s/',
        function()
          Snacks.picker.grep_buffers()
        end,
        desc = '[S]earch [/] in Open Files',
      },
      {
        '<leader>sn',
        function()
          Snacks.picker.files({ cwd = vim.fn.stdpath('config') })
        end,
        desc = '[S]earch [N]eovim files',
      },
      {
        '<leader>sk',
        function()
          Snacks.picker.keymaps()
        end,
        desc = '[S]earch [K]eymaps',
      },
      {
        '<leader>ss',
        function()
          Snacks.picker.pickers()
        end,
        desc = '[S]earch [S]elect Picker',
      },
      {
        '<leader>sw',
        function()
          Snacks.picker.grep_word()
        end,
        desc = '[S]earch current [W]ord',
      },
      {
        '<leader>sd',
        function()
          Snacks.picker.diagnostics()
        end,
        desc = '[S]earch [D]iagnostics',
      },
    },
    opts = {
      picker = {
        prompt = '\u{ed23}  ',
        layout = {
          preset = function()
            return vim.o.columns >= 100 and 'panels_wide' or 'panels_tall'
          end,
        },
        layouts = {
          -- Separate bordered panels with the prompt on top
          panels_wide = {
            layout = {
              box = 'horizontal',
              backdrop = false,
              width = 0.92,
              height = 0.92,
              border = 'none',
              {
                box = 'vertical',
                { win = 'input', height = 1, border = 'bold', title = '{title} {live} {flags}', title_pos = 'center' },
                { win = 'list', border = 'bold' },
              },
              { win = 'preview', title = '{preview}', width = 0.5, border = 'bold' },
            },
          },
          panels_tall = {
            layout = {
              box = 'vertical',
              backdrop = false,
              width = 0.92,
              height = 0.92,
              border = 'none',
              { win = 'input', height = 1, border = 'bold', title = '{title} {live} {flags}', title_pos = 'center' },
              { win = 'list', border = 'bold' },
              { win = 'preview', title = '{preview}', height = 0.5, border = 'bold' },
            },
          },
        },
        sources = {
          files = { hidden = true },
          buffers = { current = false, layout = { preset = 'select' } },
          lines = { layout = { preset = 'select', preview = false } },
          diagnostics = { layout = { preset = 'dropdown' } },
        },
      },
    },
  },
}
