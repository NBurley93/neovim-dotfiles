--- @type LazySpec[]
return {
  --- @type LazySpec
  {
    'mfussenegger/nvim-dap',
    event = 'VeryLazy',
    dependencies = {
      'leoluz/nvim-dap-go',
    },
    keys = {
      {
        '<leader>db',
        function()
          require('dap').toggle_breakpoint()
        end,
        desc = 'Toggle Breakpoint',
      },
      {
        '<leader>dB',
        function()
          require('dap').set_breakpoint(vim.fn.input('Breakpoint condition: '))
        end,
        desc = 'Breakpoint Condition',
      },
      {
        '<leader>dc',
        function()
          require('dap').continue()
        end,
        desc = 'Continue',
      },
      {
        '<leader>dC',
        function()
          require('dap').run_to_cursor()
        end,
        desc = 'Run to Cursor',
      },
      {
        '<leader>dT',
        function()
          require('dap').terminate()
        end,
        desc = 'Terminate',
      },
      {
        '<leader>di',
        function()
          require('dap').step_into()
        end,
        desc = 'Step Into',
      },
      {
        '<leader>do',
        function()
          require('dap').step_over()
        end,
        desc = 'Step Over',
      },
      {
        '<leader>dO',
        function()
          require('dap').step_out()
        end,
        desc = 'Step Out',
      },
      {
        '<leader>dl',
        function()
          require('dap').run_last()
        end,
        desc = 'Run Last',
      },
      {
        '<leader>dp',
        function()
          require('dap').pause()
        end,
        desc = 'Pause',
      },
    },
    config = function()
      local dap = require('dap')

      -- Signs
      vim.fn.sign_define('DapBreakpoint', { text = ' ', texthl = 'DiagnosticSignError', linehl = '', numhl = '' })
      vim.fn.sign_define(
        'DapStopped',
        { text = ' ', texthl = 'DiagnosticSignWarn', linehl = 'CursorLine', numhl = '' }
      )
      vim.fn.sign_define(
        'DapBreakpointCondition',
        { text = ' ', texthl = 'DiagnosticSignWarn', linehl = '', numhl = '' }
      )
      vim.fn.sign_define(
        'DapBreakpointRejected',
        { text = ' ', texthl = 'DiagnosticSignHint', linehl = '', numhl = '' }
      )

      -- Python: debugpy-adapter.exe on Windows defaults to socket mode, not stdio.
      -- Use server type so nvim-dap connects via socket to match.
      local is_win = vim.fn.has('win32') == 1
      local mason_pkg = vim.fn.stdpath('data') .. '/mason/packages/debugpy/venv/Scripts/'
      dap.adapters.python = {
        type = 'executable',
        command = mason_pkg .. (is_win and 'debugpy-adapter.exe' or 'debugpy-adapter'),
      }

      -- Resolve the project python for launch configs (pipenv → venv → system)
      local python_bin = is_win and '/Scripts/python.exe' or '/bin/python'
      local function resolve_project_python()
        local pipenv = vim.fn.trim(vim.fn.system('pipenv --venv'))
        if vim.v.shell_error == 0 and pipenv ~= '' then
          return pipenv .. python_bin
        end
        if vim.env.VIRTUAL_ENV and vim.env.VIRTUAL_ENV ~= '' then
          return vim.env.VIRTUAL_ENV .. python_bin
        end
        return vim.fn.exepath('python3') ~= '' and vim.fn.exepath('python3') or 'python'
      end

      dap.configurations.python = {
        {
          type = 'python',
          request = 'launch',
          name = 'Launch file',
          program = '${file}',
          pythonPath = resolve_project_python,
          console = 'internalConsole',
        },
        {
          type = 'python',
          request = 'launch',
          name = 'Launch file (with arguments)',
          program = '${file}',
          args = function()
            local args = vim.fn.input('Arguments: ')
            return vim.split(args, ' ', { trimempty = true })
          end,
          pythonPath = resolve_project_python,
          console = 'internalConsole',
        },
      }

      -- Go: uses delve, installed via mason-nvim-dap
      require('dap-go').setup()

      -- Rust / C / C++: codelldb adapter (installed via mason-nvim-dap)
      -- mason-nvim-dap places codelldb under mason's bin path
      local mason_bin = vim.fn.stdpath('data') .. '/mason/bin/'
      local codelldb_cmd = mason_bin .. 'codelldb'
      if vim.fn.has('win32') == 1 then
        codelldb_cmd = mason_bin .. 'codelldb.cmd'
      end

      dap.adapters.codelldb = {
        type = 'server',
        port = '${port}',
        executable = {
          command = codelldb_cmd,
          args = { '--port', '${port}' },
        },
      }

      local codelldb_config = {
        {
          name = 'Launch (codelldb)',
          type = 'codelldb',
          request = 'launch',
          program = function()
            return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
          end,
          cwd = '${workspaceFolder}',
          stopOnEntry = false,
        },
      }
      dap.configurations.c = codelldb_config
      dap.configurations.cpp = codelldb_config
      dap.configurations.rust = codelldb_config
    end,
  },
  {
    'theHamsta/nvim-dap-virtual-text',
    dependencies = { 'mfussenegger/nvim-dap', 'nvim-treesitter/nvim-treesitter' },
    event = 'VeryLazy',
    opts = {},
  },
  {
    'rcarriga/nvim-dap-ui',
    event = 'VeryLazy',
    dependencies = {
      'mfussenegger/nvim-dap',
      'nvim-neotest/nvim-nio',
      'theHamsta/nvim-dap-virtual-text',
    },
    keys = {
      {
        '<leader>du',
        function()
          require('dapui').toggle({})
        end,
        desc = 'Toggle Dap UI',
      },
      {
        '<leader>de',
        function()
          require('dapui').eval()
        end,
        desc = 'Eval Expression',
        mode = { 'n', 'v' },
      },
      {
        '<leader>dfs',
        function()
          require('dapui').float_element('scopes', { enter = true })
        end,
        desc = 'Float Scopes',
      },
      {
        '<leader>dfS',
        function()
          require('dapui').float_element('stacks', { enter = true })
        end,
        desc = 'Float Stack',
      },
      {
        '<leader>dfw',
        function()
          require('dapui').float_element('watches', { enter = true })
        end,
        desc = 'Float Watches',
      },
      {
        '<leader>dfb',
        function()
          require('dapui').float_element('breakpoints', { enter = true })
        end,
        desc = 'Float Breakpoints',
      },
    },
    opts = {
      controls = {
        enabled = true,
        element = 'repl',
        icons = {
          pause = ' ',
          play = ' ',
          step_into = ' ',
          step_over = ' ',
          step_out = ' ',
          step_back = ' ',
          run_last = ' ',
          terminate = ' ',
          disconnect = ' ',
        },
      },
      layouts = {
        {
          position = 'bottom',
          size = 15,
          elements = {
            { id = 'repl', size = 1 },
          },
        },
      },
      floating = {
        border = 'rounded',
        mappings = { close = { 'q', '<Esc>' } },
      },
      render = {
        indent = 2,
        max_value_lines = 50,
      },
    },
    config = function(_, opts)
      local dapui = require('dapui')
      dapui.setup(opts)

      -- Prepend a title to the controls winbar.
      -- dapui owns the winbar entirely on controls.element, so we patch its
      -- renderer to inject a title segment before the icons.
      local controls = require('dapui.controls')
      local orig_controls = controls.controls
      controls.controls = function(is_active)
        local hl = is_active and 'WinBar' or 'WinBarNC'
        return ('%%#%s# \u{f120}  REPL %%#0#'):format(hl) .. orig_controls(is_active)
      end

      -- Control icon highlight groups.
      -- NC variants are shown when the window is not focused.
      local hl = vim.api.nvim_set_hl
      hl(0, 'DapUIPlayPause', { fg = '#98be65' }) -- green  — play / pause
      hl(0, 'DapUIPlayPauseNC', { fg = '#4a6741' })
      hl(0, 'DapUIStepInto', { fg = '#51afef' }) -- blue   — step into
      hl(0, 'DapUIStepIntoNC', { fg = '#2a5a7a' })
      hl(0, 'DapUIStepOver', { fg = '#51afef' }) -- blue   — step over
      hl(0, 'DapUIStepOverNC', { fg = '#2a5a7a' })
      hl(0, 'DapUIStepOut', { fg = '#51afef' }) -- blue   — step out
      hl(0, 'DapUIStepOutNC', { fg = '#2a5a7a' })
      hl(0, 'DapUIStepBack', { fg = '#51afef' }) -- blue   — step back
      hl(0, 'DapUIStepBackNC', { fg = '#2a5a7a' })
      hl(0, 'DapUIRestart', { fg = '#ecbe7b' }) -- yellow — run last
      hl(0, 'DapUIRestartNC', { fg = '#7a6a2a' })
      hl(0, 'DapUIStop', { fg = '#ff6c6b' }) -- red    — terminate / disconnect
      hl(0, 'DapUIStopNC', { fg = '#7a2a2a' })
      hl(0, 'DapUIUnavailable', { fg = '#555555' }) -- dim    — unavailable action
      hl(0, 'DapUIUnavailableNC', { fg = '#3a3a3a' })

      local dap = require('dap')
      dap.listeners.after.event_initialized['dapui_config'] = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated['dapui_config'] = function()
        dapui.close()
      end
      dap.listeners.before.event_exited['dapui_config'] = function()
        dapui.close()
      end
    end,
  },
}
