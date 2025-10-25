return {
  config = function()
    vim.keymap.set('n', '<leader>gs', function()
      local toStage = vim.fn.expand '%:p'
      vim.cmd.Git('add ' .. toStage)
      print('Staged ' .. toStage)
    end, { desc = 'Stage the currently open buffer' })

    vim.keymap.set('n', '<leader>gf', vim.cmd.Git, { desc = 'View git fugitive' })
    vim.keymap.set('n', '<leader>dvo', vim.cmd.DiffviewOpen, { desc = 'Review diffs in diffview' })
    vim.keymap.set('n', '<leader>dvc', vim.cmd.DiffviewClose, { desc = 'Close diffview if open' })
    vim.keymap.set('n', '<leader>dvh', vim.cmd.DiffviewFileHistory, { desc = 'Opens the git file history view' })
  end,
}
