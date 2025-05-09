-- LSP config
local lsp_keymaps = require("config.keymaps.lsp")

local function inject_cmp_engine(engine, capabilities)
    if engine then
        return engine.get_lsp_capabilities(capabilities)
    end
    return vim.lsp.protocol.make_client_capabilities()
end

local function lsp_onattach(client, bufnr)
    lsp_keymaps.config(client, bufnr)
end

local function setup_icons(icons)
    vim.diagnostic.config({
        signs = {
            text = {
                [vim.diagnostic.severity.ERROR] = icons.diagnostics.Error,
                [vim.diagnostic.severity.WARN] = icons.diagnostics.Warning,
                [vim.diagnostic.severity.HINT] = icons.diagnostics.Hint,
                [vim.diagnostic.severity.INFO] = icons.diagnostics.Info,
            },
            linehl = {
            },
            numhl = {
                [vim.diagnostic.severity.ERROR] = 'DiagnosticSignError',
                [vim.diagnostic.severity.WARN] = 'DiagnosticSignWarn',
                [vim.diagnostic.severity.HINT] = 'DiagnosticSignHint',
                [vim.diagnostic.severity.INFO] = 'DiagnosticSignInfo',
            },
        },
    })
end

local function setup_lsp_defaults(lspconfig)
    local lsp_defaults = lspconfig.util.default_config
    lsp_defaults.capabilities =
        vim.tbl_deep_extend("force", lsp_defaults.capabilities,
            require('blink.cmp').get_lsp_capabilities(lsp_defaults.capabilities))
    return lsp_defaults
end

local function configure_logging(enable)
    if enable then
        vim.lsp.set_log_level("debug")
    end
end

-- C/Cpp
local function configure_cpp_lsp(lspconfig, lsp_defaults)
	local clangd_capabilities = lsp_defaults.capabilities
	clangd_capabilities.offsetEncoding = "utf-8"

	lspconfig.clangd.setup({
		on_attach = lsp_onattach,
		capabilities = clangd_capabilities,
		cmd = {
			"clangd",
			"--clang-tidy",
			"--completion-style=bundled",
            "--fallback-style=file",
		},
	})
end

-- C#
local function configure_csharp_lsp(lspconfig)
	lspconfig.csharp_ls.setup({
		on_attach = lsp_onattach,
	})
end

-- Lua
local function configure_lua_lsp(lspconfig)
	lspconfig.lua_ls.setup({
		on_attach = lsp_onattach,
		on_init = function(client)
			local path = client.workspace_folders[1].name
			if not vim.loop.fs_stat(path .. "/.luarc.json") and not vim.loop.fs_stat(path .. "/.luarc.jsonc") then
				client.config.settings = vim.tbl_deep_extend("force", client.config.settings, {
					Lua = {
						runtime = {
							-- Tell the language server which version of Lua you're using
							-- (most likely LuaJIT in the case of Neovim)
							version = "LuaJIT",
						},
						-- Make the server aware of Neovim runtime files
						workspace = {
							checkThirdParty = false,
							library = {
								vim.env.VIMRUNTIME,
								-- "${3rd}/luv/library"
								-- "${3rd}/busted/library",
							},
							-- or pull in all of 'runtimepath'. NOTE: this is a lot slower
							-- library = vim.api.nvim_get_runtime_file("", true)
						},
					},
				})

				client.notify("workspace/didChangeConfiguration", { settings = client.config.settings })
			end
			return true
		end,
	})
end

-- Python pylsp
local function configure_python_lsp(lspconfig)
	lspconfig.pylsp.setup({
		on_attach = lsp_onattach,
		settings = {
			pylsp = {
				configurationSources = {
					"flake8",
				},
				plugins = {
					flake8 = {
						enabled = true,
					},
					pycodestyle = {
						enabled = false,
					},
				},
			},
		},
	})
end

-- Python ruff
-- local function configure_python_ruff(lspconfig)
-- 	lspconfig.ruff.setup({
-- 		on_attach = lsp_onattach,
-- 	})
-- end

-- CMake
local function configure_cmake_lsp(lspconfig)
	lspconfig.cmake.setup({
		on_attach = lsp_onattach,
	})
