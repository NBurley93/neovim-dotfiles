local M = {}

M.current_theme = nil

M.themes_path = vim.fn.stdpath('config') .. '/lua/config/themes'
M.themes_source = "config.themes."

function M.get_available_themes()
    local themes = {}
    local scan_dir = vim.loop.fs_scandir(M.themes_path)

    if scan_dir then
        while true do
            local name, type = vim.loop.fs_scandir_next(scan_dir)
            if not name then break end

            if type == "file" and name:match("%.lua$") then
                local theme_name = name:gsub("%.lua$", "")
                table.insert(themes, theme_name)
            end
        end
    end

    table.sort(themes)
    return themes
end

function M.apply_theme(theme_name, opts)
    opts = opts or {}

    if not theme_name then
        print('No theme specified')
        return false
    end

    local ok, theme = pcall(require, M.themes_source .. theme_name)
    if not ok then
        print('Theme "' .. theme_name .. '" not found')
        print("Error: " .. tostring(theme))
        return false
    end

    if type(theme.setup) ~= "function" then
        print('Theme "' .. theme_name .. '" does not have a setup function')
        return false
    end

    theme.setup(opts)
    M.current_theme = theme_name

    return true
end

function M.setup_commands()
    vim.api.nvim_create_user_command("ThemeList", function()
        local themes = M.get_available_themes()
        print('Available Themes:')
        for _, theme in ipairs(themes) do
            local prefix = theme == M.current_theme and "* " or " "
            print(prefix .. theme)
        end
    end, {})

    vim.api.nvim_create_user_command("Theme", function(opts)
        local theme_name = opts.args
        M.apply_theme(theme_name)
    end, {
        nargs = 1,
        complete = function(_, _, _)
            return M.get_available_themes()
        end
    })
end

function M.config()
    -- vim.api.nvim_set_hl(0, "BufferFlash", { bg = "#FFD700" })

    -- require('custom_themes.mallgoth').colorscheme()
    -- vim.cmd.colorscheme("mallgoth")
    vim.cmd.colorscheme("girlfailure")

    -- M.setup_commands()
    -- M.apply_theme("catppuccin", {
    --     flavour = "macchiato",
    --     transparent_background = true,
    --     float = {
    --         transparent = true,
    --         solid = true,
    --     },
    -- })
end

return M
