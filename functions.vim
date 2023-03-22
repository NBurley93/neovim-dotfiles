
function! ShowDocumentation()
	if CocAction('hasProvider', 'hover')
		call CocActionAsync('doHover')
	else
		call feedkeys('K', 'in')
	endif
endfunction


function! NumberColumnToggle()
	if (&nu == 1)
		set nu!
		set rnu
	else
		set nornu
		set nu
	endif
endfunction

function! CheckBackspace() abort
	let col = col('.') - 1
	return !col || getline('.')[col - 1] =~# '\s'
endfunction
