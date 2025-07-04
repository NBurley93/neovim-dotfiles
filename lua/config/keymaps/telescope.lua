local utils = require("telescope.utils")
local themes = require("telescope.themes")
local cf = require("common.functions")

local search_map = function(keys, action, desc)
    cf.mapn("<leader>s" .. keys, action, desc)
end

local M = {}

local function map_builtins()
    local builtin = require("telescope.builtin")

    -- Ctrl+p for searching project files
    cf.mapn("<C-p>", function()
        local _, ret, _ = utils.get_os_command_output({ "git", "rev-parse", "--is-inside-work-tree" })
        if ret == 0 then
            builtin.git_files({ show_untracked = true })
        else
            require("common.functions").nvim_notify_info("Not a git repository, defaulting to find_files instead!")
            builtin.find_files()
        end
    end, "Search git files")

    -- Files
    cf.mapn("<leader>ff", builtin.find_files, "Find files")

    -- Search nvim config
    cf.mapn("cf", function()
        builtin.find_files({ cwd = vim.fn.stdpath("config") })
    end, "Neovim Config find files")

    -- Search for a string in files
    cf.mapn("<leader>ss", builtin.live_grep, "String search")

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
    cf.mapn("<leader><leader>", function()
        builtin.buffers(themes.get_dropdown({ previewer = false }), { sort_lastused = true })
    end, "Search Buffers")
end

local function map_extensions()
    local extensions = require("telescope").extensions

    -- Undo history
    search_map("u", function()
        extensions.undo.undo()
    end, "Search undo history")

    search_map("t", function()
        extensions.terraform_doc.terraform_doc({ full_name = "hashicorp/aws" })
    end, "Search AWS Terraform Docs")
end

function M.config()
    map_builtins()
    map_extensions()
end

return M
