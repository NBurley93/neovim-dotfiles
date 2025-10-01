local P = require('custom_themes.mallgoth.palette')

return {
    highlights = {
        -- Generic popup
        NoicePopup = { fg = P.fg, bg = P.transparent },
        NoicePopupBorder = { fg = P.electric_violet, bg = P.transparent },
        NoicePopupmenu = { fg = P.fg, bg = P.bg0 },
        NoicePopupmenuBorder = { fg = P.electric_violet, bg = P.bg0 },
        NoiceVirtualText = { fg = P.muted },

        -- Cmdline
        NoiceCmdline = { fg = P.fg, bg = P.bg1 },
        NoiceCmdlineIcon = { fg = P.neon_green, bg = P.transparent },
        NoiceCmdlinePopup = { fg = P.fg, bg = P.transparent },
        NoiceCmdlinePopupBorder = { fg = P.electric_violet, bg = P.transparent },
        NoiceCmdlinePopupTitle = { fg = P.search_fg, bg = P.electric_violet, bold = true },

        -- Confirm
        NoiceConfirm = { fg = P.fg, bg = P.bg0 },
        NoiceConfirmBorder = { fg = P.electric_violet, bg = P.bg0 },

        -- LSP progress / messages
        NoiceLspProgressTitle = { fg = P.neon_green, bold = true },
        NoiceLspProgressClient = { fg = P.acid_teal },
        NoiceLspProgressSpinner = { fg = P.neon_green },
        NoiceFormatProgressTodo = { fg = P.muted },
        NoiceFormatProgressDone = { fg = P.neon_green },
        NoiceError = { fg = P.harsh_magenta, bold = true },
        NoiceWarn = { fg = P.sickly_yellow },
        NoiceInfo = { fg = P.acid_teal },
    },
}
