""""""""""""""""""""""""""""""
" => Gundo plugin
""""""""""""""""""""""""""""""
if &runtimepath =~ 'gundo.vim'
	" Map key to ,ub for [u]ndo[b]ar to follow the TagBar nomenclature
	nnoremap <Leader>ub :GundoToggle<CR>
	let g:gundo_right = 1
endif
