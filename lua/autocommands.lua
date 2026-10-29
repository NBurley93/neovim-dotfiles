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
    callback = function()
      vim.opt_local.number = false
      vim.opt_local.relativenumber = false
      vim.opt_local.signcolumn = 'no'
      vim.opt_local.cursorline = false
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
  end,
}
