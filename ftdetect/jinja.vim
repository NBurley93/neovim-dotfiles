if &compatible || v:version < 603
    finish
endif

autocmd BufNewFile,BufRead *.jinja,*jinja2,*.j2 set filetype=jinja
