
-- lua/colors/mallgoth/plugins/lualine.lua
local P = require("custom_themes/mallgoth.palette")

-- convenience
local function hi(fg, bg, bold)
    return {
        fg = fg,
        bg = bg,
        gui = bold and "bold" or nil
    }
end

-- Mode colors:
-- normal  = neon green
-- insert  = electric violet
-- visual  = acid teal
-- replace = rose red
-- command = sickly yellow
-- terminal= cursor glow
local M = {
  normal = {
    a = hi(P.bg0, P.biohazard_lime, true),
    b = hi(P.fg,  P.bg1),
    c = hi(P.fg,  P.bg0),
  },
  insert = {
    a = hi(P.search_fg, P.violent_violet, true),
    b = hi(P.fg,        P.bg1),
    c = hi(P.fg,        P.bg0),
  },
  visual = {
    a = hi(P.search_fg, P.neon_cyan, true),
    b = hi(P.fg,        P.bg1),
    c = hi(P.fg,        P.bg0),
  },
  replace = {
    a = hi(P.search_fg, P.rose_red, true),
    b = hi(P.fg,        P.bg1),
    c = hi(P.fg,        P.bg0),
  },
  command = {
    a = hi(P.bg0, P.sickly_yellow, true),
    b = hi(P.fg,  P.bg1),
    c = hi(P.fg,  P.bg0),
  },
  terminal = {
    a = hi(P.bg0, P.cursor_glow, true),
    b = hi(P.fg,  P.bg1),
    c = hi(P.fg,  P.bg0),
  },
  inactive = {
    a = hi(P.muted, P.bg1),
    b = hi(P.muted, P.bg1),
    c = hi(P.muted, P.bg0),
  },
}

return M
