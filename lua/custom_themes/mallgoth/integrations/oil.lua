local P = require('custom_themes.mallgoth.palette')

return {
    highlights = {
        -- Core list
        OilNormal = { fg = P.fg, bg = P.bg0 },
        OilWinSeparator = { fg = P.electric_violet },
        OilDir = { fg = P.toxic_aqua, bold = true },
        OilLink = { fg = P.neon_green, underline = true },
        OilSocket = { fg = P.electric_violet },
        OilPerm = { fg = P.muted },
        OilTime = { fg = P.muted },
        OilSize = { fg = P.muted },

        -- States
        OilCreate = { fg = P.neon_green },
        OilDelete = { fg = P.rose_red },
        OilMove = { fg = P.sickly_yellow },
        OilCopy = { fg = P.acid_teal },

        -- Selection and columns
        OilPreview = { fg = P.fg, bg = P.bg0 },
        OilSlot = { fg = P.muted },
        OilTrash = { fg = P.harsh_magenta },
    },
    links = {
        -- Useful links to existing groups so it stays coherent
        OilHLCursor = "CursorLine",
        OilCols = "NonText",
    },
}
