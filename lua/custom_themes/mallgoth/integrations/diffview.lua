local P = require('custom_themes.mallgoth.palette')

return {
    highlights = {
        -- Panels & chrome
        DiffviewNormal              = { fg = P.fg, bg = P.bg0 },
        DiffviewFilePanelTitle      = { fg = P.electric_violet, bold = true },
        DiffviewFilePanelCounter    = { fg = P.neon_green, bold = true },
        DiffviewFilePanelFileName   = { fg = P.fg },
        DiffviewFilePanelPath       = { fg = P.bruise_blue }, -- directory prefix
        DiffviewFilePanelRootPath   = { fg = P.haunted_lavender },
        DiffviewFolderName          = { fg = P.violent_violet, bold = true },

        -- Status chips in file panel
        DiffviewStatusAdded         = { fg = P.neon_green },
        DiffviewStatusModified      = { fg = P.toxic_tangerine },
        DiffviewStatusRenamed       = { fg = P.hyper_blue },
        DiffviewStatusDeleted       = { fg = P.rose_red },

        -- Sign column in diff buffers
        DiffviewSignColumn          = { fg = P.muted, bg = P.bg0 },

        -- Line-level wash (subtle backgrounds)
        DiffAdd                     = { bg = P.diff_add_soft, fg = P.search_fg },
        DiffChange                  = { bg = P.diff_change_soft, fg = P.candlelight_yellow },
        DiffDelete                  = { bg = P.diff_remove_soft, fg = P.harsh_magenta },
        DiffText                    = { bg = P.violent_violet, fg = P.search_fg, bold = true },

        -- Word-level (inline) emphasis; keep foreground colored, small bg push
        DiffviewDiffAdd             = { fg = P.neon_green, bg = P.diff_add_text },
        DiffviewDiffChange          = { fg = P.toxic_tangerine, bg = P.diff_change_text },
        DiffviewDiffDelete          = { fg = P.rose_red, bg = P.diff_remove_text },
        DiffviewDiffText            = { fg = P.electric_violet, bg = P.diff_change_text, bold = true },

        -- File panel columns
        DiffviewFilePanelInsertions = { fg = P.neon_green },
        DiffviewFilePanelDeletions  = { fg = P.rose_red },

        -- Commit metadata
        DiffviewReference           = { fg = P.haunted_lavender },
        DiffviewHash                = { fg = P.haunted_lavender },
        DiffviewFileId              = { fg = P.pale_lilac },
        DiffviewDim1                = { fg = P.muted },
    },
}
