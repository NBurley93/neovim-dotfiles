local copilot_highlight_color = '#ffa600'

return {
  {
    'rafamadriz/friendly-snippets',
  },
  -- blink.cmp - Modern, Fast and Extensible Completion Engine for Neovim
  {
    'Saghen/blink.cmp',
    version = 'v1.1.*',
    build = 'cargo build --release',
    dependencies = {
      { 'folke/lazydev.nvim', ft = 'lua' },
      'rafamadriz/friendly-snippets',
      'saghen/blink.compat',
      'onsails/lspkind.nvim',
      'Kaiser-Yang/blink-cmp-git',
      'giuxtaposition/blink-cmp-copilot',
    },
    opts = {
      keymap = {
        preset = 'default',
        ['<C-space>'] = {},
      },
      fuzzy = { implementation = 'prefer_rust_with_warning' },
      appearance = {
        use_nvim_cmp_as_default = false,
        nerd_font_variant = 'mono',
      },
      completion = {
        accept = {
          auto_brackets = {
            enabled = true,
          },
        },
        menu = {
          border = nil,
          cmdline_position = function()
            if vim.g.ui_cmdline_pos ~= nil then
              local pos = vim.g.ui_cmdline_pos -- (1, 0)-indexed
              return { pos[1] - 1, pos[2] }
            end
            local height = (vim.o.cmdheight == 0) and 1 or vim.o.cmdheight
            return { vim.o.lines - height, 0 }
          end,
          draw = {
            padding = { 1, 1 },
            columns = {
              { 'label', gap = 1 },
              { 'kind_icon', 'kind', gap = 1 },
            },
            components = {
              kind_icon = {
                text = function(ctx)
                  if vim.tbl_contains({ 'Path' }, ctx.source_name) then
                    local mini_icon, _ = require('mini.icons').get(ctx.item.data.type, ctx.label)
                    if mini_icon then
                      return mini_icon .. ctx.icon_gap
                    end
                  end

                  if vim.tbl_contains({ 'LSP' }, ctx.source_name) then
                    -- snippet is a type that can be defined in the LSP source, but mini.icons doesn't have that icon under the lsp category
                    if ctx.kind:lower() == 'snippet' then
                      return '' .. ctx.icon_gap
                    end

                    local mini_icon, _ = require('mini.icons').get('lsp', ctx.kind)
                    if mini_icon then
                      return mini_icon .. ctx.icon_gap
                    end
                  end

                  -- Handle copilot icon separately to avoid misalignment
                  if ctx.kind == 'Copilot' then
                    return '' .. ctx.icon_gap
                  end

                  -- Handle icons for kinds not covered by mini.icons
                  if ctx.kind == 'Snippet' then
                    return '' .. ctx.icon_gap
                  end

                  if ctx.kind == 'Text' then
                    return '' .. ctx.icon_gap
                  end

                  if ctx.kind == 'Buffer' then
                    return '' .. ctx.icon_gap
                  end

                  if ctx.kind == 'Git' then
                    return '' .. ctx.icon_gap
                  end

                  return ctx.kind_icon .. ctx.icon_gap
                end,

                -- Optionally, use the highlight groups from mini.icons
                -- You can also add the same function for `kind.highlight` if you want to
                -- keep the highlight groups in sync with the icons.
                highlight = function(ctx)
                  if vim.tbl_contains({ 'Path' }, ctx.source_name) then
                    local mini_icon, mini_hl = require('mini.icons').get(ctx.item.data.type, ctx.label)
                    if mini_icon then
                      return mini_hl
                    end
                  end

                  if vim.tbl_contains({ 'LSP' }, ctx.source_name) then
                    local mini_icon, mini_hl, _ = require('mini.icons').get('lsp', ctx.kind)
                    if mini_icon then
                      return mini_hl
                    end
                  end

                  if ctx.source_name == 'Copilot' then
                    return 'BlinkCmpKindCopilot'
                  end

                  return ctx.kind_hl
                end,
              },
              label = {
                text = function(item)
                  return item.label
                end,
                highlight = 'BlinkMenuItemLabel',
              },
              kind = {
                -- Optional, use highlights from mini.icons
                highlight = function(ctx)
                  if vim.tbl_contains({ 'LSP' }, ctx.source_name) then
                    local mini_icon, mini_hl, _ = require('mini.icons').get('lsp', ctx.kind)
                    if mini_icon then
                      return mini_hl
                    end
                  end

                  if ctx.source_name == 'Copilot' then
                    return 'BlinkCmpKindCopilot'
                  end

                  return ctx.kind_hl
                end,
                text = function(ctx)
                  return '<' .. ctx.kind:lower() .. '>'
                end,
              },
            },
          },
        },
        documentation = {
          auto_show = true,
          auto_show_delay_ms = 250,
          treesitter_highlighting = true,
          window = { border = nil },
        },
        list = {
          selection = {
            preselect = true,
            auto_insert = false,
          },
        },
      },
      sources = {
        default = function(ctx)
          local success, node = pcall(vim.treesitter.get_node)
          local base_sources = { 'lsp', 'lazydev', 'git', 'path', 'buffer', 'snippets', 'copilot' }
          return base_sources
        end,
        providers = {
          lsp = {
            name = 'LSP',
            min_keyword_length = 2,
            score_offset = 0,
          },
          path = {
            name = 'Path',
            min_keyword_length = 0,
          },
          snippets = {
            name = 'Snippets',
            min_keyword_length = 2,
          },
          buffer = {
            name = 'Buffer',
            min_keyword_length = 5,
            max_items = 5,
          },
          lazydev = {
            name = 'LazyDev',
            module = 'lazydev.integrations.blink',
            enabled = function()
              return vim.bo.filetype == 'lua'
            end,
            score_offset = 90,
          },
          git = {
            name = 'Git',
            module = 'blink-cmp-git',

            enabled = function()
              return vim.tbl_contains({ 'octo', 'gitcommit', 'markdown' }, vim.bo.filetype)
            end,

            opts = {},
          },
          copilot = {
            name = 'Copilot',
            module = 'blink-cmp-copilot',
            score_offset = 100, -- Always prefer Copilot suggestions
            async = true,
          },
        },
      },
    },
    config = function(_, opts)
      require('blink.cmp').setup(opts)
      vim.api.nvim_set_hl(0, 'BlinkCmpKindCopilot', { fg = copilot_highlight_color })
    end,
  },
}
