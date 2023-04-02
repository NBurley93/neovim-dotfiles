local map = vim.keymap.set

return {
    config = function()
        require('neodev').setup()
        require('mason').setup()
        require('mason-lspconfig').setup()

        local function lsp_keybinds()
            local keymap_opts = { buffer = 0 }
            map('n', 'K', vim.lsp.buf.hover, keymap_opts)
            map('n', 'gd', vim.lsp.buf.definition, keymap_opts)
            map('n', 'gt', vim.lsp.buf.type_definition, keymap_opts)
            map('n', 'gi', vim.lsp.buf.implementation, keymap_opts)
            map('n', '<leader>df', vim.diagnostic.goto_next, keymap_opts)
            map('n', '<leader>dk', vim.diagnostic.goto_prev, keymap_opts)
            map('n', '<leader>dl', '<cmd>Telescope diagnostics<cr>', keymap_opts)
            map('n', '<leader>r', vim.lsp.buf.rename, keymap_opts)
            map('n', '<leader>fc', function()
                vim.lsp.buf.format { async = true }
            end, keymap_opts)
        end

        -- Setup LSP servers
        -- Default capabilities fetched from cmp_nvim_lsp
        local capabilities = require('cmp_nvim_lsp').default_capabilities()

        -- Cpp
        require 'lspconfig'.clangd.setup {
            capabilities = capabilities,
            on_attach = lsp_keybinds(),
        }

        -- CMake
        require 'lspconfig'.cmake.setup {
            capabilities = capabilities,
            on_attach = lsp_keybinds(),
        }

        -- Lua
        require 'lspconfig'.lua_ls.setup {
            capabilities = capabilities,
            on_attach = lsp_keybinds(),
            settings = {
                Lua = {
                    workspace = {
                        checkThirdParty = false,
                    },
                    completion = {
                        callSnippet = 'Replace'
                    }
                },
            },
        }

        -- Json
        require 'lspconfig'.jsonls.setup {
            capabilities = capabilities,
            on_attach = lsp_keybinds(),
        }

        -- Python
        require 'lspconfig'.pyright.setup {
            capabilities = capabilities,
            on_attach = lsp_keybinds(),
        }

        -- Docker
        require 'lspconfig'.dockerls.setup {
            capabilities = capabilities,
            on_attach = lsp_keybinds(),
        }

        vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
            border = "rounded",
        })
    end,
}
