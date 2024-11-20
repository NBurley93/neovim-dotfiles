return {
    config = function()
        local map = function(keys, action, desc)
            vim.keymap.set("n", keys, action, { desc = desc })
        end

        local mapi = function(keys, action, desc)
            vim.keymap.set("i", keys, action, { desc = desc })
        end

        -- Aerial
        map("<leader>av", function()
            vim.cmd.AerialToggle()
        end, "Toggle aerial view")

        -- treesj
        map("<leader>ns", function()
            require("treesj").split()
        end, "Split treesitter node into multilined statement")

        map("<leader>nj", function()
            require("treesj").join()
        end, "Joins a multiline treesitter node into a single-line statement")

        -- Code annotation
        map("<leader>ca", function()
            require("neogen").generate()
        end, "Generate code annotation")

        -- Trouble
        map("<leader>t", function()
            vim.cmd.Trouble("diagnostics", "toggle")
        end, "Show Trouble menu")

        map("<leader>q", function()
            vim.cmd.Trouble("qflist", "toggle")
        end, "Show quick fix menu")

        -- Shortcut to exit insert mode
        mapi("<C-c>", "<Esc>", "Exit insert mode")

        -- Folds
        map("zR", function() require('ufo').openAllFolds() end, "Open all Folds (UFO)")
        map("zM", function() require('ufo').closeAllFolds() end, "Close all Folds (UFO)")

        -- Oil
        map("<leader>pv", function()
            vim.cmd.Oil()
        end, "View project directory")

        -- w3m
        map("<leader>is", function()
            vim.cmd.W3mSplit(
                vim.fn.input({ prompt = "Search Engine Name (ref https://github.com/yuratomo/w3m.vim) >" }),
                vim.fn.input({ prompt = "Search Query > " })
            )
        end, "[I]nternet [S]earch")

        map("<leader>in", function()
            vim.cmd.W3mSplit(vim.fn.input({ prompt = "URL > " }))
        end, "[I]nternet [N]avigate")
    end,
}
