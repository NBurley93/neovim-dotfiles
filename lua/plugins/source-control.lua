local function toggle_diffview(cmd)
  if next(require('diffview.lib').views) == nil then
    vim.cmd(cmd)
  else
    vim.cmd('DiffviewClose')
  end
end

return {
  {
    'NeogitOrg/neogit',
    cmd = 'Neogit',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'sindrets/diffview.nvim',
      'nvim-telescope/telescope.nvim',
    },
    keys = {
      {
        '<c-g>',
        function()
          require('neogit').open({ kind = 'split_below_all' })
        end,
        mode = 'n',
        desc = 'View Git status',
      },
    },
  },
  {
    'sindrets/diffview.nvim',
    dependencies = 'nvim-lua/plenary.nvim',
    cmd = { 'DiffviewOpen', 'DiffviewFileHistory', 'DiffviewClose' },
    cond = is_git_root,
    keys = {
      {
        '<leader>gd',
        function()
          toggle_diffview('DiffviewOpen')
        end,
        desc = 'Diff Index',
      },
      {
        '<leader>gD',
        function()
          toggle_diffview('DiffviewOpen master..HEAD')
        end,
        desc = 'Diff master',
      },
      {
        '<leader>gf',
        function()
          toggle_diffview('DiffviewFileHistory %')
        end,
        desc = 'Open diffs for current file',
      },
    },
    config = function()
      local actions = require('diffview.actions')
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
          view = {
            { 'n', 'q', actions.close, { desc = 'Close help menu' } },
          },
          file_panel = {
            { 'n', 'q', '<cmd>DiffviewClose<cr>', { desc = 'Close help menu' } },
          },
          file_history_panel = {
            { 'n', 'q', '<cmd>DiffviewClose<cr>', { desc = 'Close help menu' } },
          },
        },
      })
    end,
  },
  { 'akinsho/git-conflict.nvim', event = 'BufReadPost' },
}
