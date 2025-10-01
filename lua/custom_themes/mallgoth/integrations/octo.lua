local P = require('custom_themes.mallgoth.palette')

return {
    highlights = {
        OctoNormal = { fg = P.fg, bg = P.bg0 },
        OctoBlue = { fg = P.acid_teal },
        OctoGreen = { fg = P.neon_green },
        OctoRed = { fg = P.rose_red },
        OctoYellow = { fg = P.sickly_yellow },
        OctoPurple = { fg = P.electric_violet },

        OctoUser = { fg = P.pale_lilac, bold = true },
        OctoDate = { fg = P.muted, italic = true },
        OctoIssueId = { fg = P.neon_green, bold = true },
        OctoIssueTitle = { fg = P.electric_violet, bold = true },
        OctoPullTitle = { fg = P.acid_teal, bold = true },
        OctoComment = { fg = P.fg },
        OctoDetailsLabel = { fg = P.muted },
        OctoMissingDetails = { fg = P.harsh_magenta },

        -- States
        OctoStateOpen = { fg = P.neon_green, bold = true },
        OctoStateClosed = { fg = P.rose_red, bold = true },
        OctoStateMerged = { fg = P.electric_violet, bold = true },

        -- Bubbles / pills (labels, reactions,
        OctoBubble = { fg = P.fg, bg = P.bg1 },
        OctoBubbleGreen = { fg = P.search_fg, bg = P.neon_green, bold = true },
        OctoBubbleRed = { fg = P.search_fg, bg = P.rose_red, bold = true },
        OctoBubbleYellow = { fg = P.bg0, bg = P.sickly_yellow, bold = true },
    },
}
