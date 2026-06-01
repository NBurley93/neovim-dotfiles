local commonicons = require('common.icons')

return {
  {
    'nvim-neotest/neotest',
    config = function()
      require('neotest').setup({
        icons = {
          failed = commonicons.testing.Fail,
          passed = commonicons.testing.Pass,
          running = commonicons.testing.Running,
          skipped = commonicons.testing.Skipped,
          unknown = commonicons.testing.Unknown,
        },
        output = {
          enabled = true,
          open_on_run = 'short',
        },
        status = {
          virtual_text = true,
          enabled = true,
          signs = true,
        },
        adapters = {
          require('neotest-python')({
            runner = 'pytest',
            pytest_discover_instances = true,
            python = '.venv/bin/python',
            args = { 'tests', '-vv', '--no-cov' },
          }),
        },
        output_panel = {
          enabled = true,
          open = 'botright split | resize 15',
        },
        summary = {
          animated = false,
          enabled = true,
          follow = true,
          expand_errors = true,
          mappings = {
            expand = { '<CR>', '<2-LeftMouse>' },
            expand_focused = { '<CR>', '<2-LeftMouse>' },
            open = 'o',
            run = 'r',
            short = 'O',
            stop = 's',
          },
          open = 'botright vsplit | vertical resize 50',
          count = true,
        },
      })
    end,
    ft = { 'python' },
    dependencies = {
      'nvim-neotest/nvim-nio',
      'nvim-lua/plenary.nvim',
      'nvim-treesitter/nvim-treesitter',
      'antoinemadec/FixCursorHold.nvim',
      'nvim-neotest/neotest-python',
    },
    keys = {
      {
        '<leader>us',
        function()
          require('neotest').summary.open()
        end,
        desc = 'Open unit-test summary window',
      },
      {
        '<leader>ut',
        function()
          require('neotest').run.run()
        end,
        desc = 'Run the nearest unit-test',
      },
      {
        '<leader>uT',
        function()
          require('neotest').run.run(vim.fn.expand('%'))
        end,
        desc = 'Run all unit-tests in the active buffer\'s file',
      },
    },
  },
}
