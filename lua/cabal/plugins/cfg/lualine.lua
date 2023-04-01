require('lualine').setup {
  options = {
    icons_enabled = true,
    theme = 'auto',
    component_separators = { left = '', right = ''},
    section_separators = { left = '', right = ''},
    globalstatus = true,
    refresh = {
      statusline = 1000,
      tabline = 1000,
      winbar = 1000,
    }
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'branch', 'diff', 'diagnostics'},
    lualine_c = {{
        'buffers',
        show_modified_status = true,
        mode = 2,
        use_mode_colors = true,
        symbols = {
            modified = '*',
            alternate_file = '',
            directory = ''
        }
    }},
    lualine_x = {'encoding', 'fileformat', 'filetype'},
    lualine_y = {'progress'},
    lualine_z = {'location'}
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {'filename'},
    lualine_x = {'location'},
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {
      lualine_a = {},
      lualine_b = {'filename'},
      lualine_c = {},
      lualine_x = {},
      lualine_y = {'filesize'},
      lualine_z = {'tabs'}
  },
  winbar = {},
  inactive_winbar = {},
  extensions = {'fugitive', 'nvim-dap-ui'}
}
