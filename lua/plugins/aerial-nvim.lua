return {
	{
		"stevearc/aerial.nvim",
        event = { "BufReadPost", "BufNewFile" },
		opts = {
			backends = { "lsp", "treesitter", "markdown", "asciidoc", "man" },
			layout = {
				default_direction = "prefer_left",
				min_width = 25,
			},
			close_automatic_events = { "unfocus" },
			close_on_select = true,
			autojump = true,
			filter_kind = {
				"Array",
				"Boolean",
				"Class",
				"Constant",
				"Constructor",
				"Enum",
				"EnumMember",
				"Event",
				"Field",
				"File",
				"Function",
				"Interface",
				"Key",
				"Method",
				"Module",
				"Namespace",
				"Null",
				"Number",
				"Object",
				"Operator",
				"Package",
				"Property",
				"String",
				"Struct",
				"TypeParameter",
				"Variable",
			},
			highlight_on_hover = true,

			show_guides = true,
		},
		-- Optional dependencies
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
			require("common.defines").WEB_DEVICONS_PROVIDER,
		},
	},
}
