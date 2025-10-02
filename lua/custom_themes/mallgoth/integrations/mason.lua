local P = require('custom_themes.mallgoth.palette')
return {
    highlights = {
        MasonNormal = { fg = P.fg, bg = P.bg0 },
        MasonHeader = { fg = P.search_fg, bg = P.wine_red, bold = true },
        MasonHeaderSecondary = { fg = P.bg0, bg = P.rust_red, bold = true },

        MasonHighlight = { fg = P.infrared_pink },
        MasonHighlightBlock = { fg = P.search_fg, bg = P.infrared_pink },
        MasonHighlightBlockBold = { fg = P.search_fg, bg = P.infrared_pink, bold = true },

        MasonMuted = { fg = P.muted },
        MasonMutedBlock = { fg = P.fg, bg = P.bg1 },
        MasonSectionHeader = { fg = P.slime_green, bold = true },
        MasonLink = { fg = P.sickly_yellow, underline = true },

        MasonError = { fg = P.harsh_magenta, bold = true },
        MasonWarning = { fg = P.sickly_yellow },
        MasonInfo = { fg = P.acid_teal },
    },
}
