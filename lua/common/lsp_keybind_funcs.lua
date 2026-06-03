local M = {}

function M.cmake_generate_and_build()
  vim.cmd.new()
  vim.cmd.term()
  vim.cmd.wincmd('J')
  vim.api.nvim_win_set_height(0, math.floor(vim.o.lines * 0.4))

  local job_id = vim.bo.channel
  vim.fn.chansend(job_id, { 'cmake -S . -B build -DCMAKE_BUILD_TYPE=Debug && cmake --build build --config Debug\r\n' })
end

return M
