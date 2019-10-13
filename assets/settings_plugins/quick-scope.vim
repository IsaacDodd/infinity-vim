""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Quick Scope plugin
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" if exists('g:loaded_quick_scope')
if &runtimepath =~ 'quick-scope'
	" Status: Start the plugin enabled (or disable and use :QuickScopeToggle)
	let g:qs_enable=1

	" Key Mapping: Map the leader key + q to toggle quick-scope's highlighting in normal/visual mode.
	" Note that you must use nmap/xmap instead of their non-recursive versions (nnoremap/xnoremap).
	nmap <leader>qs <plug>(QuickScopeToggle)
	xmap <leader>qs <plug>(QuickScopeToggle)

	" Triggers:
	" Trigger a highlight in the appropriate direction when pressing these keys:
	let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']
	" Trigger a highlight only when pressing f and F.
	let g:qs_highlight_on_keys = ['f', 'F']

	" Colors:
	augroup qs_colors
		autocmd!
		autocmd ColorScheme * highlight QuickScopePrimary guifg='#afff5f' gui=underline ctermfg=155 cterm=underline
		autocmd ColorScheme * highlight QuickScopeSecondary guifg='#5fffff' gui=underline ctermfg=81 cterm=underline
	augroup END
endif
