local M = {}

M.baseline_config = {
    temperature = 0.5,
    language = 'English',
    window = {
        layout = 'float',
        width = 0.5,
        height = 0.8,
        border = 'rounded',
        title = '🤖 Copilot Chat',
        zindex = 100,
    },
    headers = {
        user = '👤 User',
        assistant = '🤖 Copilot',
        tool = '🔧 Tool',
    },
    auto_insert_mode = false,
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
        vim.notify("Using Chutes AI as provider for Copilot Chat.", vim.log.levels.INFO)
        cfg = chutes_provider.provision_config(cfg)
    else
        vim.notify("Using default provider for Copilot Chat.",
            vim.log.levels.INFO)
        if vim.env.NEOVIM_COPILOT_USE_BUSINESS_ENDPOINT == '1' then
            M.override_github_provider_url()
            vim.notify("Using GitHub Copilot Business endpoint for Copilot Chat.",
                vim.log.levels.INFO)
        end
    end
    return cfg
end

return M
