vim.cmd([[
augroup my_color_scheme
	autocmd!
	autocmd ColorScheme * highlight Normal ctermbg=NONE guibg=NONE
	autocmd ColorScheme * highlight NonText guibg=NONE ctermbg=NONE
	autocmd ColorScheme * highlight EndOfBuffer ctermbg=NONE guibg=NONE
	autocmd ColorScheme * highlight SignColumn ctermbg=NONE guibg=NONE
	autocmd ColorScheme * hi MsgArea guibg=NONE
	" autocmd ColorScheme * hi FloatBorder guibg=NONE
	autocmd ColorScheme * hi NormalNC guibg=NONE
	autocmd ColorScheme * hi VertSplit guibg=NONE
	autocmd ColorScheme * hi ErrorMsg guibg=NONE ctermbg=NONE
	autocmd ColorScheme * hi CursorLineNr guibg=#ff0055
	autocmd ColorScheme * hi CursorLine guibg=NONE
	autocmd ColorScheme * hi GitSignsCurrentLineBlame guifg=#b3b3b3
augroup END
]])
vim.cmd('colorscheme 2077')
