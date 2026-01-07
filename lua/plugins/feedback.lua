local icons = require('common.icons')

return {
  -- Noice.nvim: Enhanced UI for Neovim's command line and messages
  {
    'folke/noice.nvim',
    event = 'VeryLazy',
    opts = {
      cmdline = {
        view = 'cmdline_popup',
        format = {
          cmdline = { icon = '󰆍' },
          help = { icon = '󰠗' },
        },
      },
      routes = {
        {
          view = 'notify',
          filter = { event = 'msg_showmode' },
        },
      },
      presets = {
        long_message_to_split = true,
        inc_rename = false,
        lsp_doc_border = true,
      },
      lsp = {
        override = {
          ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
          ['vim.lsp.util.stylize_markdown'] = true,
          ['cmp.entry.get_documentation'] = true,
        },
      },
    },
    dependencies = {
      'MunifTanjim/nui.nvim',
      'rcarriga/nvim-notify',
    },
  },

  -- nvim-notify: A fancy notification manager for Neovim
  {
    'rcarriga/nvim-notify',
    config = function()
      require('notify').setup({
        render = 'default',
        stages = 'fade_in_slide_out',
        fps = 60,
        timeout = 3000,
        top_down = false,
        -- background_colour = require('mallgoth.palette').bg0,
        -- background_colour = "#000000",
      })
      vim.notify = require('notify')
    end,
  },

  -- trouble.nvim: A pretty list for showing diagnostics, references, etc.
  {
    'folke/trouble.nvim',
    event = {
      'BufReadPost',
      'BufNewFile',
    },
    dependencies = { require('common.defines').WEB_DEVICONS_PROVIDER },
    opts = {
      fold_open = '', -- icon used for open folds
      fold_closed = '', -- icon used for closed folds
      signs = {
        error = icons.diagnostics.Error,
        warning = icons.diagnostics.Warning,
        hint = icons.diagnostics.Hint,
        information = icons.diagnostics.Information,
        other = icons.diagnostics.Information,
      },
    },
  },

  -- lsp-colors.nvim: Automatically create missing LSP diagnostics highlight groups
  -- for color schemes that don't support them
  { 'folke/lsp-colors.nvim' },

  -- nvim-lint: A linting plugin for Neovim
  {
    'mfussenegger/nvim-lint',
    event = { 'BufWritePre' },
    config = function()
      local lint = require('lint')

      lint.linters_by_ft = {
        cmake = { 'cmakelint' },
        gitcommit = { 'commitlint' },
        c = { 'cpplint' },
        cpp = { 'cpplint' },
        go = { 'golangcilint' },
        dockerfile = { 'hadolint' },
        terraform = { 'tflint' },
        markdown = { 'vale' },
        latex = { 'vale' },
        yaml = { 'yamllint' },
        python = { 'flake8' },
        css = { 'stylelint' },
      }

      local lint_augroup = vim.api.nvim_create_augroup('lint', { clear = true })

      vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWritePost', 'InsertLeave' }, {
        group = lint_augroup,
        callback = function()
          lint.try_lint()
        end,
      })
    end,
  },
  -- fidget.nvim: A status indicator for LSP progress
  {
    'j-hui/fidget.nvim',
    event = { 'BufReadPost', 'BufNewFile' },
    opts = {
      progress = {
        display = {
          done_icon = '✅',
          progress_icon = {
            pattern = 'circle_quarters',
            period = 1,
          },
        },
      },
      notification = {
        window = {
          winblend = 0,
          relative = 'editor',
          x_padding = 2,
          y_padding = 1,
        },
      },
    },
  },
}
