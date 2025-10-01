local P = require("custom_themes.mallgoth.palette")
return {
    highlights = {
        -- Generic popup chrome (many Snacks UIs are floats,
        SnacksNormal = { fg = P.fg, bg = P.bg0 },
        SnacksBorder = { fg = P.electric_violet, bg = P.bg0 },
        SnacksTitle = { fg = P.search_fg, bg = P.electric_violet, bold = true },
        SnacksDim = { fg = P.muted },
        SnacksIcon = { fg = P.acid_teal },
        SnacksAccent = { fg = P.neon_green, bold = true },

        -- Git-ish coloring some modules show
        SnacksGitAdded = { fg = P.neon_green },
        SnacksGitRemoved = { fg = P.rose_red },
        SnacksGitChanged = { fg = P.sickly_yellow },

        -- Severity
        SnacksInfo = { fg = P.acid_teal },
        SnacksWarn = { fg = P.sickly_yellow },
        SnacksError = { fg = P.harsh_magenta, bold = true },
        SnacksHint = { fg = P.sickly_yellow },
    },

    -- Often used links in Snacks; keep them consistent
    links = {
        SnacksProgress = "SnacksAccent",
        SnacksKey = "SnacksAccent",
    },
}
