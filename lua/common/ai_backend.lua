local M = {}

local chat = require('CopilotChat')

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


M.chutes_models = {
    { id = 'deepseek-ai/DeepSeek-V3-0324', name = 'DeepSeek V3 0324' },
    { id = 'deepseek-ai/DeepSeek-R1',      name = 'DeepSeek R1' },
    { id = 'deepseek-ai/DeepSeek-R1-0528', name = 'DeepSeek R1 0528' },
    { id = 'unsloth/gemma-3-12b-it',       name = 'Gemma 3 12b It' },
}

function M.get_chutes_models()
    return M.chutes_models
end

function M.get_chutes_url(_) return "https://llm.chutes.ai/v1/chat/completions" end

function M.get_chutes_headers()
    local chutes_token = vim.env.CHUTES_API_TOKEN
    if not chutes_token or chutes_token == '' then
        vim.notify("CHUTES_API_TOKEN is not set. Please set it to use the Chutes AI provider.",
            vim.log.levels.ERROR)
        return {}
    end
    return {
        ["Authorization"] = "Bearer " .. chutes_token
    }
end

M.provider_baseline_config = {
    providers = {
    },
}

function M.provision_chutes_provider_config()
    local cpc_ok, cpc_mod = pcall(require, 'CopilotChat.config.providers')
    if not cpc_ok or not cpc_mod or not cpc_mod.copilot then
        vim.notify("Failed to load CopilotChat.config.providers module.", vim.log.levels.ERROR)
        return M.provider_baseline_config
    end

    local config = {
        providers = {
            chutes_ai = {
                get_url = M.get_chutes_url,
                get_headers = M.get_chutes_headers,
                get_models = M.get_chutes_models,
                prepare_input = cpc_mod.copilot.prepare_input,
                prepare_output = cpc_mod.copilot.prepare_output,
            },
        },
        provider = 'chutes_ai',
        model = 'deepseek-ai/DeepSeek-R1-0528',
    }

    local nconfig = vim.tbl_deep_extend("force", M.provider_baseline_config, config)
    print(vim.inspect(nconfig))
    return nconfig
end

function M.provision_chutes_provider(base_config)
    local use_chutes = vim.env.NEOVIM_ALLOW_CHUTES_PROVIDER == '1'
    if use_chutes then
        local ncfg = vim.tbl_deep_extend("force", base_config, M.provision_chutes_provider_config())
        return ncfg
    else
        return base_config
    end
end

function M.provision_config()
    local cfg = M.baseline_config
    cfg = M.provision_chutes_provider(cfg)
    return cfg
end

return M
