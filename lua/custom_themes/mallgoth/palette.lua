-- lua/colors/mallgoth/palette.lua
local P = {
    -- Core
    bg0                 = "#0A0A0A", -- pitch black
    bg1                 = "#1E1E1E", -- subtle UI panels / statusline
    fg                  = "#C5C6C7", -- main text
    muted               = "#6C567B", -- comments, dim text

    transparent         = nil,

    -- Mall-goth primaries
    neon_green          = "#00FF9C", -- keywords, accents
    cursor_glow         = "#39FF14", -- optional cursor color
    electric_violet     = "#A855F7", -- strings, selections, accents
    acid_teal           = "#1AFFD5", -- functions, special
    pale_lilac          = "#C084FC", -- variables, identifiers

    -- Alt neon extras
    neon_cyan           = "#00E5FF",
    toxic_aqua          = "#3DFFDB",
    glacial_mint        = "#5BFFB0",
    hyper_blue          = "#1BC4FF",
    lurid_seafoam       = "#44FFC7",
    infrared_pink       = "#FF1493",
    ultraviolet_blue    = "#6A5ACD",
    toxic_tangerine     = "#FF6F1E",

    -- Purples / magentas
    violent_violet      = "#9D4EDD",
    haunted_lavender    = "#B388EB",
    ecto_magenta        = "#E500FF",

    -- Sickly greens / yellows
    slime_green         = "#7FFF00",
    biohazard_lime      = "#ADFF2F",
    candlelight_yellow  = "#FFF5B1",
    pastel_poison_green = "#9AE66E",

    -- Industrial / grime
    ash_gray            = "#8B8C89",
    gunmetal            = "#2C3539",
    oil_slick_green     = "#3B5B3B",
    rust_red            = "#B7410E",
    bruise_blue         = "#364156",
    faded_gold          = "#C0A060",

    -- Organic / moody
    wine_red            = "#722F37",
    bone_white          = "#E0E0E0",

    -- Alerts / emphasis
    rose_red            = "#FF4D6D", -- numbers, constants
    harsh_magenta       = "#FF006F", -- errors
    sickly_yellow       = "#FFD93D", -- hints / info

    -- UI states
    line_focus          = "#1A0B1E", -- CursorLine
    visual_bg           = "#113322", -- Visual
    search_bg           = "#5A189A", -- Search highlight
    search_fg           = "#000000", -- Search text

    -- Diff
    diff_add            = "#556B2F",
    diff_remove         = "#4B0082",
    diff_change         = "#800020",
}

return P
