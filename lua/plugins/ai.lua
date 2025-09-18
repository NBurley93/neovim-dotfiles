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
            local ai_backend = require('common.ai_backend')
            require('CopilotChat').setup(ai_backend.provision_config())
        end,
    },
}
