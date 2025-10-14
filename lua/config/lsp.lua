-- LSP config
local lsp_config_backend = require('common.lsp_backend')

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
        lsp_config_backend.setup({
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
            make_lsp_config("yamlls", {
                on_attach = lsp_config_backend.lsp_extend_baseline_onattach(function(client, bufnr)
                    -- Force YAML to permit formatting
                    client.server_capabilities.documentFormattingProvider = true
                end),
                filetypes = { "yaml.github", "yaml", "yaml.docker-compose" },
            }),
            make_lsp_config("lemminx"),
            make_lsp_config("rust_analyzer"),
            make_lsp_config("glsl_analyzer"),
            make_lsp_config("sqlls"),
            make_lsp_config("gh_actions_ls", {
                filetypes = { "yaml.github", "yaml" },
            }),
            make_lsp_config("bashls"),
            make_lsp_config("gopls"),
            make_lsp_config("powershell_es"),
            make_lsp_config("taplo"),
            make_lsp_config("texlab", {
                root_markers = { ".git", ".latexmkrc", "latexmkrc", ".texlabroot", "texlabroot", "Tectonic.toml" },
                filetypes = { "tex", "plaintex", "bib" },
                settings = {
                    texlab = {
                        build = {
                            executable = "tectonic",
                            args = {
                                "-X",
                                "compile",
                                "%f",
                                "--synctex",
                                "--keep-logs",
                                "--keep-intermediates",
                            },
                        },
                        latexFormatter = "tex-fmt",
                        bibtexFormatter = "tex-fmt",
                    },
                }
            }),
            make_lsp_config("docker_compose_language_service", {
                config = {
                    cmd = { 'docker-compose-langserver', '--stdio' },
                    single_file_support = true,
                },
                filetypes = { "yaml.docker-compose" },
            }),
        }, "warn")
    end,
}
