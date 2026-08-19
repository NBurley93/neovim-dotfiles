return {
  {
    'stevearc/overseer.nvim',
    ---@module 'overseer'
    ---@type overseer.SetupOpts
    opts = {},
    keys = {
      {
        '<leader>tr',
        function()
          require('overseer').run_task()
        end,
        desc = 'Run Task',
      },
      {
        '<leader>to',
        '<cmd>OverseerToggle bottom<cr>',
        desc = 'Task list',
      },
      {
        '<leader>ta',
        '<cmd>OverseerTaskAction<cr>',
        desc = 'Task action',
      },
    },
  },
}
