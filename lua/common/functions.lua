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
  if vim.bo.readonly then
    M.nvim_notify_warn('Cannot write read-only buffer!')
  else
    write_func()
  end
end

return M
