local function diffview_toggle()
  local lib = require('diffview.lib')
  local view = lib.get_current_view()
  if view then
    vim.cmd.DiffviewClose()
  else
    vim.cmd.DiffviewOpen()
  end
end

return {
  config = function()
    local neogit = require('neogit')

    vim.keymap.set('n', '<leader>gs', function()
      neogit.open({ kind = 'split_below_all' })
    end, { desc = 'View Git status' })
    vim.keymap.set('n', '<c-g>', function()
      neogit.open({ kind = 'split_below_all' })
    end, { desc = 'View Git status' })
    vim.keymap.set('n', '<leader>dr', diffview_toggle, { desc = 'Review diffs in diffview' })
    vim.keymap.set('n', '<c-r>', diffview_toggle, { desc = 'Review diffs in diffview' })
    vim.keymap.set('n', '<leader>dh', vim.cmd.DiffviewFileHistory, { desc = 'Opens the git file history view' })
  end,
}
