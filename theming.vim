
set termguicolors
augroup my_color_scheme
	autocmd!
	autocmd ColorScheme * highlight Normal ctermbg=NONE guibg=NONE
	autocmd ColorScheme * highlight NonText guibg=NONE ctermbg=NONE
	autocmd ColorScheme * highlight EndOfBuffer ctermbg=NONE guibg=NONE
augroup END
colorscheme cyberpunk_scarlet
