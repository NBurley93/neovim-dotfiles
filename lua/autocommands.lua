local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

local function CustomTSParsers()
  local ts_parser_group = augroup('custom_ts_parsers', { clear = true })

  autocmd('User', {
    pattern = 'TSUpdate',
    group = ts_parser_group,
    callback = function()
      require('nvim-treesitter.parsers').sqf = {
        install_info = {
          url = 'https://github.com/NBurley93/tree-sitter-sqf',
          branch = 'master',
          generate = true,
          generate_from_json = false,
        },
      }
    end,
  })
end

local function TerminalAutocommands()
  local term_group = augroup('custom-terminal-open', { clear = true })

  autocmd('TermOpen', {
    pattern = '*',
    group = term_group,
    desc = 'Set terminal buffer options',
    callback = function(args)
      vim.opt_local.number = false
      vim.opt_local.relativenumber = false
      vim.opt_local.signcolumn = 'no'
      vim.opt_local.cursorline = false
      -- Only when the terminal is in the current window: background terminals (overseer, neotest)
      -- would otherwise drop whatever window you're in into insert mode
      if args.buf == vim.api.nvim_get_current_buf() then
        vim.cmd.startinsert()
      end
    end,
  })
end

-- General editing quality-of-life
local function EditorQoL()
  autocmd({ 'FocusGained', 'BufEnter', 'TermClose', 'TermLeave' }, {
    group = augroup('checktime', { clear = true }),
    desc = 'Reload buffers changed outside of Neovim',
    callback = function()
      -- checktime errors inside the command-line window (E11)
      if vim.o.buftype ~= 'nofile' and vim.fn.getcmdwintype() == '' then
        vim.cmd('checktime')
      end
    end,
  })

  autocmd('BufReadPost', {
    group = augroup('restore-cursor', { clear = true }),
    desc = 'Restore last cursor position',
    callback = function(args)
      if vim.tbl_contains({ 'gitcommit', 'gitrebase' }, vim.bo[args.buf].filetype) then
        return
      end
      local mark = vim.api.nvim_buf_get_mark(args.buf, '"')
      if mark[1] > 0 and mark[1] <= vim.api.nvim_buf_line_count(args.buf) then
        pcall(vim.api.nvim_win_set_cursor, 0, mark)
      end
    end,
  })

  autocmd('BufWritePre', {
    group = augroup('auto-mkdir', { clear = true }),
    desc = 'Create missing parent directories on save',
    callback = function(args)
      -- Skip URL-style buffers (oil://, fugitive://); needs 2+ chars so Windows drives (C:\) still match
      if args.match:match('^%w%w+:[\\/][\\/]') then
        return
      end
      local path = vim.uv.fs_realpath(args.match) or args.match
      vim.fn.mkdir(vim.fn.fnamemodify(path, ':p:h'), 'p')
    end,
  })

  autocmd('FileType', {
    group = augroup('close-with-q', { clear = true }),
    pattern = { 'help', 'qf', 'man', 'checkhealth', 'lspinfo', 'notify', 'startuptime' },
    desc = 'Close helper windows with q',
    callback = function(args)
      vim.bo[args.buf].buflisted = false
      vim.keymap.set('n', 'q', '<Cmd>close<CR>', { buffer = args.buf, silent = true, desc = 'Close window' })
    end,
  })

  autocmd('VimResized', {
    group = augroup('resize-splits', { clear = true }),
    desc = 'Equalize splits when the terminal is resized',
    callback = function()
      local tab = vim.fn.tabpagenr()
      vim.cmd('tabdo wincmd =')
      vim.cmd('tabnext ' .. tab)
    end,
  })

  -- Remember which windows had cursorline, so windows that turn it off (terminals, plugin UIs) stay off
  local cursorline_group = augroup('focused-cursorline', { clear = true })
  autocmd('WinLeave', {
    group = cursorline_group,
    desc = 'Hide cursorline in unfocused windows',
    callback = function()
      if vim.wo.cursorline then
        vim.w.auto_cursorline = true
        vim.wo.cursorline = false
      end
    end,
  })
  autocmd('WinEnter', {
    group = cursorline_group,
    desc = 'Restore cursorline in the focused window',
    callback = function()
      if vim.w.auto_cursorline then
        vim.w.auto_cursorline = nil
        vim.wo.cursorline = true
      end
    end,
  })

  autocmd('FileType', {
    group = augroup('prose', { clear = true }),
    pattern = { 'markdown', 'gitcommit', 'tex', 'plaintex', 'text' },
    desc = 'Wrap and spellcheck prose',
    callback = function()
      vim.opt_local.wrap = true
      vim.opt_local.linebreak = true
      vim.opt_local.spell = true
    end,
  })

  autocmd('CursorMoved', {
    group = augroup('auto-nohlsearch', { clear = true }),
    desc = 'Clear search highlight once the cursor leaves a match',
    callback = function()
      if vim.v.hlsearch == 0 then
        return
      end
      local ok, count = pcall(vim.fn.searchcount, { timeout = 50 })
      if ok and count.exact_match == 0 then
        -- :nohlsearch has no effect when run directly inside an autocommand
        vim.schedule(vim.cmd.nohlsearch)
      end
    end,
  })
end

-- Turns off expensive features for large files so they open without freezing
local function BigFileGuard()
  local bigfile_group = augroup('bigfile', { clear = true })
  local max_size = 1.5 * 1024 * 1024 -- bytes

  autocmd('BufReadPre', {
    group = bigfile_group,
    desc = 'Flag large files',
    callback = function(args)
      local stat = vim.uv.fs_stat(args.match)
      if stat and stat.size > max_size then
        vim.b[args.buf].bigfile = true
        vim.b[args.buf].miniindentscope_disable = true
      end
    end,
  })

  -- Treesitter is started from ftplugins on FileType, so stop it after they've run
  autocmd('FileType', {
    group = bigfile_group,
    desc = 'Disable treesitter, syntax and folds for large files',
    callback = function(args)
      if not vim.b[args.buf].bigfile then
        return
      end
      vim.schedule(function()
        if not vim.api.nvim_buf_is_valid(args.buf) then
          return
        end
        pcall(vim.treesitter.stop, args.buf)
        pcall(function()
          require('ufo').detach(args.buf)
        end)
        vim.bo[args.buf].syntax = 'off'
        for _, win in ipairs(vim.fn.win_findbuf(args.buf)) do
          vim.wo[win].foldmethod = 'manual'
          vim.wo[win].foldenable = false
        end
        vim.notify('Large file: treesitter, syntax, folds and LSP disabled', vim.log.levels.INFO, { title = 'Big file' })
      end)
    end,
  })

  autocmd('LspAttach', {
    group = bigfile_group,
    desc = 'Detach LSP clients from large files',
    callback = function(args)
      if vim.b[args.buf].bigfile then
        vim.schedule(function()
          vim.lsp.buf_detach_client(args.buf, args.data.client_id)
        end)
      end
    end,
  })
end

local function AutofixFiletypeCommands()
  local ft_lsp_group = augroup('ft_lsp_group', { clear = true })

  autocmd({ 'BufReadPost', 'BufNewFile' }, {
    pattern = { 'docker-compose.yml', 'docker-compose.yaml', 'compose.yml', 'compose.yaml' },
    group = ft_lsp_group,
    desc = 'Automatically set docker-compose to use the yaml.docker-compose ft',
    callback = function()
      vim.opt.filetype = 'yaml.docker-compose'
    end,
  })
end

local function AutoformatFTCommands()
  local afmt_group = augroup('autofmt_ft_group', { clear = true })

  autocmd({ 'BufWritePost' }, {
    pattern = { '*.tex' },
    group = afmt_group,
    desc = 'Automatically format LaTex files on save using tex-fmt',
    callback = function()
      local fname = vim.api.nvim_buf_get_name(0)
      local ok, err = pcall(function()
        vim.cmd(':silent !tex-fmt ' .. vim.fn.shellescape(fname))
      end)
      if not ok then
        vim.notify('tex-fmt failed: ' .. err, vim.log.levels.ERROR)
      end
    end,
  })
end

-- Re-locks pipenv whenever we save a Pipfile
local function PipfileUpdate()
  local pipenv_group = augroup('pipenv_auto_update', { clear = true })

  autocmd('BufWritePost', {
    pattern = { 'Pipfile' },
    group = pipenv_group,
    desc = 'Update pipenv lockfile after updating Pipfile',
    callback = function(args)
      local root = vim.fs.dirname(args.match)
      require('overseer')
        .new_task({
          -- Root in the name so `unique` only dedupes saves within the same project
          name = 'Pipenv Lock: ' .. root,
          cmd = { 'pipenv', 'lock' },
          cwd = root,
          components = {
            'on_exit_set_status',
            { 'on_complete_notify', statuses = { 'FAILURE' } },
            { 'on_complete_dispose', require_view = { 'FAILURE' } },
            -- A save during a running lock restarts it instead of queueing another
            'unique',
          },
        })
        :start()
    end,
  })
end

-- Re-runs `mise run configure` (CMake) when build files change or new C/C++ sources appear,
-- so compile_commands.json stays current; clangd reloads it when it changes
local function CMakeAutoConfigure()
  local cmake_group = augroup('cmake_auto_configure', { clear = true })
  local source_patterns = { '*.c', '*.cc', '*.cpp', '*.cxx' }

  -- Root of the mise + CMake project containing `path`, or nil
  local function project_root(path)
    local root = vim.fs.root(path, { 'mise.toml', '.mise.toml' })
    if root and vim.uv.fs_stat(vim.fs.joinpath(root, 'CMakeLists.txt')) then
      return root
    end
  end

  local function configure(path)
    local root = project_root(path)
    if not root then
      return
    end
    require('overseer')
      .new_task({
        name = 'cmake configure (' .. vim.fs.basename(root) .. ')',
        cmd = { 'mise', 'run', 'configure' },
        cwd = root,
        components = {
          'on_exit_set_status',
          { 'on_complete_notify', statuses = { 'FAILURE' } },
          { 'on_complete_dispose', require_view = { 'FAILURE' } },
          -- A save during a running configure restarts it instead of queueing another
          'unique',
        },
      })
      :start()
  end

  local function is_source(path)
    local ext = vim.fn.fnamemodify(path, ':e')
    return vim.tbl_contains(source_patterns, '*.' .. ext)
  end

  autocmd('BufWritePost', {
    pattern = { 'CMakeLists.txt', '*.cmake' },
    group = cmake_group,
    desc = 'Reconfigure CMake after editing build files',
    callback = function(args)
      configure(args.match)
    end,
  })

  -- Sources created in Neovim: reconfigure on their first save (picks up globbed sources)
  autocmd('BufNewFile', {
    pattern = source_patterns,
    group = cmake_group,
    callback = function(args)
      vim.b[args.buf].cmake_new_source = true
    end,
  })

  autocmd('BufWritePost', {
    pattern = source_patterns,
    group = cmake_group,
    desc = 'Reconfigure CMake after saving a new source file',
    callback = function(args)
      if vim.b[args.buf].cmake_new_source then
        vim.b[args.buf].cmake_new_source = nil
        configure(args.match)
      end
    end,
  })

  -- Sources created from oil.nvim exist on disk before they're opened, so BufNewFile never fires
  autocmd('User', {
    pattern = 'OilActionsPost',
    group = cmake_group,
    desc = 'Reconfigure CMake after creating source files in oil',
    callback = function(args)
      if args.data.err then
        return
      end
      for _, action in ipairs(args.data.actions) do
        if action.type == 'create' and action.entry_type == 'file' then
          local _, posix_path = require('oil.util').parse_url(action.url)
          local path = posix_path and require('oil.fs').posix_to_os_path(posix_path)
          if path and is_source(path) then
            configure(path)
            return
          end
        end
      end
    end,
  })
end

-- Nudges toward keybinds: when a `:` command is typed that a normal-mode mapping already runs, say so
local function CommandNudges()
  local nudge_group = augroup('command_nudges', { clear = true })

  local function normalize(cmd)
    return (vim.trim(cmd):gsub('%s+', ' '))
  end

  local function display_lhs(map)
    local lhs = vim.fn.keytrans(map.lhsraw or map.lhs)
    local leader = vim.fn.keytrans(vim.g.mapleader or '\\')
    if lhs:sub(1, #leader) == leader then
      return '<leader>' .. lhs:sub(#leader + 1)
    end
    return lhs
  end

  -- Command a mapping's rhs runs, if it is a plain `<Cmd>X<CR>` or `:X<CR>`
  local function rhs_command(rhs)
    if not rhs then
      return nil
    end
    local cmd = rhs:match('^<[Cc][Mm][Dd]>(.-)<[Cc][Rr]>$') or rhs:match('^:(.-)<[Cc][Rr]>$')
    if cmd then
      cmd = cmd:gsub('^<[Cc]%-[Uu]>', '')
      return normalize(cmd)
    end
  end

  -- Mappings whose rhs is a Lua callback have no rhs to inspect, so they declare the command(s) they
  -- replace in their desc with one or more `[:X]` tags, e.g. desc = 'Open Lazy [:Lazy]'
  local function desc_has_command(desc, cmd)
    if not desc then
      return false
    end
    for tagged in desc:gmatch('%[:(.-)%]') do
      if normalize(tagged) == cmd then
        return true
      end
    end
    return false
  end

  local function find_mapping(cmd)
    -- Buffer-local mappings first so they win over globals
    local maps = vim.list_extend(vim.api.nvim_buf_get_keymap(0, 'n'), vim.api.nvim_get_keymap('n'))
    for _, map in ipairs(maps) do
      if rhs_command(map.rhs) == cmd or desc_has_command(map.desc, cmd) then
        return display_lhs(map)
      end
    end
  end

  autocmd('CmdlineLeave', {
    pattern = ':',
    group = nudge_group,
    desc = 'Suggest the keybind for a command that has one',
    callback = function()
      if vim.v.event.abort then
        return
      end
      local cmd = normalize(vim.fn.getcmdline())
      if cmd == '' then
        return
      end
      -- Look up after the command runs, so lazy-loaded plugins have swapped their stub mappings for real ones
      vim.schedule(function()
        local lhs = find_mapping(cmd)
        if lhs then
          vim.notify(('Use %s instead of :%s'):format(lhs, cmd), vim.log.levels.WARN, { title = 'Command nudge' })
        end
      end)
    end,
  })
end

-- Let the terminal background show through floating windows, whichever colorscheme is active.
-- PmenuSel and PmenuThumb keep their backgrounds so the selection and scrollbar stay visible,
-- and NotifyBackground keeps its own because nvim-notify needs a color to fade from.
local TRANSPARENT_GROUPS = {
  'NormalFloat',
  'FloatBorder',
  'FloatTitle',
  'FloatFooter',
  'Pmenu',
  'PmenuSbar',
  'PmenuKind',
  'PmenuExtra',
  'PmenuMatch',
  'PmenuBorder',
  'BlinkCmpMenu',
  'BlinkCmpMenuBorder',
  'BlinkCmpScrollBarGutter',
  'BlinkCmpDoc',
  'BlinkCmpDocBorder',
  'BlinkCmpDocSeparator',
  'BlinkCmpSignatureHelp',
  'BlinkCmpSignatureHelpBorder',
  'LazyNormal',
  'LazyBorder',
  'MasonNormal',
  'SnacksPicker',
  'SnacksPickerBorder',
  'SnacksPickerBox',
  'SnacksPickerBoxBorder',
  'SnacksPickerInput',
  'SnacksPickerInputBorder',
  'SnacksPickerList',
  'SnacksPickerListBorder',
  'SnacksPickerPreview',
  'SnacksPickerPreviewBorder',
}

local function TransparentFloats()
  autocmd('ColorScheme', {
    group = augroup('transparent-floats', { clear = true }),
    desc = 'Clear floating window backgrounds',
    callback = function()
      for _, group in ipairs(TRANSPARENT_GROUPS) do
        local hl = vim.api.nvim_get_hl(0, { name = group, link = false })
        if next(hl) ~= nil then
          hl.bg = nil
          hl.ctermbg = nil
          vim.api.nvim_set_hl(0, group, hl)
        end
      end
    end,
  })
end

return {
  config = function()
    -- Highlight on yank
    autocmd('TextYankPost', {
      desc = 'Highlight when yanking text',
      group = augroup('highlight-yank', { clear = true }),
      callback = function()
        vim.hl.on_yank({ higroup = 'IncSearch', timeout = 250 })
      end,
    })

    AutofixFiletypeCommands()
    AutoformatFTCommands()
    TerminalAutocommands()
    CustomTSParsers()
    CMakeAutoConfigure()
    PipfileUpdate()
    CommandNudges()
    EditorQoL()
    BigFileGuard()
    TransparentFloats()
  end,
}
