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


function M.provision_config()
    local chutes_provider = require('common.ai_backends.chutes')
    local cfg = M.baseline_config

    if chutes_provider.use_chutes() then
        vim.notify("Using Chutes AI as provider for Copilot Chat.", vim.log.levels.INFO)
        cfg = chutes_provider.provision_config(cfg)
    else
        vim.notify("Using default provider for Copilot Chat.",
            vim.log.levels.INFO)
    end
    return cfg
end

return M
