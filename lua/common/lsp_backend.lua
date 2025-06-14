local M = {}

function M.lsp_onattach_baseline(client, bufnr)
    require('config.keymaps.lsp').config(client, bufnr)
end

function M.lsp_extend_baseline_onattach(func)
    return function(client, bufnr)
        M.lsp_onattach_baseline(client, bufnr)
        func(client, bufnr)
    end
end

function M.setup(server_list)
    local function configure_lsp_server(server_name, config)
        -- Check if the config was provided
        if not config then
            config = {}
        end

        -- Setup defaults
        if not config.on_attach then
            config.on_attach = M.lsp_onattach_baseline
        end
        if not config.on_init then
            config.on_init = function(client)
                return true
            end
        end
        if not config.capabilities then
            config.capabilities = vim.lsp.protocol.make_client_capabilities()
        end

        vim.lsp.config(server_name, config)
        vim.lsp.enable(server_name)
    end

    for _, server in ipairs(server_list) do
        if server.config then
            configure_lsp_server(server.name, server.config)
        else
            configure_lsp_server(server.name)
        end
    end

    vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
        border = "single",
    })

    vim.diagnostic.config({
        signs = require('common.defines').DIAGNOSTIC_SIGNS
    })
end

return M
