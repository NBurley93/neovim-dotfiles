local lspkind = require "lspkind"
lspkind.init()

local cmp = require "cmp"

cmp.setup {
    snippet = {
        expand = function(args)
            require('snippy').expand_snippet(args.body)
        end,
    },

    mapping = {
        ["<C-d>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-e>"] = cmp.mapping.close(),
        ["<C-y>"] = cmp.mapping.confirm {
            behavior = cmp.ConfirmBehavior.Insert,
            select = true,
        },

        ["<c-space>"] = cmp.mapping.complete(),
    },

    sources = {
        { name = "nvim_lua" },
        { name = "nvim_lsp" },
        { name = "buffer", keyword_length = 5 },
    },

    formatting = {
        format = lspkind.cmp_format {
            with_text = true,
            menu = {
                buffer = "[buf]",
                nvim_lsp = "[LSP]",
                nvim_lua = "[api]",
                path = "[path]",
            }
        }
    },

    experimental = {
        native_menu = false,
    }
}

local capabilities = require('cmp_nvim_lsp').default_capabilities()
require'lspconfig'.clangd.setup {
    capabilities = capabilities,
}

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
        border = "rounded",
    })
