local M = {};

M.colors = require('custom_themes.mallgoth.palette')

function M.hl(group, definition)
    vim.api.nvim_set_hl(0, group, definition)
end

function M.link(group, target)
    vim.api.nvim_set_hl(0, group, { link = target })
end

function M.process_highlights(groups)
    for group, colors in pairs(groups) do
        M.hl(group, colors)
    end
end

function M.process_links(links)
    for group, target in pairs(links) do
        M.link(group, target)
    end
end

function M.process_module(module)
    for k, v in pairs(module) do
        if k == "highlights" then
            M.process_highlights(v)
        elseif k == "links" then
            M.process_links(v)
        end
    end
end

return M
