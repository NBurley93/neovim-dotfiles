local function trouble_keymaps()
  -- Trouble
  vim.keymap.set('n', '<leader>t', function()
    vim.cmd.Trouble('diagnostics', 'toggle')
  end, { desc = 'Show [T]rouble menu' })
end

local function ufo_keymaps()
  -- Folds
  vim.keymap.set('n', 'zR', function()
    require('ufo').openAllFolds()
  end, { desc = 'Open all Folds (UFO)' })
  vim.keymap.set('n', 'zM', function()
    require('ufo').closeAllFolds()
  end, { desc = 'Close all Folds (UFO)' })
end

local function oil_keymaps()
  -- Oil
  vim.keymap.set('n', '<leader>pv', function()
    vim.cmd.Oil()
  end, { desc = '[V]iew cwd with Oil' })
end

local function rip_sub_keymaps()
  vim.keymap.set({ 'n', 'x' }, '<leader>sr', function()
    require('rip-substitute').sub()
  end, { desc = ' rip [R]eplace' })
end

local function flash_keymaps()
  vim.keymap.set({ 'n', 'x', 'o' }, 's', function()
    require('flash').jump()
  end, { desc = 'Flash' })
  vim.keymap.set({ 'n', 'x', 'o' }, 'S', function()
    require('flash').treesitter()
  end, { desc = 'Flash Treesitter' })
  vim.keymap.set({ 'o' }, 'r', function()
    require('flash').remote()
  end, { desc = 'Remote Flash' })
  vim.keymap.set({ 'o' }, 'r', function()
    require('flash').treesitter_search()
  end, { desc = 'Treesitter Search' })
  vim.keymap.set({ 'c' }, '<c-s>', function()
    require('flash').toggle()
  end, { desc = 'Toggle Flash Search' })
end

return {
  config = function()
    -- Shortcut to exit insert mode
    vim.keymap.set('i', '<C-c>', '<Esc>', { desc = 'Exit insert mode' })

    trouble_keymaps()
    ufo_keymaps()
    oil_keymaps()
    rip_sub_keymaps()
    flash_keymaps()
  end,
}
