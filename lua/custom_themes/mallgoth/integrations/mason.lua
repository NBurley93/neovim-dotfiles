local P = require('custom_themes.mallgoth.palette')
return {
    highlights = {
        MasonNormal = { fg = P.fg, bg = P.bg0 },
        MasonHeader = { fg = P.search_fg, bg = P.violent_violet, bold = true },
        MasonHeaderSecondary = { fg = P.bg0, bg = P.neon_green, bold = true },

        MasonHighlight = { fg = P.biohazard_lime },
        MasonHighlightBlock = { fg = P.search_fg, bg = P.biohazard_lime, bold = true },
        MasonHighlightBlockBold = { fg = P.search_fg, bg = P.biohazard_lime, bold = true },

        MasonMuted = { fg = P.muted },
        MasonMutedBlock = { fg = P.fg, bg = P.bg1 },
        MasonSectionHeader = { fg = P.neon_green, bold = true },
        MasonLink = { fg = P.sickly_yellow, underline = true },

        MasonError = { fg = P.harsh_magenta, bold = true },
        MasonWarning = { fg = P.sickly_yellow },
        MasonInfo = { fg = P.acid_teal },
    },
}
