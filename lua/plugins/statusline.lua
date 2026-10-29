-- Created on first use: trouble.nvim lazy-loads on LspAttach, so breadcrumbs appear once an LSP attaches
local trouble_symbols

local function breadcrumbs()
  if not trouble_symbols then
    if not package.loaded.trouble then
      return ''
    end
    trouble_symbols = require('trouble').statusline({
      mode = 'lsp_document_symbols',
      groups = {},
      title = false,
      filter = { range = true },
      format = '{kind_icon}{symbol.name:Normal}',
      hl_group = 'lualine_c_normal',
    })
  end
  return trouble_symbols.has() and trouble_symbols.get() or ''
end

-- diffview labels its diff windows (OURS / THEIRS / BASE / LOCAL / WORKING TREE / INDEX), but lualine
-- redraws every window's winbar and would hide them, so look the label up and draw it ourselves
local function diffview_label()
  if not package.loaded.diffview then
    return nil
  end
  local view = require('diffview.lib').get_current_view()
  local layout = view and view.cur_layout
  if not layout then
    return nil
  end
  local win = vim.api.nvim_get_current_win()
  for _, layout_win in ipairs(layout.windows) do
    if layout_win.id == win and layout_win.file then
      return layout_win.file.winbar
    end
  end
end

-- One highlight group per side, so ours and theirs are told apart at a glance: { role, group, color source }.
-- Embedded in the text because lualine shares a single highlight per component across all windows.
local diffview_label_roles = {
  { 'OURS', 'DiffviewLabelOurs', 'DiagnosticOk' },
  { 'THEIRS', 'DiffviewLabelTheirs', 'DiagnosticInfo' },
  { 'BASE', 'DiffviewLabelBase', 'DiagnosticHint' },
  { 'LOCAL', 'DiffviewLabelLocal', 'DiagnosticWarn' },
  { 'WORKING TREE', 'DiffviewLabelLocal', 'DiagnosticWarn' },
}

-- Labels are drawn as badges (role colour as background) so lualine's section separator blends into them
local function define_diffview_label_hls()
  local function attr(name, key)
    return vim.api.nvim_get_hl(0, { name = name, link = false })[key]
  end
  local bar_bg = attr('StatusLine', 'bg')
  local badge_fg = attr('Normal', 'bg') or bar_bg or 0
  for _, role in ipairs(diffview_label_roles) do
    vim.api.nvim_set_hl(0, role[2], { fg = badge_fg, bg = attr(role[3], 'fg'), bold = true })
  end
  vim.api.nvim_set_hl(0, 'DiffviewLabel', { fg = attr('Normal', 'fg'), bg = bar_bg, bold = true })
end

vim.api.nvim_create_autocmd('ColorScheme', {
  group = vim.api.nvim_create_augroup('statusline_diffview_labels', { clear = true }),
  callback = define_diffview_label_hls,
})

local function diffview_winbar()
  local label = diffview_label()
  if not label then
    return ''
  end
  for _, role in ipairs(diffview_label_roles) do
    local _, role_end = label:find(role[1], 1, true)
    if role_end then
      -- Truncate after the role and its "(Current changes)" note, so a narrow window loses the hash, not the side
      local cut = select(2, label:find('^%s*%b()', role_end + 1)) or role_end
      return '%#' .. role[2] .. '#' .. label:sub(1, cut) .. '%<' .. label:sub(cut + 1) .. ' '
    end
  end
  return '%#DiffviewLabel#' .. label .. ' '
end

local function not_diffview()
  return diffview_label() == nil
end

-- Reuse gitsigns' hunk counts instead of having lualine run its own git diff
local function gitsigns_diff()
  local status = vim.b.gitsigns_status_dict
  if status then
    return { added = status.added, modified = status.changed, removed = status.removed }
  end
end

local function lsp_clients()
  local names = vim.tbl_map(function(client)
    return client.name
  end, vim.lsp.get_clients({ bufnr = 0 }))
  return table.concat(names, ' ')
end

-- Running and failed overseer tasks; overseer is lazy-loaded, so show nothing until it is
local function overseer_tasks()
  if not package.loaded.overseer then
    return ''
  end
  local overseer = require('overseer')
  local running, failed = 0, 0
  for _, task in ipairs(overseer.list_tasks()) do
    if task.status == overseer.STATUS.RUNNING then
      running = running + 1
    elseif task.status == overseer.STATUS.FAILURE then
      failed = failed + 1
    end
  end
  local parts = {}
  if running > 0 then
    table.insert(parts, '\u{f046e} ' .. running)
  end
  if failed > 0 then
    table.insert(parts, '\u{f015a} ' .. failed)
  end
  return table.concat(parts, ' ')
end

