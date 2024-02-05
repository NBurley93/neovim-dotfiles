require("ibl").setup({
	indent = {
		char = "│",
		tab_char = "│",
		--highlight = { "Define" },
	},
	scope = {
		char = "│",
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
