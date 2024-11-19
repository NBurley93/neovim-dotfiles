return {
	-- {
	-- 	"hrsh7th/nvim-cmp",
	-- 	opts = function(_, opts)
	-- 		opts.sources = opts.sources or {}
	-- 		table.insert(opts.sources, {
	-- 			name = "lazydev",
	-- 			group_index = 0,
	-- 		})
	-- 	end,
	-- },
	-- { "hrsh7th/cmp-nvim-lua" },
	-- { "hrsh7th/cmp-nvim-lsp" },
	-- { "hrsh7th/cmp-buffer" },
	-- { "hrsh7th/cmp-path" },
	-- { "hrsh7th/cmp-nvim-lsp-document-symbol" },
	{ "tpope/vim-sleuth" },
	-- { "saadparwaiz1/cmp_luasnip" },
	-- { "rcarriga/cmp-dap" },
	{
		"Saghen/blink.cmp",
		lazy = false,
		version = "v0.*",
		dependencies = 'rafamadriz/friendly-snippets',
		opts = {
			keymap = { preset = 'default' },
			highlight = {
				use_nvim_cmp_as_default = false,
			},
			nerd_font_variant = 'mono',
			windows = {
				autocomplete = {
					border = "rounded",
					winhighlight = "Normal:NormalFloat,FloatBorder:FloatBorder,CursorLine:Visual,Search:None",
				},
				documentation = {
					border = "rounded",
					auto_show = true,
				},
			},
			sources = {
				completion = {
					enabled_providers = { "lsp", "path", "buffer", "luasnip" },
				},
				providers = {
					luasnip = {
						name = "luasnip",
						module = "blink.compat.source",

						score_offset = -3,

						opts = {
							use_show_condition = false,
							show_autosnippets = true,
						}
					}
				}
			}
		}
	},
}
