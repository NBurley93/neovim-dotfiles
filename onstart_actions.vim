au StdinReadPre * let s:std_in=1

function! SidebarOnStart()
	if argc() == 1 && isdirectory(argv()[0]) && !exists('s:std_in')
		execute 'NERDTree' argv()[0]
		winc p
		enew
		execute 'cd '.argv()[0]
	endif
endfunction

" au VimEnter * execute 'call SidebarOnStart()'
