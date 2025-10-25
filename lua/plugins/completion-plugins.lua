return {
  {
    'Saghen/blink.cmp',
    lazy = true,
    event = 'InsertEnter',
    version = 'v0.13.*',
    build = 'cargo build --release',
    dependencies = {
      'rafamadriz/friendly-snippets',
      'saghen/blink.compat',
      { 'petertriho/cmp-git', lazy = true },
      { 'onsails/lspkind.nvim', lazy = true },
      { 'giuxtaposition/blink-cmp-copilot' },
    },
    opts = {
      keymap = {
        preset = 'default',
        ['<C-space>'] = {},
      },
      fuzzy = {
        implementation = 'prefer_rust_with_warning',
        prebuilt_binaries = {
          download = true,
          ignore_version_mismatch = true,
        },
      },
      appearance = {
        use_nvim_cmp_as_default = false,
        nerd_font_variant = 'mono',
        kind_icons = {
          Copilot = '',
          Text = '󰉿',
          Method = '󰊕',
          Function = '󰊕',
          Constructor = '󰒓',

          Field = '󰜢',
          Variable = '󰆦',
          Property = '󰖷',

          Class = '󱡠',
          Interface = '󱡠',
          Struct = '󱡠',
          Module = '󰅩',

          Unit = '󰪚',
          Value = '󰦨',
          Enum = '󰦨',
          EnumMember = '󰦨',

          Keyword = '󰻾',
          Constant = '󰏿',

          Snippet = '󱄽',
          Color = '󰏘',
          File = '󰈔',
          Reference = '󰬲',
          Folder = '󰉋',
          Event = '󱐋',
          Operator = '󰪚',
          TypeParameter = '󰬛',
        },
      },
      completion = {
        accept = {
          auto_brackets = {
            enabled = true,
          },
        },
        -- menu = {
        --     border = "rounded",
        --     winhighlight = "Normal:NormalFloat,FloatBorder:FloatBorder,CursorLine:Visual,Search:None",
        -- },
        -- documentation = {
        --     border = "rounded",
        --     auto_show = true,
        -- },
      },
      sources = {
        default = function(ctx)
          local success, node = pcall(vim.treesitter.get_node)
          if success and node and vim.tbl_contains({ 'comment', 'line_comment', 'block_comment' }, node:type()) then
            return { 'buffer', 'copilot' }
          elseif vim.bo.filetype == 'lua' then
            return { 'lsp', 'path', 'lazydev', 'copilot' }
          elseif vim.bo.filetype == 'gitcommit' then
            return { 'git', 'buffer', 'copilot' }
          else
            return { 'lsp', 'path', 'snippets', 'buffer', 'copilot' }
          end
        end,
        providers = {
          lazydev = {
            name = 'LazyDev',
            module = 'lazydev.integrations.blink',
            fallbacks = { 'lsp' },
          },
          git = {
            name = 'git',
            module = 'blink.compat.source',

            score_offset = -3,

            opts = {
              filetypes = { 'gitcommit' },
              remotes = { 'upstream', 'origin' },
            },
          },
          copilot = {
            name = 'copilot',
            module = 'blink-cmp-copilot',
            score_offset = 100,
            async = true,
          },
        },
      },
    },
  },
}
