"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Goyo (Vimroom) plugin
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if &runtimepath =~ 'goyo.vim'
	let g:goyo_width=120
	let g:goyo_margin_top = 2
	let g:goyo_margin_bottom = 2

	" ,df = [D]istraction [F]ree view
	nnoremap <silent> <leader>df :Goyo<cr>
endif
