"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Numbers.vim plugin
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if &runtimepath =~ 'numbers.nvim'
	" If you see numbers where they don't belong like in the help menus or other vim plugins be sure to add your plugins to the excludes list in your vimrc like so
	let g:numbers_exclude = ['tagbar', 'vista', 'startify', 'gundo', 'vimshell', 'w3m', 'minibufexpl', 'nerdtree', 'MRU', 'fugitive']
	nnoremap <Leader>nn :NumbersToggle<CR>
	nnoremap <Leader>no :NumbersOnOff<CR>
endif
