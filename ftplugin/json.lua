-- When creating a newline with o, ensure there's a trailing comma on the line
vim.keymap.set('n', 'o', function()
  local line = vim.api.nvim_get_current_line()

  local comma_needed = string.find(line, '[^,{[]$')
  if comma_needed then
    return 'A,<cr>'
  else
    return 'o'
  end
end, { buffer = true, expr = true })
