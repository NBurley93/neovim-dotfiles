local function helpers()
  -- Scroll pages with the cursor on the center of the page
  vim.keymap.set('n', '<C-d>', '<C-d>zz')
  vim.keymap.set('n', '<C-u>', '<C-u>zz')

  -- Reconfigure search next & prev to center the find result on the screen
  vim.keymap.set('n', 'n', 'nzzzv')
  vim.keymap.set('n', 'N', 'Nzzzv')

  -- Preserve visual selection when indenting
  vim.keymap.set('v', '>', '>gv')
  vim.keymap.set('v', '<', '<gv')

  -- Shortcut to exit insert mode
  vim.keymap.set('i', '<C-c>', '<Esc>', { desc = 'Exit insert mode' })

  -- Allow clearing of highlights from search with Esc
  vim.keymap.set('n', '<Esc>', vim.cmd.nohlsearch, { desc = 'Clear search highlight' })
end

local function misc_binds()
  local commonfuncs = require('common.functions')

  -- Write without autocmds
  -- (useful for things like git commit messages where we don't want linting or formatting to run)
  vim.keymap.set('n', '<leader>wr', function()
    commonfuncs.attempt_write(function()
      vim.cmd('noa w')
    end)
  end, { desc = 'Write buffer without running autocmds (raw)' })
end

-- Keymaps meant to help select portions of text
local function selection_helpers()
  vim.keymap.set('n', '<leader>L', 'vg_', { desc = 'Select to EoL' })

  vim.keymap.set('n', '<leader>sa', 'ggVG', { desc = 'Select entire buffer' })
end

local function navigation_and_editing()
  -- Window navigation
  vim.keymap.set('n', '<A-h>', function()
    vim.cmd.wincmd('H')
  end, { desc = 'Move focus to left window' })

  vim.keymap.set('n', '<A-j>', function()
    vim.cmd.wincmd('J')
  end, { desc = 'Move focus to below window' })

  vim.keymap.set('n', '<A-k>', function()
    vim.cmd.wincmd('K')
  end, { desc = 'Move focus to above window' })

  vim.keymap.set('n', '<A-l>', function()
    vim.cmd.wincmd('L')
  end, { desc = 'Move focus to right window' })

  -- Window pane splits
  vim.keymap.set('n', '<A-->', function()
    vim.cmd.new()
  end, { desc = 'Create horizontal split' })

  vim.keymap.set('n', '<A-\\>', function()
    vim.cmd.vnew()
  end, { desc = 'Create vertical split' })

  -- Quickly navigate to start of line
  vim.keymap.set('n', '<BS>', '^', { desc = 'Quickly move the cursor to the start of the line' })

  -- The BEST remap ever!!!
  vim.keymap.set('x', '<leader>p', [["_dP]], { desc = 'Put without replacing paste buffer' })

  -- Allow us to move a line of code up or down using visual mode (SUPER USEFUL!!)
  vim.keymap.set('v', 'K', ':m \'>-2<CR>gv=gv', { desc = 'Move current line up' })
  vim.keymap.set('v', 'J', ':m \'>+1<CR>gv=gv', { desc = 'Move current line down' })
end

local function plugin_ext()
  vim.keymap.set('n', '<leader>ll', vim.cmd.Lazy, { desc = 'Open Lazy' })
end

local function pane_section(horizontal_or_vertical, split_portion)
  return math.floor((horizontal_or_vertical == 'horizontal' and vim.o.lines or vim.o.columns) * split_portion)
end

local function split_term(horizontal_or_vertical)
  if horizontal_or_vertical == 'horizontal' then
    return function()
      vim.cmd.new()
      vim.cmd.term()
      vim.cmd.wincmd('J')
      vim.api.nvim_win_set_height(0, pane_section(horizontal_or_vertical, 0.4))
    end
  else
    return function()
      vim.cmd.vnew()
      vim.cmd.term()
      vim.cmd.wincmd('L')
      vim.api.nvim_win_set_height(0, pane_section(horizontal_or_vertical, 0.4))
    end
  end
end

local function terminal_ops()
  -- Terminal splits
  -- Horizontal split
  vim.keymap.set('n', '<leader>Tsh', split_term('horizontal'), { desc = 'Open terminal in horizontal split' })

  -- Vertical split
  vim.keymap.set('n', '<leader>Tsv', split_term('vertical'), { desc = 'Open terminal in vertical split' })
end

return {
  config = function()
    helpers()
    misc_binds()
    plugin_ext()
    navigation_and_editing()
    terminal_ops()
    selection_helpers()
  end,
}
