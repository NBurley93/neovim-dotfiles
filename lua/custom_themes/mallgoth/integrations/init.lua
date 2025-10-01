local M = {};
local pm = require('custom_themes.mallgoth.common').process_module

local config_fs = vim.fn.stdpath('config')
local integrations_dir = vim.fs.joinpath(config_fs, 'lua', 'custom_themes', 'mallgoth', 'integrations')

function M.config()
    for name, t in vim.fs.dir(integrations_dir) do
        if t == 'file' and name:sub(-4) == '.lua' and name ~= 'init.lua' then
            local stem = name:sub(1, -5) -- strip extension
            local mod = ('custom_themes.mallgoth.integrations.%s'):format(stem)

            local ok, loaded = pcall(require, mod)
            if not ok then
                vim.notify(
                    ('[mallgoth] Failed to load integration module %s:\n%s'):format(mod, loaded), vim.log.levels.WARN)
            else
                if type(loaded) == 'table' then
                    pm(loaded)
                end
            end
        end
    end
end

return M
