local P = require('custom_themes.mallgoth.palette')

return {
    highlights = {
        -- Fugitive buffers are mostly status & git blame
        fugitiveHeader = { fg = P.electric_violet, bold = true },
        fugitiveHeading = { fg = P.violent_violet, bold = true },
        fugitiveUnstagedHeading = { fg = P.toxic_tangerine, bold = true },
        fugitiveStagedHeading = { fg = P.neon_green, bold = true },

        -- File states
        fugitiveUnstagedModifier = { fg = P.toxic_tangerine },
        fugitiveStagedModifier = { fg = P.neon_green },
        fugitiveUntrackedModifier = { fg = P.candlelight_yellow },

        -- Git object refs
        fugitiveHash = { fg = P.haunted_lavender },
        fugitiveSymbolicRef = { fg = P.acid_teal },
        fugitiveHeaderKey = { fg = P.bone_white },
        fugitiveHeaderValue = { fg = P.fg },
    },
}
