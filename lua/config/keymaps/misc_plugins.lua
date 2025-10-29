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

local function harpoon_keymaps()
  -- Harpoon
  local harpoon = require('harpoon')
  local commonfuncs = require('common.functions')
  vim.keymap.set('n', '<leader>m', function()
    harpoon:list():add()
    commonfuncs.flashBuffer(vim.api.nvim_get_current_buf(), 150)
    commonfuncs.nvim_notify_info('Added ' .. vim.fs.basename(vim.api.nvim_buf_get_name(0)) .. ' to Harpoon list')
  end, { desc = 'Mark current buffer for Harpoon' })

  vim.keymap.set('n', '<C-S-P>', function()
    harpoon:list():prev()
  end, { desc = 'Goto previous Harpoon buffer' })
  vim.keymap.set('n', '<C-S-N>', function()
    harpoon:list():next()
  end, { desc = 'Goto next Harpoon buffer' })
end

local function rip_sub_keymaps()
  vim.keymap.set({ 'n', 'x' }, '<leader>r', function()
    require('rip-substitute').sub()
  end, { desc = ' rip substitute' })
end

local function flash_keymaps()
  local flash = require('flash')
  vim.keymap.set({ 'n', 'x', 'o' }, 's', function()
    flash.jump()
  end, { desc = 'Flash' })
  vim.keymap.set({ 'n', 'x', 'o' }, 'S', function()
    flash.treesitter()
  end, { desc = 'Flash Treesitter' })
  vim.keymap.set({ 'o' }, 'r', function()
    flash.remote()
  end, { desc = 'Remote Flash' })
  vim.keymap.set({ 'o' }, 'r', function()
    flash.treesitter_search()
  end, { desc = 'Treesitter Search' })
  vim.keymap.set({ 'c' }, '<c-s>', function()
    flash.toggle()
  end, { desc = 'Toggle Flash Search' })
end

return {
  config = function()
    -- Shortcut to exit insert mode
    vim.keymap.set('i', '<C-c>', '<Esc>', { desc = 'Exit insert mode' })

    trouble_keymaps()
    ufo_keymaps()
    oil_keymaps()
    harpoon_keymaps()
    rip_sub_keymaps()
    flash_keymaps()
  end,
}
