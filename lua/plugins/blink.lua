-- Icons for kinds mini.icons doesn't cover (Git, Buffer) or that we prefer our own glyph for
local custom_kind_icons = {
  Snippet = '\u{f0c4}',
  Text = '\u{eb69}',
  Buffer = '\u{f15b}',
  Git = '\u{e702}',
}

-- Returns the icon and highlight group for a completion item
local function kind_icon(ctx)
  if ctx.source_name == 'Path' then
    local ok, icon, hl = pcall(require('mini.icons').get, ctx.item.data.type, ctx.label)
    if ok and icon then
      return icon, hl
    end
  end

  if custom_kind_icons[ctx.kind] then
    return custom_kind_icons[ctx.kind], ctx.kind_hl
  end

  return require('mini.icons').get('lsp', ctx.kind)
end

local function kind_icon_hl(ctx)
  local _, hl = kind_icon(ctx)
  return hl
end

return {
  {
    'rafamadriz/friendly-snippets',
    lazy = true,
  },
  -- blink.cmp - Modern, Fast and Extensible Completion Engine for Neovim
  {
    'Saghen/blink.cmp',
    version = 'v1.10.*',
    build = function()
      require('blink.cmp').build():pwait()
    end,
    event = { 'InsertEnter', 'CmdlineEnter' },
    dependencies = {
      { 'folke/lazydev.nvim', ft = 'lua' },
      'rafamadriz/friendly-snippets',
      { 'L3MON4D3/LuaSnip', version = 'v2.*' },
      'Kaiser-Yang/blink-cmp-git',
      'mayromr/blink-cmp-dap',
      'bydlw98/blink-cmp-env',
      'Fildo7525/pretty_hover',
    },
    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
      keymap = {
        preset = 'default',
        ['<C-y>'] = { 'select_and_accept', 'fallback' },
      },
      fuzzy = {
        implementation = 'prefer_rust_with_warning',
        sorts = {
          -- Exactly typed labels win, so a snippet's full trigger still reaches it
          'exact',
          -- Snippets after everything else, from any source (friendly-snippets and clangd's own),
          -- so they can't outrank constructors and members on score or frecency
          function(a, b)
            local snippet = require('blink.cmp.types').CompletionItemKind.Snippet
            local a_is_snippet, b_is_snippet = a.kind == snippet, b.kind == snippet
            if a_is_snippet ~= b_is_snippet then
              return b_is_snippet
            end
          end,
          'score',
          'sort_text',
        },
      },
      appearance = {
        use_nvim_cmp_as_default = false,
        nerd_font_variant = 'mono',
      },
      signature = {
        enabled = true,
        window = { border = 'rounded' },
      },
      snippets = {
        preset = 'luasnip',
      },
      completion = {
        accept = {
          auto_brackets = {
            enabled = true,
          },
        },
        ghost_text = {
          enabled = true,
        },
        menu = {
          border = 'rounded',
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
            -- Highlight LSP labels with treesitter, like the code they complete
            treesitter = { 'lsp' },
            columns = {
              { 'label', 'label_description', gap = 1 },
              { 'kind_icon', 'kind', gap = 1 },
            },
            components = {
              kind_icon = {
                text = function(ctx)
                  return kind_icon(ctx) .. ctx.icon_gap
                end,
                highlight = kind_icon_hl,
              },
              kind = {
                text = function(ctx)
                  return '<' .. ctx.kind:lower() .. '>'
                end,
                highlight = kind_icon_hl,
              },
            },
          },
        },
        documentation = {
          auto_show = true,
          auto_show_delay_ms = 250,
          treesitter_highlighting = true,
          window = { border = 'rounded' },
          draw = function(opts)
            if opts.item and opts.item.documentation and opts.item.documentation.value then
              local out = require('pretty_hover.parser').parse(opts.item.documentation.value)
              opts.item.documentation.value = out:string()
            end

            opts.default_implementation(opts)
          end,
        },
        list = {
          selection = {
            preselect = true,
            auto_insert = false,
          },
        },
      },
      sources = {
        default = { 'lsp', 'path', 'buffer', 'snippets', 'dap', 'env' },
        per_filetype = {
          lua = { inherit_defaults = true, 'lazydev' },
          gitcommit = { inherit_defaults = true, 'git' },
          markdown = { inherit_defaults = true, 'git' },
          octo = { inherit_defaults = true, 'git' },
        },
        providers = {
          lsp = {
            name = 'LSP',
            min_keyword_length = 0,
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
            score_offset = 90,
          },
          dap = {
            name = 'DAP',
            module = 'blink-cmp-dap',
          },
          git = {
            name = 'Git',
            module = 'blink-cmp-git',
            opts = {},
          },
          env = {
            name = 'Env',
            module = 'blink-cmp-env',
          },
        },
      },
    },
    config = function(_, opts)
      require('blink.cmp').setup(opts)

      local ls = require('luasnip')
      ls.setup({ enable_autosnippets = true })
      require('luasnip.loaders.from_vscode').lazy_load()
      require('luasnip.loaders.from_lua').load({
        paths = { './lua/snippets' },
      })
    end,
  },
}
