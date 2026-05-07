return {
  {
    'NeogitOrg/neogit',
    cmd = 'Neogit',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'sindrets/diffview.nvim',
      'nvim-telescope/telescope.nvim',
    },
  },
  {
    'sindrets/diffview.nvim',
    dependencies = 'nvim-lua/plenary.nvim',
    cmd = { 'DiffviewOpen', 'DiffviewFileHistory', 'DiffviewClose' },
    config = function()
      require('diffview').setup({
        use_icons = true,
        default_args = {
          DiffviewOpen = { '--imply-local' },
        },
        view = {
          default = {
            layout = 'diff2_horizontal',
            winbar_info = true,
          },
          file_history_view = {
            layout = 'diff2_horizontal',
            winbar_info = true,
          },
          merge_tool = {
            layout = 'diff3_mixed',
            winbar_info = true,
          },
        },
        keymaps = {
          file_panel = {
            {
              'n',
              'cc',
              '<Cmd>Git commit <bar> wincmd J<cr>',
              { desc = 'Commit staged changes' },
            },
            {
              'n',
              'ca',
              '<Cmd>Git commit --amend <bar> wincmd J<cr>',
              { desc = 'Amend last commit' },
            },
          },
        },
      })
    end,
  },
  { 'akinsho/git-conflict.nvim', event = 'BufReadPost' },
}
