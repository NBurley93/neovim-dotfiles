return {
  {
    'folke/snacks.nvim',
    priority = 1000,
    lazy = false,
    opts = {
      bigfile = {
        enabled = true,
        size = 1.5 * 1024 * 1024, -- 1.5MB
      },
      quickfile = { enabled = true },
      win = { enabled = true },
    },
  },
}
