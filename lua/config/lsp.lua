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

    vim.lsp.config('clangd', {
        on_attach = lsp_onattach,
        capabilities = clangd_capabilities,
        cmd = {
            "clangd",
            "--clang-tidy",
            "--completion-style=bundled",
            "--fallback-style=file",
        },
    })
    vim.lsp.enable('clangd')
end

-- Lua
local function configure_lua_lsp(lspconfig)
    vim.lsp.config('lua_ls', {
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
    vim.lsp.enable('lua_ls')
end

-- Python ruff
local function configure_python_ruff(lspconfig)
    vim.lsp.config('ruff', {
        on_attach = lsp_onattach,
    })
    vim.lsp.enable('ruff')
end

-- CMake
local function configure_cmake_lsp(lspconfig)
    vim.lsp.config('cmake', {
        on_attach = lsp_onattach,
    })
    vim.lsp.enable('cmake')
end

-- Json
local function configure_json_lsp(lspconfig)
    vim.lsp.config('jsonls', {
        on_attach = lsp_onattach,
    })
    vim.lsp.enable('jsonls')
end

-- Docker
local function configure_docker_lsp(lspconfig)
	vim.lsp.config('dockerls', {
		on_attach = lsp_onattach,
	})
    vim.lsp.enable('dockerls')
end

-- Terraform
local function configure_terraform_lsp(lspconfig)
	vim.lsp.config('terraformls', {
		on_attach = lsp_onattach,
	})
    vim.lsp.enable('terraformls')
end

-- YAML
local function configure_yaml_lsp(lspconfig)
	vim.lsp.config('yamlls', {
		on_attach = lsp_onattach,
	})
    vim.lsp.enable('yamlls')
end

-- Rust
local function configure_rust_lsp(lspconfig, lsp_defaults)
    local rust_capabilities = lsp_defaults.capabilities
    rust_capabilities.offsetEncoding = { "utf-8", "utf-16" }

    vim.lsp.config('rust_analyzer', {
        on_attach = lsp_onattach,
        capabilities = rust_capabilities,
        settings = {
            ["rust-analyzer"] = {},
        },
    })
    vim.lsp.enable('rust_analyzer')
end


return {
    config = function()
		configure_logging(false)

		local lspconfig = require("lspconfig")
		local lsp_defaults = setup_lsp_defaults(lspconfig)

		configure_cpp_lsp(lspconfig, lsp_defaults)
		configure_lua_lsp(lspconfig)
		configure_python_ruff(lspconfig)
		configure_rust_lsp(lspconfig, lsp_defaults)
		configure_cmake_lsp(lspconfig)
		configure_json_lsp(lspconfig)
		configure_docker_lsp(lspconfig)
		configure_terraform_lsp(lspconfig)
		configure_yaml_lsp(lspconfig)

		vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
			border = "single",
		})

		setup_icons(require("common.icons"))
    end,
}
