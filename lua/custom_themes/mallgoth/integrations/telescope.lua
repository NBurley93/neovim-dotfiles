local P = require("custom_themes.mallgoth.palette")
return {
    highlights = {
        -- Base panes
        TelescopeNormal = { fg = P.fg, bg = P.bg0 },
        TelescopeBorder = { fg = P.electric_violet, bg = P.bg0 },
        TelescopeTitle = { fg = P.search_fg, bg = P.electric_violet, bold = true },

        -- Prompt (bottom or top, depending on layout,
        TelescopePromptNormal = { fg = P.fg, bg = P.transparent },
        TelescopePromptBorder = { fg = P.electric_violet, bg = P.transparent },
        TelescopePromptTitle = { fg = P.search_fg, bg = P.electric_violet, bold = true },
        TelescopePromptPrefix = { fg = P.neon_green, bg = P.transparent },

        -- Results list (the big scrolling part,
        TelescopeResultsNormal = { fg = P.fg, bg = P.bg0 },
        TelescopeResultsBorder = { fg = P.electric_violet, bg = P.bg0 },
        TelescopeResultsTitle = { fg = P.neon_green, bg = P.bg0, bold = true },
        TelescopeResultsLineNr = { fg = P.muted, bg = P.bg0 },
        TelescopeResultsComment = { fg = P.muted, bg = P.bg0, italic = true },
        TelescopeSelection = { fg = P.fg, bg = P.line_focus, bold = true },
        TelescopeSelectionCaret = { fg = P.neon_green, bg = P.line_focus },

        -- Preview pane (right side,
        TelescopePreviewNormal = { fg = P.fg, bg = P.bg0 },
        TelescopePreviewBorder = { fg = P.electric_violet, bg = P.bg0 },
        TelescopePreviewTitle = { fg = P.search_fg, bg = P.electric_violet, bold = true },

        -- Accents
        TelescopeMatching = { fg = P.neon_green, bold = true }, -- matched chars
        TelescopeMultiSelection = { fg = P.acid_teal, bg = P.line_focus },
        TelescopePreviewMatch = { fg = P.neon_green, bg = P.line_focus },
        TelescopePathSeparator = { fg = P.muted },

        -- Diagnostics sprinkled in results (from LSP pickers,
        TelescopeResultsClass = { fg = P.pale_lilac },
        TelescopeResultsConstant = { fg = P.rose_red },
        TelescopeResultsIdentifier = { fg = P.pale_lilac },
        TelescopeResultsNumber = { fg = P.rose_red },
        TelescopeResultsOperator = { fg = P.neon_green },
        TelescopeResultsFunction = { fg = P.acid_teal },
        TelescopeResultsVariable = { fg = P.pale_lilac },
        TelescopeResultsStruct = { fg = P.acid_teal },
    },
}
