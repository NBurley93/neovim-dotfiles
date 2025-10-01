local P = require('custom_themes.mallgoth.palette')
return {
    highlights = {
        TroubleNormal = { fg = P.fg, bg = P.bg0 },
        TroubleText = { fg = P.fg },
        TroubleFile = { fg = P.acid_teal, bold = true },
        TroubleLocation = { fg = P.muted },
        TroubleFoldIcon = { fg = P.muted },
        TroubleIndent = { fg = P.bg1 },

        -- Counts and titles
        TroubleCount = { fg = P.search_fg, bg = P.electric_violet, bold = true },
        TroubleTitle = { fg = P.neon_green, bold = true },

        -- Signs and severities (kept aligned with Diagnostic groups,
        TroubleSignError = { fg = P.harsh_magenta },
        TroubleSignWarn = { fg = P.sickly_yellow },
        TroubleSignInformation = { fg = P.acid_teal },
        TroubleSignHint = { fg = P.sickly_yellow },

        TroubleTextError = { fg = P.harsh_magenta },
        TroubleTextWarn = { fg = P.sickly_yellow },
        TroubleTextInformation = { fg = P.acid_teal },
        TroubleTextHint = { fg = P.sickly_yellow },
    },
}
