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
			map("n", "<leader>qf", vim.lsp.buf.code_action, create_lsp_keybind_opts("View code actions"))
			map("n", "<leader>gr", vim.lsp.buf.references, create_lsp_keybind_opts("View references"))
			map("n", "<leader>dl", "<cmd>Telescope diagnostics<cr>", create_lsp_keybind_opts("View diagnostics"))
			map("n", "<leader>rn", vim.lsp.buf.rename, create_lsp_keybind_opts("Rename symbol"))
			map("n", "<leader>fb", function()
				vim.lsp.buf.format({ async = true })
			end, create_lsp_keybind_opts("Format buffer"))
		end

		-- Setup LSP servers
		-- Default capabilities fetched from cmp_nvim_lsp
		local capabilities = require("cmp_nvim_lsp").default_capabilities()

		-- Cpp
		local clangd_capabilities = capabilities
		clangd_capabilities.offsetEncoding = "utf-8"
		require("lspconfig").clangd.setup({
			capabilities = clangd_capabilities,
			on_attach = function()
				lsp_onattach()
				map("n", "<leader>h", "<cmd>ClangdSwitchSourceHeader<cr>", { buffer = 0 })
			end,
			cmd = {
				"clangd",
				"--clang-tidy",
				"--completion-style=bundled",
			},
		})

		-- CMake
		require("lspconfig").cmake.setup({
			capabilities = capabilities,
			on_attach = lsp_onattach(),
		})

		-- Lua
		require("lspconfig").lua_ls.setup({
			capabilities = capabilities,
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
		require("lspconfig").jsonls.setup({
			capabilities = capabilities,
			on_attach = lsp_onattach(),
		})

		-- Python
		require("lspconfig").pyright.setup({
			capabilities = capabilities,
			on_attach = lsp_onattach(),
		})

		-- Docker
		require("lspconfig").dockerls.setup({
			capabilities = capabilities,
			on_attach = lsp_onattach(),
		})

		-- Terraform
		require("lspconfig").terraformls.setup({
			capabilities = capabilities,
			on_attach = lsp_onattach(),
		})

		-- YAML
		require("lspconfig").yamlls.setup({
			capabilities = capabilities,
			on_attach = lsp_onattach(),
		})

		-- Markdown
		require("lspconfig").marksman.setup({
			capabilities = capabilities,
			on_attach = lsp_onattach(),
		})

		-- Powershell
		require("lspconfig").powershell_es.setup({
			bundle_path = vim.fn.stdpath("data") .. "/mason/packages/powershell-editor-services/",
			capabilities = capabilities,
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
