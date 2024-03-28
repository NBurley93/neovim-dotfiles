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

M.mapn = function(keys, action, desc)
	vim.keymap.set("n", keys, action, { desc = desc })
end

M.mapv = function(keys, action, desc)
	vim.keymap.set("v", keys, action, { desc = desc })
end

M.mapx = function(keys, action, desc)
	vim.keymap.set("x", keys, action, { desc = desc })
end

M.attempt_write = function(write_func)
	local is_modified = vim.api.nvim_buf_get_option(vim.api.nvim_win_get_buf(0), "readonly")
	if is_modified == false then
		write_func()
	else
		M.nvim_notify_warn("Cannot write read-only buffer!")
	end
end

return M
