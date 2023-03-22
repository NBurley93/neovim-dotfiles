local options = {
    autoindent = true,
    encoding = 'UTF-8',
    updatetime = 300,
    expandtab = true,
    autoindent = true,
    shiftwidth = 4,
    tabstop = 4,
    smartindent = true,
    number = true,
    relativenumber = false,
    signcolumn = 'yes',
    clipboard = 'unnamedplus'
}

for k, v in pairs(options) do
    vim.opt[k] = v
end
