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
            NormalDark = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m3 },

            -- Backgrounds are cleared by the transparent-floats autocommand
            LazyNormal = { fg = theme.ui.fg_dim },
            MasonNormal = { fg = theme.ui.fg_dim },
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
