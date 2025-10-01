local P = require('custom_themes.mallgoth.palette')
return {
    highlights = {
        -- Main surfaces
        LazyNormal = { fg = P.fg, bg = P.bg0 },
        LazyH1 = { fg = P.search_fg, bg = P.ecto_magenta, bold = true },     -- big section headers
        LazyH2 = { fg = P.neon_green, bg = P.bg1, bold = true },                -- smaller headers

        -- Buttons
        LazyButton = { fg = P.neon_green, bg = P.bg1, bold = true },
        LazyButtonActive = { fg = P.search_fg, bg = P.biohazard_lime, bold = true },
        LazyButtonInactive = { fg = P.muted, bg = P.bg1 },

        -- Lists, props, dim text
        LazyComment = { fg = P.muted, italic = true },
        LazyProp = { fg = P.acid_teal },     -- left-column labels (e.g. “event”, “keys”,
        LazyDimmed = { fg = P.muted },       -- less important text

        -- Reasons (why a plugin loaded,
        LazyReasonCmd = { fg = P.acid_teal },
        LazyReasonEvent = { fg = P.sickly_yellow },
        LazyReasonFt = { fg = P.pale_lilac },
        LazyReasonImport = { fg = P.acid_teal },
        LazyReasonKeys = { fg = P.neon_green },
        LazyReasonPlugin = { fg = P.electric_violet },
        LazyReasonRequire = { fg = P.acid_teal },
        LazyReasonRuntime = { fg = P.pale_lilac },
        LazyReasonSource = { fg = P.neon_green },
        LazyReasonStart = { fg = P.cursor_glow },

        -- Progress + statuses
        LazyProgressDone = { fg = P.neon_green },
        LazyProgressTodo = { fg = P.muted },
        LazyTaskOutput = { fg = P.fg },

        -- Git-ish bits inside Lazy panes
        LazyCommit = { fg = P.pale_lilac },
        LazyCommitIssue = { fg = P.neon_green, underline = true },
        LazyNoCond = { fg = P.rose_red },     -- disabled by cond=false
        LazyLocal = { fg = P.acid_teal },     -- local plugin marker

        -- Links and paths
        LazyDir = { fg = P.acid_teal },
        LazyUrl = { fg = P.neon_green, underline = true },
        LazyKey = { fg = P.pale_lilac, bold = true },
        LazyValue = { fg = P.electric_violet },

        -- Diagnostics inside Lazy
        LazyError = { fg = P.harsh_magenta, bold = true },
        LazyWarning = { fg = P.sickly_yellow, bold = true },
        LazyInfo = { fg = P.acid_teal, bold = true },
        LazySpecial = { fg = P.rose_red, bold = true },

        -- Optional: make Lazy windows blend with your statusline vibes
        LazyButtonDescription = { fg = P.muted },
        LazyHelpHeader = { fg = P.neon_green, bold = true },
    },
}
