let mapleader="\<space>"
noremap <leader>w :w<cr>
noremap <leader><home> :source $MYVIMRC<cr>
nnoremap <leader>xx <cmd>TroubleToggle<cr>
noremap <leader>q :q<cr>
noremap <leader>Q :qa<cr>

nnoremap <leader><left> :topleft vnew<cr>
nnoremap <leader><right> :botright vnew<cr>
nnoremap <leader><up> :topleft new<cr>
nnoremap <leader><down> :botright new<cr>

nnoremap <kDivide> <C-W>_
nnoremap <kPlus> <C-W><BAR>
nnoremap <kMinus> <C-W>=

nnoremap <leader><TAB> <C-w>w

nnoremap <C-H> <C-W>h
nnoremap <C-J> <C-W>j
nnoremap <C-K> <C-W>k
nnoremap <C-L> <C-W>l

nnoremap <leader>bn :enew<cr>
nnoremap <leader>b= :bnext<cr>
nnoremap <leader>b- :bprev<cr>
nnoremap <leader>bc :bd<cr>

"nmap <silent> gd <Plug>(coc-definition)
"nmap <silent> gy <Plug>(coc-type-definition)
"nmap <silent> gi <Plug>(coc-implementation)
"nmap <silent> gr <Plug>(coc-references)

nnoremap <leader>gb :Git blame<cr>
nnoremap <leader>gd :Git difftool<cr>


inoremap <silent><expr> <TAB>
	\ coc#pum#visible() ? coc#pum#next(1) :
	\ CheckBackspace() ? "\<Tab>" :
	\ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

inoremap <silent><expr> <c-space> coc#refresh()

inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
								\: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

nnoremap <silent> K :call ShowDocumentation()<cr>

nmap <leader>rn <Plug>(coc-rename)

xmap <leader>f <Plug>(coc-format-selected)
nmap <leader>f <Plug>(coc-format-selected)

nmap <leader>cl <Plug>(coc-codelens-action)
nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
  inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
  vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"

nnoremap <silent><nowait> <leader>a :<C-u>CocList diagnostics<cr>
nnoremap <silent><nowait> <leader>e :<C-u>CocList extensions<cr>
nnoremap <silent><nowait> <leader>c :<C-u>CocList commands<cr>
nnoremap <silent><nowait> <leader>o :<C-u>CocList outline<cr>
nnoremap <silent><nowait> <leader>s :<C-u>CocList -I symbols<cr>

nnoremap <leader>N :call NumberColumnToggle()<CR>
