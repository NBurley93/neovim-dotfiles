local function trouble_keymaps()
    -- Trouble
    vim.keymap.set("n", "<leader>t", function()
        vim.cmd.Trouble("diagnostics", "toggle")
    end, { desc = "Show Trouble menu" })
end

local function ufo_keymaps()
    -- Folds
    vim.keymap.set("n", "zR", function() require('ufo').openAllFolds() end, { desc = "Open all Folds (UFO)" })
    vim.keymap.set("n", "zM", function() require('ufo').closeAllFolds() end, { desc = "Close all Folds (UFO)" })
end

local function oil_keymaps()
    -- Oil
    vim.keymap.set("n", "<leader>pv", function()
        vim.cmd.Oil()
    end, { desc = "Open Oil to cwd" })
end

local function harpoon_keymaps()
    -- Harpoon
    local harpoon = require('harpoon')
    local commonfuncs = require('common.functions')
    vim.keymap.set('n', '<leader>m', function()
        harpoon:list():add()
        commonfuncs.flashBuffer(vim.api.nvim_get_current_buf(), 150)
        commonfuncs.nvim_notify_info("Added " .. vim.fs.basename(vim.api.nvim_buf_get_name(0)) .. " to Harpoon list")
    end, { desc = "Mark current buffer for Harpoon", })

    vim.keymap.set('n', '<C-S-P>', function() harpoon:list():prev() end, { desc = "Goto previous Harpoon buffer", })
    vim.keymap.set('n', '<C-S-N>', function() harpoon:list():next() end, { desc = "Goto next Harpoon buffer", })
end

local function copilot_keymaps()
    -- Copilot
    vim.keymap.set("n", "<leader>cpc", function()
        vim.cmd.CopilotChatToggle()
    end, { desc = "Open Copilot chat" })

    vim.keymap.set("n", "<leader>cpm", function()
        vim.cmd.CopilotChatModels()
    end, { desc = "Show Copilot Models" })

    vim.keymap.set("n", "<leader>cpp", function()
        vim.cmd.CopilotChatPrompts()
    end, { desc = "Prepare a Copilot prompt" })
end

local function rip_sub_keymaps()
    vim.keymap.set({"n", "x"}, "<leader>fs", function()
        require("rip-substitute").sub()
    end, { desc = " rip substitute"})
end

return {
    config = function()
        -- Shortcut to exit insert mode
        vim.keymap.set("i", "<C-c>", "<Esc>", { desc = "Exit insert mode" })

        trouble_keymaps()
        ufo_keymaps()
        oil_keymaps()
        harpoon_keymaps()
        copilot_keymaps()
        rip_sub_keymaps()
    end,
}
