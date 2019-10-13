""""""""""""""""""""""""""""""
" => indentLine plugin
""""""""""""""""""""""""""""""
if &runtimepath =~ 'indentLine'
	let g:indentLine_enabled = 1
	filetype plugin indent on    " required

	" Windows to exclude indentation markers from
	let g:indentLine_fileTypeExclude = ['defx', 'denite', 'startify', 'tagbar', 'vista_kind', 'vista']
	let g:indentLine_concealcursor = 0
	let g:indentLine_faster = 1
	" Each indentation level will have a distinct character
	" let g:indentLine_char_list = ['|', '¦', '┆', '┊']
endif
