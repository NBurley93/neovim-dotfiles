-- lua/custom_themes/mallgoth/treesitter.lua
local P = require("custom_themes.mallgoth.palette")

return {
    highlights = {
        -- Core text-ish
        ["@comment"]               = { fg = P.muted, italic = true },
        ["@comment.todo"]          = { fg = P.toxic_tangerine, bold = true },
        ["@comment.note"]          = { fg = P.glacial_mint, bold = true },
        ["@comment.warning"]       = { fg = P.candlelight_yellow, bold = true },
        ["@comment.error"]         = { fg = P.harsh_magenta, bold = true },

        ["@string"]                = { fg = P.electric_violet },
        ["@string.escape"]         = { fg = P.neon_green, bold = true },
        ["@string.special"]        = { fg = P.toxic_aqua },
        ["@character"]             = { fg = P.lurid_seafoam },

        ["@number"]                = { fg = P.faded_gold }, -- separated from constants
        ["@boolean"]               = { fg = P.ecto_magenta, bold = true },
        ["@float"]                 = { fg = P.faded_gold },

        -- Identifiers
        ["@variable"]              = { fg = P.fg },
        ["@variable.builtin"]      = { fg = P.haunted_lavender, italic = true },
        ["@variable.parameter"]    = { fg = P.pale_lilac },
        ["@variable.member"]       = { fg = P.neon_cyan }, -- fields pop cyan
        ["@field"]                 = { fg = P.neon_cyan },
        ["@property"]              = { fg = P.pastel_poison_green },

        ["@constant"]              = { fg = P.rose_red },
        ["@constant.builtin"]      = { fg = P.infrared_pink, bold = true },
        ["@constant.macro"]        = { fg = P.rust_red, italic = true },

        ["@namespace"]             = { fg = P.bruise_blue, bold = true },
        ["@symbol"]                = { fg = P.acid_teal },

        -- Types
        ["@type"]                  = { fg = P.violent_violet, bold = true },
        ["@type.builtin"]          = { fg = P.ultraviolet_blue, italic = true },
        ["@type.definition"]       = { fg = P.violent_violet, bold = true },
        ["@type.qualifier"]        = { fg = P.biohazard_lime },

        -- Functions
        ["@function"]              = { fg = P.acid_teal, bold = true },
        ["@function.builtin"]      = { fg = P.glacial_mint, italic = true },
        ["@function.macro"]        = { fg = P.neon_green, bold = true },
        ["@constructor"]           = { fg = P.toxic_aqua },
        ["@method"]                = { fg = P.acid_teal },

        -- Keywords & flow
        ["@keyword"]               = { fg = P.neon_green, bold = true },
        ["@keyword.function"]      = { fg = P.lurid_seafoam, bold = true },
        ["@keyword.operator"]      = { fg = P.neon_green },
        ["@keyword.return"]        = { fg = P.neon_green },

        ["@conditional"]           = { fg = P.ecto_magenta, bold = true }, -- if/else stand out
        ["@repeat"]                = { fg = P.ecto_magenta },
        ["@label"]                 = { fg = P.hyper_blue },
        ["@include"]               = { fg = P.neon_cyan },
        ["@exception"]             = { fg = P.wine_red, bold = true },

        -- Operators & punctuation
        ["@operator"]              = { fg = P.fg },
        ["@punctuation.delimiter"] = { fg = P.ash_gray },
        ["@punctuation.bracket"]   = { fg = P.ash_gray },
        ["@punctuation.special"]   = { fg = P.neon_green },

        -- Tags (HTML/TSX/etc.)
        ["@tag"]                   = { fg = P.acid_teal, bold = true },
        ["@tag.attribute"]         = { fg = P.haunted_lavender },
        ["@tag.delimiter"]         = { fg = P.gunmetal },

        -- Diffs (when TS annotates)
        ["@diff.plus"]             = { fg = P.neon_green },
        ["@diff.minus"]            = { fg = P.rose_red },
        ["@diff.delta"]            = { fg = P.sickly_yellow },

        -- Markdown niceties
        ["@text.title"]            = { fg = P.electric_violet, bold = true },
        ["@text.strong"]           = { fg = P.bone_white, bold = true },
        ["@text.emphasis"]         = { fg = P.bone_white, italic = true },
        ["@text.uri"]              = { fg = P.neon_green, underline = true },
        ["@text.todo"]             = { fg = P.toxic_tangerine, bold = true },
        ["@text.note"]             = { fg = P.glacial_mint, bold = true },
        ["@text.warning"]          = { fg = P.candlelight_yellow, bold = true },
        ["@text.danger"]           = { fg = P.harsh_magenta, bold = true },
        ["@text.literal"]          = { fg = P.electric_violet },
        ["@text.reference"]        = { fg = P.pale_lilac },

        -- Rainbow-delimiters
        RainbowDelimiterRed        = { fg = P.rose_red },
        RainbowDelimiterYellow     = { fg = P.candlelight_yellow },
        RainbowDelimiterBlue       = { fg = P.hyper_blue },
        RainbowDelimiterOrange     = { fg = P.toxic_tangerine },
        RainbowDelimiterGreen      = { fg = P.slime_green },
        RainbowDelimiterViolet     = { fg = P.violent_violet },
        RainbowDelimiterCyan       = { fg = P.neon_cyan },

        -- indent-blankline / ibl
        IblIndent                  = { fg = "#161616" },
        IblScope                   = { fg = P.line_focus },
    },

    links = {
        -- LSP semantic tokens routed to TS where sane
        ["@lsp.type.class"]                = "@type",
        ["@lsp.type.struct"]               = "@type",
        ["@lsp.type.enum"]                 = "@type",
        ["@lsp.type.type"]                 = "@type",
        ["@lsp.type.typeParameter"]        = "@type",
        ["@lsp.type.interface"]            = "@type",
        ["@lsp.type.parameter"]            = "@variable.parameter",
        ["@lsp.type.property"]             = "@property",
        ["@lsp.type.variable"]             = "@variable",
        ["@lsp.type.function"]             = "@function",
        ["@lsp.type.method"]               = "@method",
        ["@lsp.type.macro"]                = "@function.macro",
        ["@lsp.type.enumMember"]           = "@constant",
        ["@lsp.typemod.variable.readonly"] = "@constant",
        ["@lsp.typemod.variable.global"]   = "@variable.builtin",

        -- Old TS* group backfills
        TSComment                          = "@comment",
        TSString                           = "@string",
        TSCharacter                        = "@character",
        TSNumber                           = "@number",
        TSBoolean                          = "@boolean",
        TSFloat                            = "@float",
        TSVariable                         = "@variable",
        TSVariableBuiltin                  = "@variable.builtin",
        TSParameter                        = "@variable.parameter",
        TSField                            = "@field",
        TSProperty                         = "@property",
        TSConstant                         = "@constant",
        TSConstBuiltin                     = "@constant.builtin",
        TSConstMacro                       = "@constant.macro",
        TSType                             = "@type",
        TSTypeBuiltin                      = "@type.builtin",
        TSFunction                         = "@function",
        TSFuncBuiltin                      = "@function.builtin",
        TSFuncMacro                        = "@function.macro",
        TSConstructor                      = "@constructor",
        TSMethod                           = "@method",
        TSKeyword                          = "@keyword",
        TSKeywordFunction                  = "@keyword.function",
        TSKeywordOperator                  = "@keyword.operator",
        TSConditional                      = "@conditional",
        TSRepeat                           = "@repeat",
        TSLabel                            = "@label",
        TSInclude                          = "@include",
        TSException                        = "@exception",
        TSOperator                         = "@operator",
        TSPunctDelimiter                   = "@punctuation.delimiter",
        TSPunctBracket                     = "@punctuation.bracket",
        TSPunctSpecial                     = "@punctuation.special",
        TSTag                              = "@tag",
        TSTagDelimiter                     = "@tag.delimiter",
    },
}