end

-- Json
local function configure_json_lsp(lspconfig)
	lspconfig.jsonls.setup({
		on_attach = lsp_onattach,
	})
end

-- Docker
local function configure_docker_lsp(lspconfig)
	lspconfig.dockerls.setup({
		on_attach = lsp_onattach,
	})
end

-- Terraform
local function configure_terraform_lsp(lspconfig)
	lspconfig.terraformls.setup({
		on_attach = lsp_onattach,
	})
end

-- YAML
local function configure_yaml_lsp(lspconfig)
	lspconfig.yamlls.setup({
		on_attach = lsp_onattach,
	})
end

-- Markdown
local function configure_markdown_lsp(lspconfig)
	lspconfig.marksman.setup({
		on_attach = lsp_onattach,
	})
end

-- Javascript
local function configure_javascript_lsp(lspconfig)
	lspconfig.eslint.setup({
		on_attach = lsp_onattach,
	})
end

-- Powershell
local function configure_powershell_lsp(lspconfig)
	lspconfig.powershell_es.setup({
		bundle_path = vim.fn.stdpath("data") .. "/mason/packages/powershell-editor-services/",
		on_attach = lsp_onattach,
	})
end

-- SQL
local function configure_sql_lsp(lspconfig)
	lspconfig.sqls.setup({
		on_attach = lsp_onattach,
	})
end

-- Rust
local function configure_rust_lsp(lspconfig, lsp_defaults)
    local rust_capabilities = lsp_defaults.capabilities
    rust_capabilities.offsetEncoding = { "utf-8", "utf-16" }
    lspconfig.rust_analyzer.setup({
        capabilities = rust_capabilities,
        on_attach = lsp_onattach,
        settings = {
            ["rust-analyzer"] = {},
        },
    })
end

-- Go
local function configure_go_lsp(lspconfig, lsp_defaults)
    local go_capabilities = lsp_defaults.capabilities
    lspconfig.gopls.setup({
        capabilities = go_capabilities,
        on_attach = lsp_onattach,
        settings = {
            gopls = {
                gofumpt = true,
            },
        },
        flags = {
            debounce_text_changes = 150,
        },
    })
end

-- Astgrep
local function configure_astgrep_lsp(lspconfig)
	lspconfig.ast_grep.setup({
		on_attach = lsp_onattach,
		filetypes = {
			"javascript",
			"typescript",
			"html",
			"css",
		},
	})
end

-- XML
local function configure_xml_lsp(lspconfig)
	lspconfig.lemminx.setup({
		on_attach = lsp_onattach,
		filetypes = {
			"xml",
			"xsd",
			"xsl",
			"xslt",
			"svg",
		},
	})
end

-- Jinja
local function configure_jinja_lsp(lspconfig)
	lspconfig.jinja_lsp.setup({
		on_attach = lsp_onattach,
	})
end

return {
    config = function()
		configure_logging(false)

		local lspconfig = require("lspconfig")
		local lsp_defaults = setup_lsp_defaults(lspconfig)

		configure_cpp_lsp(lspconfig, lsp_defaults)
		configure_lua_lsp(lspconfig)
		configure_csharp_lsp(lspconfig)
		configure_python_lsp(lspconfig)
		-- configure_python_ruff(lspconfig)
		configure_astgrep_lsp(lspconfig)
		configure_go_lsp(lspconfig, lsp_defaults)
		configure_rust_lsp(lspconfig, lsp_defaults)
		configure_cmake_lsp(lspconfig)
		configure_json_lsp(lspconfig)
		configure_docker_lsp(lspconfig)
		configure_terraform_lsp(lspconfig)
		configure_yaml_lsp(lspconfig)
		configure_markdown_lsp(lspconfig)
		configure_javascript_lsp(lspconfig)
		configure_powershell_lsp(lspconfig)
		configure_xml_lsp(lspconfig)
		configure_jinja_lsp(lspconfig)
		configure_sql_lsp(lspconfig)

		vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
			border = "single",
		})

		setup_icons(require("common.icons"))
    end,
}
