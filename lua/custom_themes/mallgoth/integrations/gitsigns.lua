local P = require('custom_themes.mallgoth.palette')
return {
    highlights = {
        -- Sign column symbols
        GitSignsAdd = { fg = P.neon_green, bg = P.bg0 },                 -- added lines
        GitSignsChange = { fg = P.acid_teal, bg = P.bg0 },               -- modified lines
        GitSignsDelete = { fg = P.rose_red, bg = P.bg0 },                -- removed lines
        GitSignsTopdelete = { fg = P.rose_red, bg = P.bg0 },             -- top-of-file delete
        GitSignsChangedelete = { fg = P.sickly_yellow, bg = P.bg0 },     -- modified+deleted

        -- Line highlights (when enabled with `linehl`,
        GitSignsAddLn = { bg = "#0F2A20" },        -- dark moldy green
        GitSignsChangeLn = { bg = "#0B1E25" },     -- deep teal shadow
        GitSignsDeleteLn = { bg = "#260A12" },     -- bruised red

        -- Word diff highlights
        GitSignsAddInline = { fg = P.neon_green, bg = "#112A1A" },
        GitSignsChangeInline = { fg = P.acid_teal, bg = "#0F1F29" },
        GitSignsDeleteInline = { fg = P.rose_red, bg = "#2A0F17" },

        -- Current line blame (pairs with what we set earlier in virtualtext.lua,
        GitSignsCurrentLineBlame = { fg = P.sickly_yellow, italic = true },

        -- Preview window border
        GitSignsPreviewBorder = { fg = P.electric_violet, bg = P.bg0 },
    },
}
