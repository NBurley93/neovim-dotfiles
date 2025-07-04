return {
    config = function()
        local map = function(keys, action, desc)
            vim.keymap.set("n", keys, action, { desc = desc })
        end

        local mapi = function(keys, action, desc)
            vim.keymap.set("i", keys, action, { desc = desc })
        end

        -- Trouble
        map("<leader>t", function()
            vim.cmd.Trouble("diagnostics", "toggle")
        end, "Show Trouble menu")

        -- Shortcut to exit insert mode
        mapi("<C-c>", "<Esc>", "Exit insert mode")

        -- Folds
        map("zR", function() require('ufo').openAllFolds() end, "Open all Folds (UFO)")
        map("zM", function() require('ufo').closeAllFolds() end, "Close all Folds (UFO)")

        -- Oil
        map("<leader>pv", function()
            vim.cmd.Oil()
        end, "Open Oil to cwd")
    end,
}
