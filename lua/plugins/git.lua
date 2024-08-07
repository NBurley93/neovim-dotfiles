return {
	{ "petertriho/cmp-git", dependencies = "nvim-lua/plenary.nvim" },
	{ "tpope/vim-fugitive" },
	{ "tpope/vim-rhubarb" },
	{
		"lewis6991/gitsigns.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			require("gitsigns").setup({
				signs = {
					add = { text = "┃" },
					change = { text = "┃" },
					delete = { text = "┃" },
					topdelete = { text = "┃" },
					changedelete = { text = "┃" },
					untracked = { text = "┃" },
				},
				signcolumn = true,
				current_line_blame = true,
				current_line_blame_opts = {
					delay = 500,
					virt_text = true,
					virt_text_pos = "eol",
				},
			})
		end,
	},
	{
		"sindrets/diffview.nvim",
		dependencies = "nvim-lua/plenary.nvim",
		config = function()
			require("diffview").setup({
				use_icons = true,
				default_args = {
					DiffviewOpen = { "--imply-local" },
				},
				merge_tool = {
					layout = "diff4_mixed",
					winbar_info = true,
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
		end,
	},
	{ "akinsho/git-conflict.nvim" },
}
