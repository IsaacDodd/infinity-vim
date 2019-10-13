""""""""""""""""""""""""""""""
" => snipMate (beside <TAB> support <CTRL-j>)
""""""""""""""""""""""""""""""
if &runtimepath =~ 'vim-snipmate'
	inoremap <c-j> <c-r>=snipMate#TriggerSnippet()<cr>
	snoremap <c-j> <esc>i<right><c-r>=snipMate#TriggerSnippet()<cr>
endif
