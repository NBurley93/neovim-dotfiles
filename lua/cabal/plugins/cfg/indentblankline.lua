require('indent_blankline').setup {
  space_shar_blankline = " ",
  show_current_context = true,
  show_current_context_start = true,
  use_treesitter = true,
  filetype_exclude = { 'help', 'packer', 'nvimtree', 'dashboard', 'mason' },
}
