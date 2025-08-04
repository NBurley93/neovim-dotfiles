local utils = require("telescope.utils")
local themes = require("telescope.themes")

local search_map = function(keys, action, desc)
    vim.keymap.set("n", "<leader>s" .. keys, action, { desc = desc })
end

local M = {}

local function map_builtins()
    local builtin = require("telescope.builtin")

    -- Ctrl+p for searching project files
    vim.keymap.set("n", "<C-p>", function()
        local _, ret, _ = utils.get_os_command_output({ "git", "rev-parse", "--is-inside-work-tree" })
        if ret == 0 then
            builtin.git_files({ show_untracked = true })
        else
            require("common.functions").nvim_notify_info("Not a git repository, defaulting to find_files instead!")
            builtin.find_files()
        end
    end, { desc = "Search git files" })

    -- Files
    vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Find files" })

    -- Jumplist
    vim.keymap.set("n", "<leader>jj", builtin.jumplist, { desc = "View jumplist" })

    -- View keymaps
    vim.keymap.set("n", "<leader>km", builtin.keymaps, { desc = "View keymaps" })

    -- Search nvim config
    vim.keymap.set("n", "cf", function()
        builtin.find_files({ cwd = vim.fn.stdpath("config") })
    end, { desc = "Neovim Config find files" })

    -- Search for a string in files
    vim.keymap.set("n", "<leader>ss", builtin.live_grep, { desc = "String search" })

    -- Help
    search_map("h", function()
        builtin.help_tags()
    end, "Search help")

    -- Git
    search_map("gb", function()
        builtin.git_branches(themes.get_dropdown({ previewer = false }), { show_remote_tracking_branches = false })
    end, "Search Branches")
    search_map("gB", function()
        builtin.git_branches(themes.get_dropdown({ previewer = false }), { show_remote_tracking_branches = true })
    end, "Search Git Branches + upstream")

    -- Currently open buffers
    vim.keymap.set("n", "<leader><leader>", function()
        builtin.buffers(themes.get_dropdown({ previewer = false }), { sort_lastused = true })
    end, { desc = "Search Buffers" })
end

local function map_extensions()
    local extensions = require("telescope").extensions

    -- Undo history
    search_map("u", function()
        extensions.undo.undo()
    end, "Search undo history")
end

function M.config()
    map_builtins()
    map_extensions()
end

return M
