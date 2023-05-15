return {
	config = function()
		vim.cmd([[
				augroup my_color_scheme
					autocmd!
					autocmd ColorScheme * highlight Normal ctermbg=NONE guibg=NONE
					autocmd ColorScheme * highlight NonText guibg=NONE ctermbg=NONE
					autocmd ColorScheme * highlight EndOfBuffer ctermbg=NONE guibg=NONE
					autocmd ColorScheme * highlight SignColumn ctermbg=NONE guibg=NONE
					autocmd ColorScheme * hi MsgArea guibg=NONE
					autocmd ColorScheme * hi NormalNC guibg=NONE
					autocmd ColorScheme * hi VertSplit guibg=NONE
					autocmd ColorScheme * hi ErrorMsg guibg=NONE ctermbg=NONE
				augroup END
				]])
		-- vim.cmd("colorscheme cyberpunk_scarlet")
		vim.cmd('colorscheme 2077')
		-- vim.cmd('colorscheme hackerman')
	end,
}
