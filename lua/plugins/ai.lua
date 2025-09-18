return {
    {
        "zbirenbaum/copilot.lua",
        cmd = "Copilot",
        event = "InsertEnter",
        config = function()
            require("copilot").setup({
                suggestion = { enabled = false },
                panel = { enabled = false },
                filetypes = {
                    gitcommit = true,
                },
            })
        end,
    },
    {
        "giuxtaposition/blink-cmp-copilot",
    },
    {
        "CopilotC-Nvim/CopilotChat.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "zbirenbaum/copilot.lua",
        },
        build = (function()
            local uname = vim.loop.os_uname().sysname
            if uname == "Darwin" or uname == "Linux" then
                return "make tiktoken"
            end
            return nil
        end)(),
        config = function()
            require('CopilotChat').setup({
            window = {
                layout = 'float',
                width = 0.5,
                height = 0.8,
                border = 'rounded',
                title = '🤖 Copilot Chat',
                zindex = 100,
            },
            headers = {
                user = '👤 You',
                assistant = '🤖 Copilot',
                tool = '🔧 Tool',
            },
            auto_insert_mode = false,
            providers = {
                chutes_ai = {
                    get_url = function(opts) return "https://llm.chutes.ai/v1/chat/completions" end,
                    get_headers = function()
                        return {
                            ["Authorization"] = "Bearer " .. os.getenv("chutes_api_token")
                        }
                    end,
                    get_models = function() return {
                        { id = 'deepseek-ai/DeepSeek-V3-0324', name = 'DeepSeek V3 0324' },
                        { id = 'deepseek-ai/DeepSeek-R1', name = 'DeepSeek R1' },
                        { id = 'deepseek-ai/DeepSeek-R1-0528', name = 'DeepSeek R1 0528' },
                        { id = 'unsloth/gemma-3-12b-it', name = 'Gemma 3 12b It' },
                    } end,
                    prepare_input = require('CopilotChat.config.providers').copilot.prepare_input,
                    prepare_output = require('CopilotChat.config.providers').copilot.prepare_output,
                }
            },
        }) end,
    },
}
