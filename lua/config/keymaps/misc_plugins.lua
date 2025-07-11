return {
    config = function()
        -- Trouble
        vim.keymap.set("n", "<leader>t", function()
            vim.cmd.Trouble("diagnostics", "toggle")
        end, { desc = "Show Trouble menu" })

        -- Shortcut to exit insert mode
        vim.keymap.set("i", "<C-c>", "<Esc>", { desc = "Exit insert mode" })

        -- Folds
        vim.keymap.set("n", "zR", function() require('ufo').openAllFolds() end, { desc = "Open all Folds (UFO)" })
        vim.keymap.set("n", "zM", function() require('ufo').closeAllFolds() end, { desc = "Close all Folds (UFO)" })

        -- Oil
        vim.keymap.set("n", "<leader>pv", function()
            vim.cmd.Oil()
        end, { desc = "Open Oil to cwd" })

        -- Copilot
        vim.keymap.set("n", "<leader>cpc", function()
            vim.cmd.CopilotChatToggle()
        end, { desc = "Open Copilot chat" })

        vim.keymap.set("n", "<leader>cpm", function()
            vim.cmd.CopilotChatModels()
        end, { desc = "Show Copilot Models" })

        vim.keymap.set("n", "<leader>cpa", function()
            vim.cmd.CopilotChatAgents()
        end, { desc = "Show Copilot Agents" })

        vim.keymap.set("n", "<leader>cpp", function()
            vim.cmd.CopilotChatPrompts()
        end, { desc = "Prepare a Copilot prompt" })
    end,
}
