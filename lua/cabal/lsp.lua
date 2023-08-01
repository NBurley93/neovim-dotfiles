local map = vim.keymap.set

return {
	config = function()
		-- Enable logging
		-- vim.lsp.set_log_level('debug')

		local function lsp_onattach()
			local keymap_opts = { noremap = true, silent = true }
			map("n", "K", function()
				require("lsp_signature").toggle_float_win()
			end, keymap_opts)
			map("n", "gD", vim.lsp.buf.declaration, keymap_opts)
			map("n", "gd", vim.lsp.buf.definition, keymap_opts)
			map("n", "gt", vim.lsp.buf.type_definition, keymap_opts)
			map("n", "gi", vim.lsp.buf.implementation, keymap_opts)
			map("n", "<leader>D", vim.lsp.buf.type_definition, keymap_opts)
			map("n", "<leader>qf", vim.lsp.buf.code_action, keymap_opts)
			map("n", "<leader>gr", vim.lsp.buf.references, keymap_opts)
			map("n", "<leader>dl", "<cmd>Telescope diagnostics<cr>", keymap_opts)
			map("n", "<leader>rn", vim.lsp.buf.rename, keymap_opts)
			map("n", "<leader>f", function()
				vim.lsp.buf.format({ async = true })
			end, keymap_opts)
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
	end,
}
