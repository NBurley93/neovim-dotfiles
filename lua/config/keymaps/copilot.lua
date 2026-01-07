return {
  config = function()
    vim.keymap.set('n', '<leader>zm', ':Miki<CR>', { desc = '[M]iki Tutor' })
    vim.keymap.set({ 'n', 'v' }, '<leader>ze', ':MikiExplain<CR>', { desc = 'Miki [E]xplain' })
    vim.keymap.set({ 'n', 'v' }, '<leader>zr', ':MikiReview<CR>', { desc = 'Miki [R]eview' })
    vim.keymap.set('n', '<leader>zc', ':MikiChallenge<CR>', { desc = 'Miki [C]hallenge mode' })
    vim.keymap.set('n', '<leader>zd', ':MikiReview<CR>', { desc = 'Miki [D]eep Analysis' })
  end,
}
