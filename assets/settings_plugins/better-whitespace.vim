""""""""""""""""""""""""""""""
" => better-whitespace plugin (ntpeters/vim-better-whitespace)
""""""""""""""""""""""""""""""
if &runtimepath =~ 'vim-better-whitespace'
	" 0 = Hide trailing whitespace at end of lines at start (use :ToggleWhitespace as needed instead)
	let g:better_whitespace_enabled=0
	" 0 = don't strip whitespaces on saving (leave them, and use :StripWhitespace as needed instead)
	let g:strip_whitespace_on_save=0
endif
