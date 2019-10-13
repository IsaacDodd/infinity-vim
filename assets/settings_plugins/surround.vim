"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Surround.vim plugin
" Annotate strings with gettext 
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if &runtimepath =~ 'vim-surround'
	vmap Si S(i_<esc>f)
	au FileType mako vmap Si S"i${ _(<esc>2f"a) }<esc>
endif
