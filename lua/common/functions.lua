local M = {}

M.nvim_notify_warn = function(msg)
  vim.notify(msg, vim.log.levels.WARN)
end

M.nvim_notify_error = function(msg)
  vim.notify(msg, vim.log.levels.ERROR)
end

M.nvim_notify_info = function(msg)
  vim.notify(msg, vim.log.levels.INFO)
end

M.attempt_write = function(write_func)
  local is_modified = vim.api.nvim_buf_get_option(vim.api.nvim_win_get_buf(0), 'readonly')
  if is_modified == false then
    write_func()
  else
    M.nvim_notify_warn 'Cannot write read-only buffer!'
  end
end

M.addKeyToSet = function(set, key)
  set[key] = true
end

M.removeKeyFromSet = function(set, key)
  set[key] = nil
end

M.setContainsKey = function(set, key)
  return set[key] ~= nil
end

M.flashBuffer = function(bufnr, duration)
  bufnr = bufnr or vim.api.nvim_get_current_buf()
  local ns = vim.api.nvim_create_namespace 'BufferFlash'
  local line_count = vim.api.nvim_buf_line_count(bufnr)

  -- Highlight all lines
  for i = 0, line_count - 1 do
    vim.api.nvim_buf_add_highlight(bufnr, ns, 'BufferFlash', i, 0, -1)
  end

  -- Remove highlight after duration
  vim.defer_fn(function()
    vim.api.nvim_buf_clear_namespace(bufnr, ns, 0, -1)
  end, duration or 150)
end

return M
