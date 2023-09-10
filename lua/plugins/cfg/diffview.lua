require("diffview").setup({
	use_icons = true,
	default_args = {
		DiffviewOpen = { "--imply-local" },
	},
	keymaps = {
		file_panel = {
			{
				"n",
				"cc",
				"<Cmd>Git commit <bar> wincmd J<cr>",
				{ desc = "Commit staged changes" },
			},
			{
				"n",
				"ca",
				"<Cmd>Git commit --amend <bar> wincmd J<cr>",
				{ desc = "Amend last commit" },
			},
		},
	},
})
