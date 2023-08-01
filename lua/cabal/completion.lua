return {
	config = function()
		local cmp = require("cmp")

		local icons = require("common.icons")

		local lspkind = require("lspkind")
		lspkind.init()

		cmp.setup({
			snippet = {
				expand = function(args)
					require("luasnip").lsp_expand(args.body)
				end,
			},
			sources = {
				{ name = "nvim_lua" },
				{ name = "nvim_lsp" },
				{ name = "buffer" },
				{ name = "luasnip" },
				{ name = "git" },
			},
			formatting = {
				format = lspkind.cmp_format({
					with_text = true,
					menu = {
						buffer = icons.kind.Text .. "[Buffer]",
						nvim_lsp = icons.ui.Code .. "[LSP]",
						nvim_lua = icons.language.Lua .. "[LuaAPI]",
						path = icons.kind.Folder .. "[PATH]",
						snippy = icons.kind.Snippet .. "[SNIP]",
					},
				}),
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

		cmp.setup.cmdline("/", {
			sources = {
				{ name = "buffer" },
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
