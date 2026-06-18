local M = {}

M.configure_lazy = function()
  require('lazy').setup('plugins', {
    ui = {
      border = 'rounded',
      icons = {
        cmd = ' ',
        config = '',
        debug = '● ',
        event = ' ',
        favorite = ' ',
        ft = ' ',
        init = ' ',
        import = ' ',
        keys = ' ',
        lazy = '󰒲 ',
        loaded = '●',
        not_loaded = '○',
        plugin = '󰀘 ',
        runtime = ' ',
        require = '󰢱 ',
        source = ' ',
        start = ' ',
        task = '✔ ',
        list = {
          '◆',
          '▶',
          '★',
          '✖',
        },
      },
    },
    checker = { enabled = false },
    change_detection = { notify = false },
    dev = {
      path = '~/Development',
      patterns = {},
      fallback = true,
    },
    performance = {
      cache = { enabled = true },
      rtp = {
        disabled_plugins = {
          'netrwPlugin',
          'tarPlugin',
          'tohtml',
          'tutor',
          'gzip',
          'zipPlugin',
          'matchit',
          'matchparen',
          'osc52',
          'shada',
          'man',
          'spec',
          'net',
          'spellfile',
          'rplugin',
        },
      },
    },
  })
end

M.configure_lsps = function(log_level)
  require('common.lsp_backend').setup(log_level)
end

M.configure_autocmds = function()
  require('autocommands').config()
end

M.configure_neovim_options = function()
  require('options').config()
end

M.configure_keymaps = function()
  require('mappings').config()
end

return M
