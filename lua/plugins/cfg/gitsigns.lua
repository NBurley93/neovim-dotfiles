require("gitsigns").setup({
	signs = {
		add = { text = "│" },
		change = { text = "│" },
		delete = { text = "_" },
		topdelete = { text = "‾" },
		changedelete = { text = "~" },
		untracked = { text = "┆" },
	},
	signcolumn = true,
	current_line_blame = true,
	current_line_blame_opts = {
		delay = 500,
		virt_text = true,
		virt_text_pos = "eol",
	},
})
