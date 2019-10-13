""""""""""""""""""""""""""""""
" => Buffet (vim-buffet) plugin
""""""""""""""""""""""""""""""
if &runtimepath =~ 'vim-buffet'
	" Use powerline separators in between buffers and tabs in the tabline 
	let g:buffet_powerline_separators = 1
	" Use Vim-Devicons: show file type icons for each buffer in the tabline
	let g:buffet_use_devicons = 1
	" Specify Devicons 
	let g:buffet_tab_icon = "\uf00a"
	let g:buffet_left_trunc_icon = "\uf0a8"
	let g:buffet_right_trunc_icon = "\uf0a9"
endif
