require("ibl").setup({
	indent = {
		char = "▎",
		tab_char = nil,
	},
	scope = {
		char = "▎",
	},
	exclude = {
		buftypes = {
			"nvimtree",
		},
		filetypes = {
			"dashboard",
			"mason",
			"toggleterm",
		},
	},
})
