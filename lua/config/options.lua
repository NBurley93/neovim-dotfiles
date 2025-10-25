-- Set <leader> to <Space>
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

return {
  config = function()
    local options = {
      autoindent = true,
      updatetime = 50,
      timeout = true,
      timeoutlen = 1000,
      expandtab = true,
      title = true,
      shiftwidth = 4,
      tabstop = 4,
      history = 10000,
      backspace = 'indent,eol,start',
      smartindent = true,
      number = true,
      showmode = false,
      cmdheight = 0,
      breakindent = true,
      mouse = 'a',
      relativenumber = true,
      signcolumn = 'yes:2',
      clipboard = 'unnamedplus',
      termguicolors = true,
      cursorline = true,
      guicursor = 'n-v-c-sm:block,i-ci-ve:ver25,r-cr-o:hor20',
      completeopt = 'menu,menuone,noselect',
      wrap = false,
      swapfile = false,
      backup = false,
      hlsearch = true,
      incsearch = true,
      foldcolumn = '1',
      foldenable = true,
      foldlevel = 99,
      foldlevelstart = -1,
      inccommand = 'split',
      scrolloff = 8,
      list = true,
      listchars = {
        tab = '» ',
        trail = '·',
        nbsp = '␣',
      },
      gdefault = true,
      pumblend = 15,
      splitright = true,
      splitbelow = true,
      fillchars = { eob = ' ', foldopen = '', foldsep = ' ', foldclose = '' },
    }

    for k, v in pairs(options) do
      vim.opt[k] = v
    end
    vim.opt.isfname:append '@-@'

    vim.lsp.set_log_level 'off'

    local isWindows = vim.fn.has 'win32' == 1
    local isWSL = vim.fn.has 'wsl' == 1
    local isWSLWindows = (isWindows and isWSL)
    local isWindowsNative = (isWindows and isWSL == false)

    if isWSLWindows then
      -- MUCH better clipboard
      vim.g.clipboard = {
        name = 'xclip-wsl',
        copy = {
          ['+'] = { 'xclip', '-quiet', '-i', '-selection', 'clipboard' },
          ['*'] = { 'xclip', '-quiet', '-i', '-selection', 'primary' },
        },
        paste = {
          ['+'] = { 'xclip', '-o', '-selection', 'clipboard' },
          ['*'] = { 'xclip', '-o', '-selection', 'primary' },
        },
        cache_enabled = 1,
      }
    end

    if isWindowsNative then
      local powershell_options = {
        shell = vim.fn.executable 'pwsh' == 1 and 'pwsh' or 'powershell',
        shellcmdflag = '-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.Encoding]::UTF8;',
        shellredir = '-RedirectStandardOutput %s -NoNewWindow -Wait',
        shellpipe = '2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode',
        shellquote = '',
        shellxquote = '',
      }

      for option, value in pairs(powershell_options) do
        vim.opt[option] = value
      end
    else
      local shell_options = {
        shell = vim.fn.executable 'zsh' == 1 and 'zsh',
      }

      for option, value in pairs(shell_options) do
        vim.opt[option] = value
      end
    end

    local get_python_host = function()
      if isWindows then
        return 'python.exe'
      else
        return 'python3'
      end
    end

    local get_sqlite_path = function()
      if isWindows then
        return vim.fn.stdpath 'data' .. '/sqlite3.dll'
      else
        return ''
      end
    end

    vim.g.python3_host_prog = get_python_host()
    vim.g.sqlite_clib_path = get_sqlite_path()

    -- Misc provider vars
    vim.g.loaded_perl_provider = 0
    vim.g.loaded_ruby_provider = 0

    vim.g.copilot_proxy_strict_ssl = false
  end,
}
