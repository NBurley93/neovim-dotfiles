local M = {}

-- Helper function to set LSP-related keymaps with a consistent description prefix.
---@param keys string The key sequence to map (e.g., 'gd' for "go
---@param func function The function to execute when the keys are pressed
---@param bufnr number The buffer number to set the keymap for
---@param desc string A description of the keymap action, which will be prefixed with "LSP: " for clarity in which-key and other keymap displays.
function M.lsp_map(keys, func, bufnr, desc)
  vim.keymap.set('n', keys, func, { buffer = bufnr, desc = 'LSP: ' .. desc })
end

-- Baseline on_attach function to set up common LSP keymaps and features for all servers.
-- Servers can extend this baseline with their own on_attach logic using lsp_extend_baseline_onattach.
---@param client vim.lsp.Client
---@param bufnr number
function M.lsp_onattach_baseline(client, bufnr)
  M.lsp_map('gd', function()
    vim.cmd('Glance definitions')
  end, bufnr, 'View definitions')
  M.lsp_map('gr', function()
    vim.cmd('Glance references')
  end, bufnr, 'View references')

  M.lsp_map('<leader>ds', function()
    require('telescope.builtin').lsp_document_symbols()
  end, bufnr, 'View [D]ocument [S]ymbols')

  if client.server_capabilities.hoverProvider then
    M.lsp_map('K', function()
      require('pretty_hover').hover()
    end, bufnr, 'Hover LSP Docs')
  end

  if client.server_capabilities.codeActionProvider then
    M.lsp_map('<leader>ca', vim.lsp.buf.code_action, bufnr, 'Code actions')
  end

  if client.server_capabilities.renameProvider then
    M.lsp_map('<leader>rn', vim.lsp.buf.rename, bufnr, 'Rename symbol')
  end
end

-- A helper to extend the baseline on_attach with additional server-specific logic, so that all servers get the baseline keymaps and features,
-- but can also add their own custom on_attach logic without needing to repeat the baseline setup.
---@param func fun(client: vim.lsp.Client, bufnr: number)
function M.lsp_extend_baseline_onattach(func)
  return function(client, bufnr)
    M.lsp_onattach_baseline(client, bufnr)
    func(client, bufnr)
  end
end

-- Sets the logging level for the LSP client.
---@param log_level string The desired log level (e.g., "trace", "debug", "info", "warn", "error")
function M.set_logging_level(log_level)
  vim.lsp.log.set_level(log_level) -- options: "trace", "debug", "info", "warn", "error"
end

-- Sets up LSP servers by auto-discovering configuration files in lua/lsp/*.lua and applying a baseline on_attach.
---@param log_level string The desired log level for LSP logging (e.g., "trace", "debug", "info", "warn", "error")
function M.setup(log_level)
  -- Auto-discover all server config files under lua/lsp/*.lua
  local lsp_dir = vim.fn.stdpath('config') .. '/lua/lsp'
  local files = vim.fn.globpath(lsp_dir, '*.lua', false, true)

  for _, filepath in ipairs(files) do
    -- Derive the server name from the filename (strip path and .lua extension)
    local server_name = vim.fn.fnamemodify(filepath, ':t:r')
    ---@type vim.lsp.Config
    local config = require('lsp.' .. server_name)

    -- Apply default on_attach if the server config doesn't define its own
    if not config.on_attach then
      config.on_attach = M.lsp_onattach_baseline
    end

    -- Wrap on_init to defer blink.cmp capability resolution until the server
    -- starts, so blink does not need to load at startup
    local user_on_init = config.on_init
    local base_caps = config.capabilities
    config.capabilities = nil
    config.on_init = function(client, ...)
      client.config.capabilities = require('blink.cmp').get_lsp_capabilities(base_caps)
      if user_on_init then
        return user_on_init(client, ...)
      end
    end

    -- On Windows, Mason exposes binaries as .cmd shims which Neovim's
    -- vim.fn.executable() does not consider executable. Find the real .exe
    -- by scanning the Mason packages directory for a matching binary.
    if vim.fn.has('win32') == 1 and config.cmd and type(config.cmd[1]) == 'string' then
      local exe = config.cmd[1]
      if not exe:match('[\\/]') and not exe:match('%.exe$') then
        local shim = vim.fn.stdpath('data') .. '/mason/bin/' .. exe .. '.cmd'
        if vim.fn.filereadable(shim) == 1 then
          local mason_bin = vim.fn.stdpath('data') .. '/mason/bin'
          -- Read shim, replace %dp0% with the actual mason/bin path, normalise slashes
          local content = table.concat(vim.fn.readfile(shim), '\n')
          local rel = content:match('"%%dp0%%\\([^"]+%.exe)"')
          if rel then
            local real_exe = vim.fn.simplify(mason_bin .. '/' .. rel:gsub('\\', '/'))
            -- Normalise to backslashes for Windows executable resolution
            real_exe = real_exe:gsub('/', '\\')
            if vim.fn.filereadable(real_exe) == 1 then
              config.cmd[1] = real_exe
            end
          end
        end
      end
    end

    vim.lsp.config(server_name, config)
    vim.lsp.enable(server_name)
  end

  vim.diagnostic.config({
    signs = require('common.defines').DIAGNOSTIC_SIGNS,
  })

  M.set_logging_level(log_level or 'warn')
end

return M
