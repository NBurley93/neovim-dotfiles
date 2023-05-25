return {
    config = function()
        local cmp = require 'cmp'

        local lspkind = require 'lspkind'
        lspkind.init()

        cmp.setup({
            snippet = {
                expand = function(args)
                    require('luasnip').lsp_expand(args.body)
                end,
            },
            sources = {
                { name = 'nvim_lua' },
                { name = 'nvim_lsp' },
                { name = 'buffer' },
                { name = 'luasnip' },
                { name = 'git' },
            },
            formatting = {
                format = lspkind.cmp_format {
                    with_text = true,
                    menu = {
                        buffer = '[Buffer]',
                        nvim_lsp = '[LSP]',
                        nvim_lua = '[LuaAPI]',
                        path = '[PATH]',
                        snippy = '[SNIP]',
                    }
                }
            },
            experimental = {
                native_menu = false,
            }
        })

        cmp.setup.filetype('gitcommit', {
            sources = cmp.config.sources({
                { name = 'cmp_git' },
            }, {
                { name = 'buffer' },
            })
        })

        cmp.setup.cmdline('/', {
            sources = {
                { name = 'buffer' }
            }
        })

        cmp.setup.cmdline(':', {
            sources = cmp.config.sources({
                { name = 'path' }
            }, {
                { name = 'cmdline' }
            })
        })
    end,
}
