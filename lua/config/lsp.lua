local map = vim.keymap.set

return {
	config = function()
		-- Enable logging
		-- vim.lsp.set_log_level('debug')
		--
		local function create_lsp_keybind_opts(helptext)
			return { noremap = true, silent = true, desc = helptext }
		end

		local function lsp_onattach()
			map("n", "K", function()
				require("lsp_signature").toggle_float_win()
			end, create_lsp_keybind_opts("Show code signature"))
			map("n", "gD", vim.lsp.buf.declaration, create_lsp_keybind_opts("Goto code declaration"))
			map("n", "gd", vim.lsp.buf.definition, create_lsp_keybind_opts("Goto code definition"))
			map("n", "gt", vim.lsp.buf.type_definition, create_lsp_keybind_opts("Goto code type definition"))
			map("n", "gi", vim.lsp.buf.implementation, create_lsp_keybind_opts("Goto code implementations"))
			map("n", "<leader>ca", vim.lsp.buf.code_action, create_lsp_keybind_opts("View code actions"))
			map("n", "gr", vim.lsp.buf.references, create_lsp_keybind_opts("View references"))
			map("n", "<leader>dl", "<cmd>Telescope diagnostics<cr>", create_lsp_keybind_opts("View diagnostics"))
			map("n", "<leader>rn", vim.lsp.buf.rename, create_lsp_keybind_opts("Rename symbol"))

			map("n", "gl", vim.diagnostic.open_float, create_lsp_keybind_opts("Floating diagnostic"))
			map("n", "[d", vim.diagnostic.goto_prev, create_lsp_keybind_opts("Goto previous diagnostic"))
			map("n", "]d", vim.diagnostic.goto_next, create_lsp_keybind_opts("Goto next diagnostic"))

			map("n", "<leader>fb", function()
				vim.lsp.buf.format({ async = true })
			end, create_lsp_keybind_opts("Format buffer"))
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
			capabilities = clangd_capabilities,
			cmd = {
				"clangd",
				"--clang-tidy",
				"--completion-style=bundled",
			},
		})

		-- CMake
		lspconfig.cmake.setup({
			on_attach = lsp_onattach(),
		})

		-- Lua
		lspconfig.lua_ls.setup({
			on_attach = lsp_onattach(),
			settings = {
				Lua = {
					runtime = {
						version = "LuaJIT",
					},
					diagnostics = {
						globals = { "vim" },
					},
					workspace = {
						checkThirdParty = false,
						library = vim.api.nvim_get_runtime_file("", true),
					},
					telemetry = {
						enable = false,
					},
					completion = {
						callSnippet = "Replace",
					},
				},
			},
		})

		-- Json
		lspconfig.jsonls.setup({
			on_attach = lsp_onattach(),
		})

		-- Python
		lspconfig.pyright.setup({
			on_attach = lsp_onattach(),
		})

		-- Docker
		lspconfig.dockerls.setup({
			on_attach = lsp_onattach(),
		})

		-- Terraform
		lspconfig.terraformls.setup({
			on_attach = lsp_onattach(),
		})

		-- YAML
		lspconfig.yamlls.setup({
			on_attach = lsp_onattach(),
		})

		-- Markdown
		lspconfig.marksman.setup({
			on_attach = lsp_onattach(),
		})

		lspconfig.ast_grep.setup({
			on_attach = lsp_onattach(),
			filetypes = {
				"javascript",
				"typescript",
				"html",
				"css",
			},
		})

		lspconfig.eslint.setup({
			on_attach = lsp_onattach(),
		})

		-- Powershell
		lspconfig.powershell_es.setup({
			bundle_path = vim.fn.stdpath("data") .. "/mason/packages/powershell-editor-services/",
			on_attach = lsp_onattach(),
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
