local M = {}

M.baseline_config = {
  temperature = 0.5,
  language = 'English',
  window = {
    layout = 'vertical',
    width = 0.33,
  },
  headers = {
    user = '🤔 User',
    assistant = '🖥 AI Assistant',
    tool = '🛠 Tooling',
  },
  prompts = {
    TaskDecomposer = {
      system_prompt = 'You are an expert project manager AI that helps users break down complex projects into smaller, manageable tasks and subtasks. Your goal is to assist users in organizing their projects effectively by providing clear and concise task breakdowns.',
      description = 'Get help breaking down projects into manageable tasks and subtasks.',
    },
  },
  auto_insert_mode = false,
  auto_fold = true,
  separator = '══ஓ๑♡✧ ♡๑ஓ══',
}

function M.override_github_provider_url()
  -- Returns the default github provider, but changes the url to api.business.githubcopilot.com
  local providers = require('CopilotChat.config.providers')
  local provider = providers.copilot
  provider.get_url = function()
    return 'https://api.business.githubcopilot.com/v1/chat/completions'
  end
end

function M.provision_config()
  local chutes_provider = require('common.ai_backends.chutes')
  local cfg = M.baseline_config

  if chutes_provider.use_chutes() then
    cfg = chutes_provider.provision_config(cfg)
  else
    if vim.env.NEOVIM_COPILOT_USE_BUSINESS_ENDPOINT == '1' then
      M.override_github_provider_url()
    end
  end
  return cfg
end

return M
