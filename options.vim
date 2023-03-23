syntax on
filetype plugin indent on
set fileformat=unix
set updatetime=300
set encoding=utf-8
set title
set guifont=3270\ NFM:h14
set number
set autoindent
set tabstop=4
set shiftwidth=4
set backspace=2
set clipboard=unnamedplus
set signcolumn=yes

if has('win32') || has('win32unix')
	let g:python3_host_prog = '~\.pyenv\pyenv-win\versions\3.11.2\python.exe'
endif
