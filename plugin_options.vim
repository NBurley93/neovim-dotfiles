let NERDTreeShowHidden=1
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'

autocmd CursorHold * silent call CocActionAsync('highlight')

" autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif

let g:airline_powerline_fonts = 1
if exists("g:loaded_webdevicons")
	call webdevicons#refresh()
endif

" let g:airline_theme='minimalist'
let g:airline#extensions#whitespace#mixed_indent_algo = 1

let g:WebDevIconsNerdTreeAfterGlyphPadding = ' '
let g:WebDevIconsUnicodeDecorateFolderNodes = 1
let g:DevIconsEnableFoldersOpenClose = 1
let g:WebDevIconsNerdTreeGitPluginForceVAlign = 1

let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#formatter = 'unique_tail_improved'
let g:airline#extensions#tabline#fnamemod = ":t"
let g:airline#extensions#tabline#buffer_idx_mode = 1
