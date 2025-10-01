local P = require('custom_themes.mallgoth.palette')
return {
    highlights = {
        DiagnosticVirtualTextError = { fg = P.harsh_magenta, bg = P.line_focus, bold = true },
        DiagnosticVirtualTextWarn = { fg = P.sickly_yellow, bg = P.line_focus },
        DiagnosticVirtualTextInfo = { fg = P.acid_teal, bg = P.line_focus },
        DiagnosticVirtualTextHint = { fg = P.neon_green, bg = P.line_focus },

        LspInlayHint = { fg = P.muted, bg = P.bg1, italic = true },
    },
}
