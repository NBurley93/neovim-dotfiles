local M = {}

local baseline_mod = require('common.ai_backends.baseline')

M.models = {
    { id = 'deepseek-ai/DeepSeek-R1-0528', name = 'DeepSeek R1 0528' },
    { id = 'deepseek-ai/DeepSeek-R1',      name = 'DeepSeek R1' },
    { id = 'unsloth/gemma-3-12b-it',       name = 'Gemma 3 12b It' },
    { id = 'deepseek-ai/DeepSeek-V3-0324', name = 'DeepSeek V3 0324' },
}

function M.get_models()
    return M.models
end

function M.get_url(_) return "https://llm.ai/v1/chat/completions" end

function M.get_headers()
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


function M.provision_provider_config()
    local cpc_ok, cpc_mod = pcall(require, 'CopilotChat.config.providers')
    if not cpc_ok or not cpc_mod or not cpc_mod.copilot then
        vim.notify("Failed to load CopilotChat.config.providers module.", vim.log.levels.ERROR)
        return baseline_mod.provider_baseline_config
    end

    local config = {
        providers = {
            chutes_ai = {
                get_url = M.get_url,
                get_headers = M.get_headers,
                get_models = M.get_models,
                prepare_input = cpc_mod.copilot.prepare_input,
                prepare_output = cpc_mod.copilot.prepare_output,
            },
        },
        provider = 'chutes_ai',
        model = M.models[1].id,
    }

    local nconfig = vim.tbl_deep_extend("force", baseline_mod.provider_baseline_config, config)
    return nconfig
end

function M.provision_config(base_config)
    return vim.tbl_deep_extend("force", base_config, M.provision_provider_config())
end

function M.use_chutes()
    return vim.env.NEOVIM_ALLOW_CHUTES_PROVIDER == '1'
end

return M