local function setup_line_segments()
  return {
    lualine_a = {
      {
        'mode',
        icons_enabled = true,
        fmt = function(str)
          if str == 'V-BLOCK' then
            return 'V-B'
          elseif str == 'V-LINE' then
            return 'V-L'
          elseif str == 'NORMAL' then
            return 'NRM'
          elseif str == 'INSERT' then
            return 'INS'
          elseif str == 'VISUAL' then
            return 'VIS'
          else
            return str:sub(1, 3):upper()
          end
        end,
      },
    },
    lualine_b = {
      {
        function()
          return require('noice').api.statusline.mode.get()
        end,
        cond = function()
          return require('noice').api.statusline.mode.has()
        end,
      },
      {
        'b:gitsigns_head',
        icon = '',
      },
      {
        'diff',
        source = gitsigns_diff,
        colored = true,
        symbols = {
          added = ' ',
          modified = ' ',
          removed = ' ',
        },
      },
      {
        'filename',
        file_status = false,
        newfile_status = false,
        path = 1,
        symbols = {
          modified = '●',
          readonly = '',
          unnamed = '[No Name]',
          newfile = '[New]',
        },
      },
      {
        'diagnostics',
        sources = { 'nvim_diagnostic' },
        sections = { 'error', 'warn', 'info', 'hint' },
        symbols = {
          error = ' ',
          warn = ' ',
          info = ' ',
          hint = ' ',
        },
        colored = true,
        update_in_insert = false,
      },
    },
    lualine_c = {
      {
        -- Client names only; fidget.nvim shows progress
        lsp_clients,
        icon = '', -- f013
      },
    },
    lualine_x = {
      {
        function()
          return require('noice').api.status.search.get()
        end,
        cond = function()
          return package.loaded.noice ~= nil and require('noice').api.status.search.has()
        end,
      },
      {
        function()
          return '\u{f188} ' .. require('dap').status()
        end,
        cond = function()
          return package.loaded.dap ~= nil and require('dap').session() ~= nil
        end,
      },
      overseer_tasks,
      {
        'encoding',
        cond = function()
          return vim.bo.fileencoding ~= '' and vim.bo.fileencoding ~= 'utf-8'
        end,
      },
      {
        'fileformat',
        cond = function()
          return vim.bo.fileformat ~= 'unix'
        end,
        symbols = {
          unix = '',
          dos = '',
          mac = '',
        },
      },
      { 'filetype', colored = true },
    },
    lualine_y = { 'progress' },
    lualine_z = { 'location' },
  }
end

local function setup_inactive_segments()
  return {
    lualine_a = { 'filename' },
    lualine_b = {},
    lualine_c = {},
    lualine_x = { 'location' },
    lualine_y = {},
    lualine_z = {},
  }
end

---@param active boolean Show LSP breadcrumbs (they track the current window, so only for the active winbar)
local function setup_winbar_segments(active)
  return {
    lualine_a = {
      {
        'filetype',
        cond = not_diffview,
        colored = false,
        icon_only = true,
        icon = { align = 'right' },
      },
      -- In section a because lualine truncates from the start of section c, which would cut off OURS/THEIRS
      {
        diffview_winbar,
        -- The badge supplies its own spacing; lualine's padding would be drawn in the section colour
        padding = 0,
        cond = function()
          return diffview_label() ~= nil
        end,
      },
    },
    lualine_b = {},
    lualine_c = {
      {
        'filename',
        cond = not_diffview,
        file_status = true,
        newfile_status = true,
        path = 0,
        symbols = {
          modified = '●',
          readonly = '',
          unnamed = '[No Name]',
          newfile = '[New]',
        },
      },
      active and { breadcrumbs } or nil,
    },
    lualine_x = {},
    lualine_y = {},
    lualine_z = {},
  }
end

local function setup_options()
  return {
    icons_enabled = true,
    -- component_separators = { left = "│", right = "│" },
    component_separators = '',
    section_separators = { left = '', right = '' },
    globalstatus = true,
    disabled_filetypes = {
      statusline = {
        'lazy',
        'noice',
        'dashboard',
      },
      winbar = {
        'lazy',
        'noice',
        'oil',
        'DiffviewFiles',
        'dapui_scopes',
        'dapui_watches',
        'dapui_stacks',
        'dapui_breakpoints',
        'dapui_console',
        'dap-repl',
      },
    },
    -- theme = 'girlfailure',
    theme = 'auto',
  }
end

return {
  {
    'nvim-lualine/lualine.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = {
      require('common.defines').WEB_DEVICONS_PROVIDER,
    },
    opts = {
      options = setup_options(),
      sections = setup_line_segments(),
      inactive_sections = setup_inactive_segments(),
      tabline = {},
      winbar = setup_winbar_segments(true),
      inactive_winbar = setup_winbar_segments(false),
      extensions = { 'trouble', 'lazy', 'mason', 'oil' },
      -- theme = 'lflops',
    },
  },
}
