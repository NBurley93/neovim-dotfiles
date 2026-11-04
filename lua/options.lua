-- Navigation (searches are case-sensitive):
--   /SECTION:   jump between the blocks of this file
--   /OPT:       jump between the option groups

-- SECTION: Leader keys
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

local INDENT_SIZE = 2

return {
  config = function()
    -- SECTION: Options
    local options = {
      -- OPT: Timing
      updatetime = 50,
      timeout = true,
      timeoutlen = 1000,

      -- OPT: Window title
      title = true,
      titlestring = '%F - Nvim',

      -- OPT: Indentation
      expandtab = true,
      smartindent = true,
      shiftwidth = INDENT_SIZE,
      tabstop = INDENT_SIZE,
      softtabstop = INDENT_SIZE,

      -- OPT: Input & clipboard
      mouse = 'a',
      clipboard = 'unnamedplus',

      -- OPT: Line numbers & sign column
      number = true,
      relativenumber = true,
      signcolumn = 'auto:2',

      -- OPT: Cursor & scrolling
      cursorline = true,
      guicursor = 'n-v-c-sm:block,i-ci-ve:ver25,r-cr-o:hor20',
      scrolloff = 8,

      -- OPT: Display
      termguicolors = true,
      showmode = false,
      cmdheight = 0,
      fillchars = {
        eob = ' ',
        foldopen = '\u{f078}', -- nf-fa-chevron_down
        foldsep = ' ',
        foldclose = '\u{f054}', -- nf-fa-chevron_right
      },

      -- OPT: Line wrapping
      wrap = false,
      breakindent = true,

      -- OPT: Whitespace characters
      list = true,
      listchars = {
        tab = '▏ ',
        leadmultispace = '▏ ',
        multispace = '▏ ',
        trail = '·',
        nbsp = '␣',
      },

      -- OPT: Search & substitute
      inccommand = 'split',
      gdefault = true,

      -- OPT: Completion & popup menu
      completeopt = 'menu,menuone,noselect',
      pumblend = 15,

      -- OPT: Splits
      splitright = true,
      splitbelow = true,

      -- OPT: Folds
      foldcolumn = '1',
      foldlevel = 99,
      foldlevelstart = -1,

      -- OPT: Files, undo & history
      swapfile = false,
      backup = false,
      undofile = true,
      history = 10000,
      fileformats = { 'unix', 'dos' },

      -- OPT: Diff
      diffopt = {
        'internal',
        'filler',
        'closeoff',
        'context:12',
        'algorithm:histogram',
        'linematch:200',
        'indent-heuristic',
        'iwhite',
      },
    }

    for k, v in pairs(options) do
      vim.opt[k] = v
    end

    -- OPT: Filename characters (appends to the default, so it can't live in the table)
    vim.opt.isfname:append('@-@')

    -- SECTION: Platform detection
    local isWindows = vim.fn.has('win32') == 1
    local isWSL = vim.fn.has('wsl') == 1

    -- SECTION: WSL clipboard
    if isWSL then
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

    -- SECTION: Shell
    if isWindows then
      local powershell_options = {
        shell = vim.fn.executable('pwsh') == 1 and 'pwsh' or 'powershell',
        shellcmdflag = '-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.Encoding]::UTF8;',
        shellredir = '2>&1 | %%{ "$_" } | Out-File %s; exit $LastExitCode',
        shellpipe = '2>&1 | %%{ "$_" } | Out-File %s; exit $LastExitCode',
        shellquote = '',
        shellxquote = '',
      }

      for option, value in pairs(powershell_options) do
        vim.opt[option] = value
      end
    elseif vim.fn.executable('zsh') == 1 then
      vim.opt.shell = 'zsh'
    end

    -- SECTION: Providers & native libraries
    local get_python_host = function()
      if isWindows then
        return 'python.exe'
      else
        return 'python3'
      end
    end

    local get_sqlite_path = function()
      if isWindows then
        return vim.fn.stdpath('data') .. '/sqlite3.dll'
      else
        return ''
      end
    end

    vim.g.python3_host_prog = get_python_host()
    vim.g.sqlite_clib_path = get_sqlite_path()

    vim.g.loaded_perl_provider = 0
    vim.g.loaded_ruby_provider = 0
  end,
}
