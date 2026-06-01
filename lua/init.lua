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
      path = '~/neovim-projects',
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
  local commonfuncs = require('common.functions')
  -- Scroll pages with the cursor on the center of the page
  vim.keymap.set('n', '<C-d>', '<C-d>zz')
  vim.keymap.set('n', '<C-u>', '<C-u>zz')

  -- Reconfigure search next & prev to center the find result on the screen
  vim.keymap.set('n', 'n', 'nzzzv')
  vim.keymap.set('n', 'N', 'Nzzzv')

  -- Preserve visual selection when indenting
  vim.keymap.set('v', '>', '>gv')
  vim.keymap.set('v', '<', '<gv')

  -- Bindings to allow us to append/prepend to a word
  vim.keymap.set('n', '<leader>wa', 'ea', { desc = 'Append to word' })
  vim.keymap.set('n', '<leader>wp', 'wbi', { desc = 'Prepend to word' })

  -- Write without autocmds
  -- (useful for things like git commit messages where we don't want linting or formatting to run)
  vim.keymap.set('n', '<leader>wr', function()
    commonfuncs.attempt_write(function()
      vim.cmd('noa w')
    end)
  end, { desc = 'Write buffer without running autocmds (raw)' })

  vim.keymap.set('n', '<leader>ll', vim.cmd.Lazy, { desc = 'Open Lazy' })

  vim.keymap.set('n', '<Esc>', vim.cmd.nohlsearch, { desc = 'Clear search highlight' })

  -- Window navigation
  vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to left window' })
  vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to lower window' })
  vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to upper window' })
  vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to right window' })

  -- Allow us to move a line of code up or down using visual mode (SUPER USEFUL!!)
  vim.keymap.set('v', 'K', ':m \'>-2<CR>gv=gv', { desc = 'Move current line up' })
  vim.keymap.set('v', 'J', ':m \'>+1<CR>gv=gv', { desc = 'Move current line down' })

  -- Shortcut to exit insert mode
  vim.keymap.set('i', '<C-c>', '<Esc>', { desc = 'Exit insert mode' })

  -- The BEST remap ever!!!
  vim.keymap.set('x', '<leader>p', [["_dP]], { desc = 'Put without replacing paste buffer' })
end

return M
