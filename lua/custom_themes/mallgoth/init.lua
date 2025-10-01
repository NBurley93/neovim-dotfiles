local M = {};

function M.colorscheme()
    vim.cmd('highlight clear')
    vim.cmd('syntax reset')

    vim.o.background = nil
    vim.g.colors_name = "mallgoth"

    local P = require('custom_themes.mallgoth.palette')
    require('custom_themes.mallgoth.common').process_module({
        highlights = {
            -- core editor
            Normal = { fg = P.fg, bg = P.transparent_bg },
            Comment = { fg = P.muted, italic = true },
            CursorLine = { bg = P.line_focus },
            Visual = { bg = P.visual_bg },

            -- Syntax groups
            Keyword = { fg = P.neon_green, bold = true },
            String = { fg = P.electric_violet },
            Function = { fg = P.acid_teal, bold = true },
            Identifier = { fg = P.pale_lilac },
            Constant = { fg = P.rose_red },
            Error = { fg = P.harsh_magenta, bold = true },

            -- search & statusline
            StatusLine = { fg = P.neon_green, bg = P.bg1, bold = true },
            Search = { fg = P.search_fg, bg = P.search_bg, bold = true },

            -- Float windows
            NormalFloat = { fg = P.fg, bg = P.bg0 },
            FloatBorder = { fg = P.electric_violet, bg = P.bg0 },

            -- Diagnostics
            DiagnosticError = { fg = P.harsh_magenta },
            DiagnosticWarn = { fg = P.sickly_yellow },
            DiagnosticInfo = { fg = P.acid_teal },
            DiagnosticHint = { fg = P.sickly_yellow },

            -- diffs
            DiffAdd = { fg = P.diff_add },
            DiffDelete = { fg = P.diff_remove },
            DiffChange = { fg = P.diff_change },
        },
    })

    -- Integrations
    require('custom_themes.mallgoth.integrations').config()
end

return M
