local map = vim.keymap.set

local ENABLE_LOGGING = true

local function create_lsp_keybind_opts(helptext)
	return { noremap = true, silent = true, desc = helptext }
end

local function lsp_onattach(client, bufnr)
	map("n", "K", function()
		vim.lsp.buf.hover()
	end, create_lsp_keybind_opts("Show code signature for hover'd item"))
	map("n", "gD", vim.lsp.buf.declaration, create_lsp_keybind_opts("Goto code declaration"))
	map("n", "gd", vim.lsp.buf.definition, create_lsp_keybind_opts("Goto code definition"))
	map("n", "gt", vim.lsp.buf.type_definition, create_lsp_keybind_opts("Goto code type definition"))
	map("n", "gi", vim.lsp.buf.implementation, create_lsp_keybind_opts("Goto code implementations"))
	map("n", "<leader>vca", vim.lsp.buf.code_action, create_lsp_keybind_opts("View code actions"))
	map("n", "gr", vim.lsp.buf.references, create_lsp_keybind_opts("View references"))
	map("n", "<leader>dl", function()
		vim.cmd.Telescope("diagnostics")
	end, create_lsp_keybind_opts("View diagnostics"))
	map("n", "<leader>rn", vim.lsp.buf.rename, create_lsp_keybind_opts("Rename symbol"))

	map("n", "gl", vim.diagnostic.open_float, create_lsp_keybind_opts("Floating diagnostic"))
	map("n", "[d", vim.diagnostic.goto_prev, create_lsp_keybind_opts("Goto previous diagnostic"))
	map("n", "]d", vim.diagnostic.goto_next, create_lsp_keybind_opts("Goto next diagnostic"))
	map("n", "<c-h>", vim.lsp.buf.signature_help, create_lsp_keybind_opts("Show signature help in context"))

	map("n", "<leader>f", function()
		vim.lsp.buf.format({ async = true })
	end, create_lsp_keybind_opts("Format buffer"))

	if client.server_capabilities.inlayHintProvider then
		vim.lsp.inlay_hint.enable(bufnr, true)
	end
end

return {
	config = function()
		if ENABLE_LOGGING == true then
			vim.lsp.set_log_level("debug")
		end

		-- Setup LSP servers
		-- Default capabilities fetched from cmp_nvim_lsp
		local lspconfig = require("lspconfig")
		local lsp_defaults = lspconfig.util.default_config
		lsp_defaults.capabilities =
			vim.tbl_deep_extend("force", lsp_defaults.capabilities, require("cmp_nvim_lsp").default_capabilities())

		-- Cpp
		local clangd_capabilities = lsp_defaults.capabilities
		clangd_capabilities.offsetEncoding = "utf-8"
		lspconfig.clangd.setup({
			on_attach = lsp_onattach,
			capabilities = clangd_capabilities,
			cmd = {
				"clangd",
				"--clang-tidy",
				"--completion-style=bundled",
			},
		})

		-- Lua
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

		-- CMake
		lspconfig.cmake.setup({
			on_attach = lsp_onattach,
		})

		-- Json
		lspconfig.jsonls.setup({
			on_attach = lsp_onattach,
		})

		-- Python
		lspconfig.pyright.setup({
			on_attach = lsp_onattach,
		})

		-- Docker
		lspconfig.dockerls.setup({
			on_attach = lsp_onattach,
		})

		-- Rust
		local rust_capabilities = lsp_defaults.capabilities
		rust_capabilities.offsetEncoding = "utf-8"
		lspconfig.rust_analyzer.setup({
			capabilities = rust_capabilities,
			on_attach = lsp_onattach,
			cmd = {
				"rustup",
				"run",
				"stable",
				"rust-analyzer",
			},
			settings = {
				["rust-analyzer"] = {
					imports = {
						granularity = {
							group = "module",
						},
						prefix = "self",
					},
					cargo = {
						buildScripts = {
							enable = true,
						},
					},
					procMacro = {
						enable = true,
					},
				},
			},
		})

		-- Go
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

		lspconfig.ast_grep.setup({
			on_attach = lsp_onattach,
			filetypes = {
				"javascript",
				"typescript",
				"html",
				"css",
			},
		})

		lspconfig.eslint.setup({
			on_attach = lsp_onattach,
		})

		-- Powershell
		lspconfig.powershell_es.setup({
			bundle_path = vim.fn.stdpath("data") .. "/mason/packages/powershell-editor-services/",
			on_attach = lsp_onattach,
		})

		vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
			border = "rounded",
		})

		local icons = require("common.icons")
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
	end,
}
