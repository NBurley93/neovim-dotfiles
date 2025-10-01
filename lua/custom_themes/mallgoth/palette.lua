-- lua/colors/mallgoth/palette.lua
local P = {
  -- Core
  bg0            = "#0A0A0A", -- pitch black
  bg1            = "#1E1E1E", -- subtle UI panels / statusline
  fg             = "#C5C6C7", -- main text
  muted          = "#6C567B", -- comments, dim text

  transparent = nil,

  -- Mall-goth primaries
  neon_green     = "#00FF9C", -- keywords, accents
  cursor_glow    = "#39FF14", -- optional cursor color
  electric_violet= "#A855F7", -- strings, selections, accents
  acid_teal      = "#1AFFD5", -- functions, special
  pale_lilac     = "#C084FC", -- variables, identifiers

  -- Misc colors
  neon_cyan = "#00E5FF",
  toxic_aqua = "#3DFFDB",
  glacial_mint = "#5BFFB0",
  hyper_blue = "#1BC4FF",
  lurid_seafoam = "#44FFC7",

  violent_violet = "#9D4EDD",
  haunted_lavender = "#B388EB",
  ecto_magenta = "#E500FF",

  slime_green = "#7FFF00",
  biohazard_lime = "#ADFF2F",

  -- Alerts / emphasis
  rose_red       = "#FF4D6D", -- numbers, constants
  harsh_magenta  = "#FF006F", -- errors
  sickly_yellow  = "#FFD93D", -- hints / info

  -- UI states
  line_focus     = "#1A0B1E", -- CursorLine
  visual_bg      = "#113322", -- Visual
  search_bg      = "#5A189A", -- Search highlight
  search_fg      = "#000000", -- Search text

  -- Diff
  diff_add       = "#556B2F",
  diff_remove    = "#4B0082",
  diff_change    = "#800020",
}

return P

