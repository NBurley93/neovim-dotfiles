local map = vim.keymap.set

local function create_lsp_keybind_opts(helptext)
	return { noremap = true, silent = true, desc = helptext }
end

local function get_capabilities(cmp_lsp)
	if cmp_lsp then
		return cmp_lsp.default_capabilities()
	end
	return vim.lsp.protocol.make_client_capabilities()
end

local function lsp_onattach(client, bufnr)
	map("n", "K", function()
		vim.lsp.buf.hover()
	end, create_lsp_keybind_opts("Show code signature for hover'd item"))
	map("n", "gD", vim.lsp.buf.declaration, create_lsp_keybind_opts("Goto code declaration"))
	map("n", "gd", vim.lsp.buf.definition, create_lsp_keybind_opts("Goto code definition"))
	map("n", "gt", vim.lsp.buf.type_definition, create_lsp_keybind_opts("Goto code type definition"))
	map("n", "gi", vim.lsp.buf.implementation, create_lsp_keybind_opts("Goto code implementations"))
	map("n", "<leader>c", vim.lsp.buf.code_action, create_lsp_keybind_opts("Code actions"))
	map("n", "gr", vim.lsp.buf.references, create_lsp_keybind_opts("View references"))
	map("n", "<leader>dl", function()
		vim.cmd.Telescope("diagnostics")
	end, create_lsp_keybind_opts("View diagnostics"))
	map("n", "<leader>cr", vim.lsp.buf.rename, create_lsp_keybind_opts("Rename symbol"))

	map("n", "gl", vim.diagnostic.open_float, create_lsp_keybind_opts("Floating diagnostic"))
	map("n", "[d", vim.diagnostic.goto_prev, create_lsp_keybind_opts("Goto previous diagnostic"))
	map("n", "]d", vim.diagnostic.goto_next, create_lsp_keybind_opts("Goto next diagnostic"))
	map("n", "<c-h>", vim.lsp.buf.signature_help, create_lsp_keybind_opts("Show signature help in context"))

	map("n", "<leader>cf", function()
		vim.lsp.buf.format({ async = true })
	end, create_lsp_keybind_opts("Format buffer"))
end

local function setup_icons(icons)
	local signs = {
		Error = icons.diagnostics.Error,
		Warn = icons.diagnostics.Warning,
		Hint = icons.diagnostics.Hint,
		Info = icons.diagnostics.Information,
	}
	for type, icon in pairs(signs) do
		local hl = "DiagnosticSign" .. type
		vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
	end
end

local function setup_lsp_defaults(lspconfig)
	local lsp_defaults = lspconfig.util.default_config
	lsp_defaults.capabilities =
		vim.tbl_deep_extend("force", lsp_defaults.capabilities, get_capabilities(require("cmp_nvim_lsp")))
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
		on_attach = function(client, bufnr)
			lsp_onattach(client, bufnr)
			map(
				"n",
				"<leader>sh",
				vim.cmd.ClangdSwitchSourceHeader,
				create_lsp_keybind_opts("Swap to header/implementation file")
			)
		end,
		capabilities = clangd_capabilities,
		cmd = {
			"clangd",
			"--clang-tidy",
			"--completion-style=bundled",
		},
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
				plugins = {
					pycodestyle = {
						maxLineLength = 80,
					},
				},
			},
		},
	})
end

-- Python ruff
local function configure_python_ruff_lsp(lspconfig)
	lspconfig.ruff_lsp.setup({
		on_attach = lsp_onattach,
	})
end

local function configure_misc_lsp(lspconfig)
	-- CMake
	lspconfig.cmake.setup({
		on_attach = lsp_onattach,
	})

	-- Json
	lspconfig.jsonls.setup({
		on_attach = lsp_onattach,
	})

	-- Docker
	lspconfig.dockerls.setup({
		on_attach = lsp_onattach,
	})

	-- Terraform
	lspconfig.terraformls.setup({
		on_attach = lsp_onattach,
	})

	-- YAML
	lspconfig.yamlls.setup({
		on_attach = lsp_onattach,
	})

	-- Markdown
	lspconfig.marksman.setup({
		on_attach = lsp_onattach,
	})

	-- Javascript
	lspconfig.eslint.setup({
		on_attach = lsp_onattach,
	})

	-- Powershell
	lspconfig.powershell_es.setup({
		bundle_path = vim.fn.stdpath("data") .. "/mason/packages/powershell-editor-services/",
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

return {
	config = function()
		configure_logging(false)

		local lspconfig = require("lspconfig")
		local lsp_defaults = setup_lsp_defaults(lspconfig)

		configure_cpp_lsp(lspconfig, lsp_defaults)
		configure_lua_lsp(lspconfig)
		--configure_python_lsp(lspconfig)
		configure_python_ruff_lsp(lspconfig)
		configure_astgrep_lsp(lspconfig)
		configure_go_lsp(lspconfig, lsp_defaults)
		configure_rust_lsp(lspconfig, lsp_defaults)
		configure_misc_lsp(lspconfig)

		vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
			border = "single",
		})

		setup_icons(require("common.icons"))
	end,
}
