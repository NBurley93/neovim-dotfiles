return {
	config = function()
		local icons = require("common.icons")
		local luasnip = require("luasnip")
		require("luasnip.loaders.from_vscode").lazy_load()

		luasnip.filetype_extend("cpp", { "c" })

		local lspkind = require("lspkind")
		lspkind.init()

		local cmp = require("cmp")
		cmp.setup({
			snippet = {
				expand = function(args)
					luasnip.lsp_expand(args.body)
				end,
			},
			sources = {
				{ name = "luasnip" },
				{ name = "nvim_lsp" },
				{ name = "nvim_lua" },
				{ name = "git" },
			},
			formatting = {
				format = function(_, vim_item)
					vim_item.kind = (icons.kind[vim_item.kind] or "") .. vim_item.kind
					return vim_item
				end,
			},
			experimental = {
				native_menu = false,
			},
		})

		cmp.setup.filetype("gitcommit", {
			sources = cmp.config.sources({
				{ name = "cmp_git" },
			}, {
				{ name = "buffer" },
			}),
		})

		cmp.setup.cmdline({ "/", "?" }, {

			sources = {
				{ name = "buffer" },
				{ name = "nvim_lsp_document_symbol" },
			},
		})

		cmp.setup.cmdline(":", {
			sources = cmp.config.sources({
				{ name = "path" },
			}, {
				{ name = "cmdline" },
			}),
		})

		cmp.setup.filetype({ "dap-repl", "dap_watches", "dapui_hover" }, {
			sources = cmp.config.sources({
				{
					{ name = "dap" },
				},
			}),
		})
	end,
}
