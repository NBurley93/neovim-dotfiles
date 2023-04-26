local map = vim.keymap.set

return {
	config = function()
		require("neodev").setup()
		require("mason").setup()
		require("mason-lspconfig").setup()

		local lspsig = require("lsp_signature")
		lspsig.on_attach()

		-- Enable logging
		-- vim.lsp.set_log_level("debug")

		local function lsp_onattach()
			local keymap_opts = { buffer = 0 }
			map("n", "K", function()
				lspsig.toggle_float_win()
			end, keymap_opts)
			map("n", "gd", vim.lsp.buf.definition, keymap_opts)
			map("n", "gt", vim.lsp.buf.type_definition, keymap_opts)
			map("n", "gi", vim.lsp.buf.implementation, keymap_opts)
			map("n", "<leader>ca", vim.lsp.buf.code_action, keymap_opts)
			map("n", "<leader>lsf", vim.lsp.buf.references, keymap_opts)
			map("n", "<leader>dl", "<cmd>Telescope diagnostics<cr>", keymap_opts)
			map("n", "<leader>r", vim.lsp.buf.rename, keymap_opts)
			map("n", "<leader>fc", function()
				vim.lsp.buf.format({ async = true })
			end, keymap_opts)
		end

		-- Setup LSP servers
		-- Default capabilities fetched from cmp_nvim_lsp
		local capabilities = require("cmp_nvim_lsp").default_capabilities()
		local lspsig = require("lsp_signature")

		-- Cpp
		local clangd_capabilities = capabilities
		clangd_capabilities.offsetEncoding = "utf-8"
		require("lspconfig").clangd.setup({
			capabilities = clangd_capabilities,
			on_attach = function()
				lsp_onattach()
				map("n", "<leader>h", "<cmd>ClangdSwitchSourceHeader<cr>", { buffer = 0 })
			end,
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
					workspace = {
						checkThirdParty = false,
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

		vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
			border = "rounded",
		})
	end,
}
