"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Emmet plugin
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if &runtimepath =~ 'emmet-vim'
	" a = inv = Enable all functions in all modes; n = normal mode only; i = insert mode only; v = visual mode only
	let g:user_emmet_mode='a'
	" 0 = Enable just for HTML/CSS files, not globally on all files
	let g:user_emmet_install_global = 0
	augroup PluginEmmetGroup
		autocmd!
		autocmd FileType html,css EmmetInstall
	augroup END
	" Redefine trigger key (default is Ctrl-Y+,)
	"let g:user_emmet_leader_key='<C-Z>'
endif
