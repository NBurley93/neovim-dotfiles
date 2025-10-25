local utils = require 'telescope.utils'
local themes = require 'telescope.themes'

local search_map = function(keys, action, desc)
  vim.keymap.set('n', '<leader>s' .. keys, action, { desc = desc })
end

local M = {}

local function map_builtins()
  local builtin = require 'telescope.builtin'

  -- Files
  vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Find files' })

  -- View keymaps
  vim.keymap.set('n', '<leader>km', builtin.keymaps, { desc = 'View keymaps' })

  -- Search nvim config
  vim.keymap.set('n', 'cf', function()
    builtin.find_files { cwd = vim.fn.stdpath 'config' }
  end, { desc = 'Neovim Config find files' })

  -- Search for a string in files
  vim.keymap.set('n', '<leader>ss', builtin.live_grep, { desc = 'String search' })

  -- Help
  search_map('h', function()
    builtin.help_tags()
  end, 'Search help')

  -- Git
  search_map('gb', function()
    builtin.git_branches(themes.get_dropdown { previewer = false }, { show_remote_tracking_branches = false })
  end, 'Search Branches')
  search_map('gB', function()
    builtin.git_branches(themes.get_dropdown { previewer = false }, { show_remote_tracking_branches = true })
  end, 'Search Git Branches + upstream')

  -- Currently open buffers
  vim.keymap.set('n', '<leader><leader>', function()
    builtin.buffers(themes.get_dropdown { previewer = false }, { sort_lastused = true })
  end, { desc = 'Search Buffers' })
end

local function map_extensions()
  local extensions = require('telescope').extensions

  -- Undo history
  search_map('u', function()
    extensions.undo.undo()
  end, 'Search undo history')

  -- Git branch
  vim.keymap.set({ 'n', 'v' }, '<leader>gb', function()
    require('git_branch').files()
  end, { desc = 'Search for files with diffs in current branch compared to default' })
end

function M.config()
  map_builtins()
  map_extensions()
end

return M
