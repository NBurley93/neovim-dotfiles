local USE_DEV = os.getenv('USE_DEV') == 'true'

return {
  -- { 'catppuccin/nvim', name = 'catppuccin', priority = 1000 },
  { 'NBurley93/girlfailure-goth.nvim', priority = 1000, dev = USE_DEV, lazy = true },
  {
    'rebelot/kanagawa.nvim',
    priority = 1000,
    lazy = true,
    config = function()
      require('kanagawa').setup({
        transparent = true,
        dimInactive = false,
        theme = 'dragon',
        overrides = function(colors)
          local theme = colors.theme
          return {
            NormalFloat = { bg = 'none' },
            FloatBorder = { bg = 'none' },
            FloatTitle = { bg = 'none' },

            SnacksPickerTitle = { fg = theme.ui.special, bold = true },
            SnacksPickerInput = { bg = theme.ui.bg_p1 },
            SnacksPickerInputBorder = { fg = theme.ui.bg_p1, bg = theme.ui.bg_p1 },
            SnacksPickerList = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m1 },
            SnacksPickerListBorder = { fg = theme.ui.bg_m1, bg = theme.ui.bg_m1 },
            SnacksPickerPreview = { bg = theme.ui.bg_dim },
            SnacksPickerPreviewBorder = { bg = theme.ui.bg_dim, fg = theme.ui.bg_dim },

            NormalDark = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m3 },

            LazyNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },
            MasonNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },
          }
        end,
        colors = {
          theme = {
            all = {
              ui = {
                bg_gutter = 'none',
              },
            },
          },
        },
      })
    end,
  },
}
