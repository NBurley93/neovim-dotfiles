return {
    { "github/copilot.vim" },
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
                    copilot = {
                        endpoint = "https://copilot-proxy.githubusercontent.com/v1/chat/completions",
                        secret = {
                            "bash",
                            "-c",
                            "cat ~/.config/github-copilot/apps.json | sed -e 's/.*oauth_token...//;s/\".*//'",
                        },
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
                    {
                        provider = "copilot",
                        name = "gh-copilot",
                        model = { model = "copilot-chat" },
                        chat = true,
                        command = true,
                        system_prompt =
                            "You are a technical writer responsible for documenting the common practices used in the attached repositories. Your task is to analyze the code within these projects and create a comprehensive document outlining the guidelines and best practices followed.\n\n"
                            .. "Instructions:\n\n"
                            .. "1. Identify Common Practices:\n"
                            .. "	* Explain each common practice you find using specific examples from the codebase.\n"
                            .. "	* Include details on why each practice is used and why it is considered a standard.\n\n"
                            .. "2. Use specific examples from the codebase to illustrate each common practice.\n"
                            .. "	* Include specific inline examples of the practice from the codebase\n"
                            .. "	* Include links to other places in the codebase where the same practice is used.\n"
                            .. "	* Ensure all links are valid\n"
                            .. "	* Ensure all links point to actual files in the GitHub repositories\n"
                            .. "	* Ensure all links point to the line number where the example starts\n\n"
                            .. "3. Exclude Test Code:\n"
                            .. "	* Do not include any of the test code in this analysis.\n\n"
                            .. "4. Format the Document:\n"
                            .. "	* Create a GitHub-flavored Markdown document with the details.\n"
                            .. "	* Use appropriate Markdown elements such as headings, lists, code blocks, and links to make the document well-structured and easily readable.\n\n\n"
                            .. "Additional Guidelines:\n"
                            .. "	* Consistency: Ensure the document maintains a consistent tone and style throughout.\n"
                            .. "	* Clarity: Write in clear, concise language to make the document accessible to readers of varying technical backgrounds.\n"
                            .. "	* Accuracy: Verify the accuracy of all examples and links provided.\n"
                            .. "	* Comprehensiveness: Cover all relevant practices and standards found in the codebase.\n"
                            .. "	* Safety: Make sure nothing in the response violates GitHub content policies.\n"
                    },
                },
            }
            require("gp").setup(conf)
        end,
    }
}
