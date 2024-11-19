return {
	{
		"Saghen/blink.cmp",
		lazy = false,
		version = "v0.5.*",
		dependencies = {
            'rafamadriz/friendly-snippets',
            'saghen/blink.compat',
            { 'petertriho/cmp-git', lazy = true },
        },
		opts = {
			accept = {
				auto_brackets = {
					enabled = true,
				},
			},
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
					enabled_providers = { "lsp", "path", "buffer", "lazydev", "git" },
				},
				providers = {
                    lsp = { fallback_for = {"lazydev"}},
                    lazydev = {
                        name = "LazyDev",
                        module = "lazydev.integrations.blink",
                    },
                    git = {
                        name = 'git',
                        module = 'blink.compat.source',

                        score_offset = -3,

                        opts = {
                            filetypes = { "gitcommit" },
                            remotes = { "upstream", "origin" },
                        },
                    },
				},
			},
		},
	},
}
