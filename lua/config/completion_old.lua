local setup_cmp_sources = function(cmp)
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
		mapping = cmp.mapping.preset.cmdline(),
		sources = cmp.config.sources({
			{ name = "path" },
		}, {
			{ name = "cmdline" },
		}),
		matching = { disallow_symbol_nonprefix_matching = false }
	})

	cmp.setup.filetype({ "dap-repl", "dap_watches", "dapui_hover" }, {
		sources = cmp.config.sources({
			{
				{ name = "dap" },
			},
		}),
	})
end

local setup_luasnip = function()
	local luasnip = require("luasnip")
	require("luasnip.loaders.from_vscode").lazy_load()

	luasnip.filetype_extend("cpp", { "c" })
end

local get_snip_expand_func = function(args)
	require("luasnip").lsp_expand(args.body)
end

local snip_formatting_func = function(_, vim_item)
	vim_item.kind = (require("common.icons").kind[vim_item.kind] or "") .. vim_item.kind
	return vim_item
end

local cmp_sources = {
	{ name = "luasnip" },
	{ name = "nvim_lsp" },
	{ name = "nvim_lua" },
	{ name = "cmdline" },
	{ name = "git" },
}

return {
	config = function()
		require("lspkind").init()
		setup_luasnip()

		local cmp = require("cmp")
		cmp.setup({
			snippet = {
				expand = get_snip_expand_func,
			},

			sources = cmp_sources,

			formatting = {
				format = snip_formatting_func,
			},

			experimental = {
				native_menu = false,
			},

			window = {
				completion = {
					border = {
						{ "󱐋", "WarningMsg" },
						{ "─", "Comment" },
						{ "╮", "Comment" },
						{ "│", "Comment" },
						{ "╯", "Comment" },
						{ "─", "Comment" },
						{ "╰", "Comment" },
						{ "│", "Comment" },
					},
					scrollbar = false,
				},
				documentation = {
					border = {
						{ "", "DiagnosticHint" },
						{ "─", "Comment" },
						{ "╮", "Comment" },
						{ "│", "Comment" },
						{ "╯", "Comment" },
						{ "─", "Comment" },
						{ "╰", "Comment" },
						{ "│", "Comment" },
					},
					scrollbar = false,
				},
			}
		})

		setup_cmp_sources(cmp)
	end,
}
