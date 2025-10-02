-- lua/custom_themes/mallgoth/lazy.lua
local P = require("custom_themes.mallgoth.palette")

return {
    highlights = {
        -- Main surface
        LazyNormal            = { fg = P.fg, bg = P.bg0 },

        -- Section headers: poison apple = neon green + royal violet
        LazyH1                = { fg = P.neon_green, bg = P.violent_violet, bold = true },
        LazyH2                = { fg = P.pastel_poison_green, bg = P.bg1, bold = true },

        -- Buttons
        -- idle: subtle green on panel; active: inverted, readable pop
        LazyButton            = { fg = P.pastel_poison_green, bg = P.bg1, bold = true },
        LazyButtonActive      = { fg = P.search_fg, bg = P.electric_violet, bold = true },
        LazyButtonInactive    = { fg = P.muted, bg = P.bg1 },

        -- Lists, props, dim text (no cyan)
        LazyComment           = { fg = P.muted, italic = true },
        LazyProp              = { fg = P.bruise_blue }, -- labels: cool muted blue
        LazyDimmed            = { fg = P.muted },

        -- Reasons (why a plugin loaded) — grouped by color family
        LazyReasonCmd         = { fg = P.lurid_seafoam },
        LazyReasonImport      = { fg = P.lurid_seafoam },
        LazyReasonRequire     = { fg = P.lurid_seafoam },

        LazyReasonEvent       = { fg = P.candlelight_yellow },
        LazyReasonStart       = { fg = P.neon_green },

        LazyReasonFt          = { fg = P.haunted_lavender },
        LazyReasonRuntime     = { fg = P.haunted_lavender },

        LazyReasonPlugin      = { fg = P.electric_violet },
        LazyReasonKeys        = { fg = P.neon_green },
        LazyReasonSource      = { fg = P.neon_green },

        -- Progress + statuses
        LazyProgressDone      = { fg = P.neon_green },
        LazyProgressTodo      = { fg = P.muted },
        LazyTaskOutput        = { fg = P.fg },

        -- Git-ish bits inside Lazy panes
        LazyCommit            = { fg = P.haunted_lavender },
        LazyCommitIssue       = { fg = P.neon_green, underline = true },
        LazyNoCond            = { fg = P.rose_red },
        LazyLocal             = { fg = P.violent_violet },

        -- Links and paths
        LazyDir               = { fg = P.bruise_blue, bold = true }, -- directory names: structural, not teal
        LazyUrl               = { fg = P.neon_green, underline = true },
        LazyKey               = { fg = P.pale_lilac, bold = true },
        LazyValue             = { fg = P.electric_violet },

        -- Diagnostics inside Lazy (align to global)
        LazyError             = { fg = P.harsh_magenta, bold = true },
        LazyWarning           = { fg = P.sickly_yellow, bold = true },
        LazyInfo              = { fg = P.acid_teal, bold = true }, -- single cameo; feel free to swap to glacial_mint
        LazySpecial           = { fg = P.rose_red, bold = true },

        -- Descriptions / help
        LazyButtonDescription = { fg = P.muted },
        LazyHelpHeader        = { fg = P.neon_green, bold = true },
    },
}
