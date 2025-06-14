-- LSP config
local function make_lsp_config(server_name, config)
    if config then
        return {
            name = server_name,
            config = config,
        }
    else
        return {
            name = server_name,
        }
    end
end

return {
    config = function()
        require('common.lsp_backend').setup({
            make_lsp_config("clangd", {
                cmd = {
                    "clangd",
                    "--clang-tidy",
                    "--completion-style=bundled",
                    "--fallback-style=file",
                },
            }),
            make_lsp_config("lua_ls", {
                on_init = function(client)
                    local path = client.workspace_folders[1].name
                    if not vim.loop.fs_stat(path .. "/.luarc.json") and not vim.loop.fs_stat(path .. "/.luarc.jsonc") then
                        client.config.settings = vim.tbl_deep_extend("force", client.config.settings, {
                            Lua = {
                                runtime = {
                                    version = "LuaJIT",
                                },
                                workspace = {
                                    checkThirdParty = false,
                                    library = {
                                        vim.env.VIMRUNTIME,
                                    },
                                },
                            },
                        })
                        client.notify("workspace/didChangeConfiguration", { settings = client.config.settings })
                    end
                    return true
                end,
            }),
            make_lsp_config("ruff"),
            make_lsp_config("cmake"),
            make_lsp_config("jsonls"),
            make_lsp_config("dockerls"),
            make_lsp_config("terraformls"),
            make_lsp_config("yamlls"),
            make_lsp_config("lemminx"),
            make_lsp_config("rust_analyzer"),
            make_lsp_config("glsl_analyzer"),
            make_lsp_config("sqlls"),
            make_lsp_config("gh_actions_ls", {
                config = { filetypes = { "yaml.github" } },
            }),
            make_lsp_config("bashls"),
            make_lsp_config("powershell_es"),
            make_lsp_config("taplo"),
        })
    end,
}
