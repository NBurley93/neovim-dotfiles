local USE_DEV = os.getenv('USE_DEV') == 'true'

return {
  -- { 'catppuccin/nvim', name = 'catppuccin', priority = 1000 },
  { 'NBurley93/girlfailure-goth.nvim', priority = 1000, dev = USE_DEV, lazy = true },
}
