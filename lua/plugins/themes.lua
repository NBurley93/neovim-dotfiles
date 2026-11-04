local USE_DEV = os.getenv('USE_DEV') == 'true'

-- Neo-Gotham: black and steel, with red reserved for chrome and keywords
local NEOGOTHAM = {
  bg = '#08080a',
  bg_dark = '#050506',
  bg_light = '#1f1215', -- cursorline and selections
  fg = '#e8e6e3',
  fg_dim = '#b9b7b4',

  orange = '#e0112b', -- crimson: titles, cursor, statusline
  yellow = '#ff3b4e', -- neon red: keywords, search, directories
  magenta = '#c25a6b', -- oxblood: operators, punctuation, macros
  red = '#ff2e7e', -- hot pink: errors and deletions, so they stand out from keywords
  peach = '#ff8f70', -- ember: numbers and constants
  cream = '#d9d2c5',

  blue = '#8fa3b8', -- steel: functions
  blue_light = '#c5ced8', -- pale steel: types and properties
  blue_dark = '#7a7f88', -- line numbers and modules

  green = '#4fb286',
  gray = '#80848c',
  gray_dark = '#45474d',
  gray_darker = '#2a1a1e',
  black = '#0e0e10',

  diff_add = '#0f2a1e',
  diff_delete = '#3a0f18',
  diff_change = '#1c1c24',
  diff_text = '#30303c',
}

-- Duskhaven shares colors between these roles, which an all-red palette would blur together
local function neogotham_overrides()
  local overrides = {}
  local function set(groups, hl)
    for _, group in ipairs(groups) do
      overrides[group] = hl
    end
  end

  set({
    'Identifier',
    '@variable',
    '@variable.builtin',
    '@variable.parameter.builtin',
    '@lsp.type.variable',
    '@lsp.type.parameter',
    'BlinkCmpKindVariable',
  }, { fg = NEOGOTHAM.fg })
  set({ 'String', 'Character', '@string', '@character', '@lsp.type.string' }, { fg = '#d8b4a8' })
  set({ 'DiagnosticWarn', 'WarningMsg', '@comment.warning' }, { fg = '#ffb000' })
  set({ 'DiagnosticUnderlineWarn' }, { sp = '#ffb000' })
  set({ 'CurSearch' }, { fg = NEOGOTHAM.bg, bg = NEOGOTHAM.fg })
  -- nvim-notify needs a solid color to fade from, and warns when this has none
  set({ 'NotifyBackground' }, { bg = NEOGOTHAM.bg })
  set({
    'FloatBorder',
    'PmenuBorder',
    'BlinkCmpMenuBorder',
    'BlinkCmpDocBorder',
    'BlinkCmpSignatureHelpBorder',
    'LazyBorder',
    'SnacksPickerBorder',
    'SnacksPickerBoxBorder',
    'SnacksPickerListBorder',
    'SnacksPickerPreviewBorder',
    'NoiceCmdlinePopupBorder',
  }, { fg = NEOGOTHAM.orange })

  -- Mason: its bar is MutedBlock while updating and HighlightBlock at 100%
  local on_red = { fg = NEOGOTHAM.bg, bg = NEOGOTHAM.yellow }
  local on_steel = { fg = NEOGOTHAM.bg, bg = NEOGOTHAM.blue }
  local on_oxblood = { fg = NEOGOTHAM.fg, bg = '#7a1f2e' }
  local function bold(hl)
    return vim.tbl_extend('force', hl, { bold = true })
  end
  set({ 'MasonHeader' }, bold({ fg = NEOGOTHAM.bg, bg = NEOGOTHAM.orange }))
  set({ 'MasonHeaderSecondary' }, bold(on_steel))
  set({ 'MasonHighlight' }, { fg = NEOGOTHAM.yellow })
  set({ 'MasonHighlightBlock' }, on_red)
  set({ 'MasonHighlightBlockBold' }, bold(on_red))
  set({ 'MasonHighlightSecondary' }, { fg = NEOGOTHAM.blue })
  set({ 'MasonHighlightBlockSecondary' }, on_steel)
  set({ 'MasonHighlightBlockBoldSecondary' }, bold(on_steel))
  set({ 'MasonMuted' }, { fg = NEOGOTHAM.gray })
  set({ 'MasonMutedBlock' }, on_oxblood)
  set({ 'MasonMutedBlockBold' }, bold(on_oxblood))

  set({ 'LazyProgressDone' }, { fg = NEOGOTHAM.orange })
  set({ 'LazyProgressTodo' }, { fg = NEOGOTHAM.gray_dark })

  return overrides
end

-- Duskhaven builds ANSI colors from its palette, which would turn terminal green into red.
-- Listed in slot order 0-15, keeping each color's meaning for test output, git and so on.
local NEOGOTHAM_TERMINAL = {
  '#0e0e10', -- black
  '#ff3b4e', -- red
  '#4fb286', -- green
  '#ffb000', -- yellow
  '#8fa3b8', -- blue
  '#c25a6b', -- magenta
  '#7fb8c8', -- cyan
  '#b9b7b4', -- white
  '#6b6e75', -- bright black
  '#ff6b78', -- bright red
  '#6fd6a8', -- bright green
  '#ffc94d', -- bright yellow
  '#b4c4d6', -- bright blue
  '#e07a8b', -- bright magenta
  '#a3d4e0', -- bright cyan
  '#e8e6e3', -- bright white
}

return {
  -- { 'catppuccin/nvim', name = 'catppuccin', priority = 1000 },
  { 'NBurley93/girlfailure-goth.nvim', priority = 1000, dev = USE_DEV, lazy = true },
  {
    'kbraggins/duskhaven.nvim',
    priority = 1000,
    lazy = true,
    init = function()
      vim.api.nvim_create_autocmd('ColorScheme', {
        group = vim.api.nvim_create_augroup('neogotham-terminal-colors', { clear = true }),
        pattern = 'duskhaven',
        desc = 'Keep ANSI color meanings in terminal buffers',
        callback = function()
          for slot, color in ipairs(NEOGOTHAM_TERMINAL) do
            vim.g['terminal_color_' .. (slot - 1)] = color
          end
        end,
      })
    end,
    opts = {
      transparent = true,
      palette = NEOGOTHAM,
      highlight_overrides = neogotham_overrides(),
    },
    config = function(_, opts)
      require('duskhaven').setup(opts)
    end,
  },
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
