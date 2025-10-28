return {
  config = function()
    local neogit = require('neogit')

    vim.keymap.set('n', '<leader>gs', function()
      neogit.open({ kind = 'split_below_all' })
    end, { desc = 'View Git status' })
    vim.keymap.set('n', '<leader>dr', vim.cmd.DiffviewOpen, { desc = 'Review diffs in diffview' })
    vim.keymap.set('n', '<leader>dh', vim.cmd.DiffviewFileHistory, { desc = 'Opens the git file history view' })
  end,
}
