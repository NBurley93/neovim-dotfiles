return {
  config = function()
    vim.keymap.set('n', '<leader>zc', ':CopilotChat<CR>', { desc = 'Open [C]opilot chat' })
    vim.keymap.set('v', '<leader>ze', ':CopilotChatExplain<CR>', { desc = '[E]xplain code' })
    vim.keymap.set('v', '<leader>zr', ':CopilotChatReview<CR>', { desc = '[R]eview code' })
    vim.keymap.set('v', '<leader>zf', ':CopilotChatFix<CR>', { desc = '[F]ix code issues' })
    vim.keymap.set('v', '<leader>zo', ':CopilotChatOptimize<CR>', { desc = '[O]ptimize code' })
    vim.keymap.set('v', '<leader>zd', ':CopilotChatDocs<CR>', { desc = 'Generate [D]ocs' })
    vim.keymap.set('v', '<leader>zt', ':CopilotChatTests<CR>', { desc = 'Generate [T]ests' })
    vim.keymap.set({ 'n', 'v' }, '<leader>zm', ':CopilotChatCommit<CR>', { desc = 'Generate Commit [M]essage' })
  end,
}
