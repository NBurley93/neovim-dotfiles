local M = {}

function M.setup(opts)
  vim.cmd.colorscheme('girlfailure')

  -- Custom highlights
  local P = require('girlfailure.palette')

  -- CopilotChat highlights
  vim.api.nvim_set_hl(0, 'CopilotChatHeader', { fg = P.semantic.accent_primary, bold = true })
  vim.api.nvim_set_hl(0, 'CopilotChatSeparator', { fg = P.semantic.accent_secondary, bold = true })
  vim.api.nvim_set_hl(0, 'CopilotChatSelection', { fg = P.semantic.accent_tertiary, bold = true })
  vim.api.nvim_set_hl(0, 'CopilotChatStatus', { fg = P.red['500'] })
  vim.api.nvim_set_hl(0, 'CopilotChatHelp', { fg = P.green['500'] })
  vim.api.nvim_set_hl(0, 'CopilotChatResource', { fg = P.teal['600'], bold = true })
  vim.api.nvim_set_hl(0, 'CopilotChatTool', { fg = P.yellow_blonde['600'], bold = true })
  vim.api.nvim_set_hl(0, 'CopilotChatPrompt', { fg = P.yellow_blonde['300'], bold = true })
  vim.api.nvim_set_hl(0, 'CopilotChatModel', { fg = P.pastel_blue['500'], bold = true })
  vim.api.nvim_set_hl(0, 'CopilotChatUri', { fg = P.cyan['700'] })
  vim.api.nvim_set_hl(0, 'CopilotChatAnnotation', { fg = P.pink['400'] })
end

return M
