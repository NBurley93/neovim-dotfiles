return {
    {
        "robitx/gp.nvim",
        config = function()
            local conf = {
                providers = {
                    openai = { disable = true, },
                    openrouter = {
                        endpoint = "https://openrouter.ai/api/v1/chat/completions",
                        secret = os.getenv("GP_NVIM_KEY") or { "cat", "~/gp_key.txt" },
                    },
                },
                agents = {
                    {
                        provider = "openrouter",
                        name = "or-deepseek",
                        model = { model = "deepseek/deepseek-r1", temperature = 0.1, top_p = 1 },
                        chat = true,
                        command = true,
                        system_prompt = "You are an AI working as a code editor.\n\n"
                            .. "before providing an answer, check the appropriate documentation.\n"
                            .. "do not rely on your memory and always provide reference to the place you found the relevant info.\n"
                            .. "then ask yourself - am I correct? reconsider your answer.\n"
                            .. "present your answer only when you see no room for improvement.\n"
                            .. "Please provide extensive explanatio both of the reasoning and the code\n"
                            .. "START AND END YOUR ANSWER WITH:\n\n```"
                    },
                    {
                        provider = "openrouter",
                        name = "or-claude",
                        model = { model = "anthropic/claude-3.5-sonnet", temperature = 0.1, top_p = 1 },
                        chat = true,
                        command = true,
                        system_prompt = "You are an AI working as a code editor.\n\n"
                            .. "before providing an answer, check the appropriate documentation.\n"
                            .. "do not rely on your memory and always provide reference to the place you found the relevant info.\n"
                            .. "then ask yourself - am I correct? reconsider your answer.\n"
                            .. "present your answer only when you see no room for improvement.\n"
                            .. "Please AVOID COMMENTARY OUTSIDE OF THE SNIPPET RESPONSE.\n"
                            .. "START AND END YOUR ANSWER WITH:\n\n```"
                    },
                },
            }
            require("gp").setup(conf)
        end,
    }
}
