local P = require('custom_themes.mallgoth.palette')

local base = {
    highlights = {
        -- Base frame used when Noice hands off to notify
        NotifyBackground = { bg = P.bg0 },
        NotifySeparator = { fg = P.electric_violet, bg = P.bg0 },

        -- Optional log view groups (if you ever open :Notify,
        NotifyLogTime = { fg = P.muted },
        NotifyLogTitle = { fg = P.neon_green, bold = true },
    },
}

local levels = {
    ERROR = P.harsh_magenta, -- loud and unmistakable
    WARN = P.sickly_yellow,
    INFO = P.slime_green,
    DEBUG = P.pale_lilac,
    TRACE = P.neon_green,
}

-- Helper to define a level pack
local function level(name, col)
    -- Unpack the three highlight groups used by notify for each level
    return {
        "Notify" .. name .. "Border", { fg = col, bg = P.transparent },
        "Notify" .. name .. "Icon", { fg = col, bg = P.transparent },
        "Notify" .. name .. "Title", { fg = col, bg = P.transparent, bold = true },
        "Notify" .. name .. "Body", { fg = P.fg, bg = P.transparent },
    }
end

local merged = base
for lvl, col in pairs(levels) do
    local defs = level(lvl, col)
    for i = 1, #defs, 2 do
        merged.highlights[defs[i]] = defs[i + 1]
    end
end

return merged
