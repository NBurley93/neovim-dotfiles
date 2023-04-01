local options = {
    fileformat = 'unix',
    autoindent = true,
    encoding = 'UTF-8',
    updatetime = 300,
    expandtab = true,
    autoindent = true,
    title = true,
    shiftwidth = 4,
    tabstop = 4,
    backspace = 'indent,eol,start',
    smartindent = true,
    number = true,
    relativenumber = false,
    signcolumn = 'yes:1',
    clipboard = 'unnamedplus',
    termguicolors = true,
    cursorline = true,
}

for k, v in pairs(options) do
    vim.opt[k] = v
end

-- Configure python runtime for windows
if (vim.fn.has('win32') or vim.fn.has('win32unix')) then
    vim.g.python3_host_prog = '~\\.pyenv\\pyenv-win\\versions\\3.11.2\\python.exe'
end
