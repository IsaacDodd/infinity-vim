""""""""""""""""""""""""""""""
" => CTRL-P (ctrlp) plugin
""""""""""""""""""""""""""""""
if &runtimepath =~ 'ctrlp.vim'
	" 0 = disable; c=PWD; a = Set to search the directory of the current file unless it is a subdirectory of the CWD; r = nearest ancestor to directory with a known dot directory (e.g., .git)
	let g:ctrlp_working_path_mode = 'ca'
	let g:ctrlp_use_caching = 1

	" (1) Map the ctrlp function to '<Leader>p'
	let g:ctrlp_map = '<Leader>p'
	nnoremap <leader>p :CtrlP<cr>

	" (2) Map the ctrlp function also to ',j'
	map <leader>j :CtrlP<cr>
	map <leader>fp :CtrlP<cr>
	map <leader>pb :CtrlPBuffer<cr>

	let g:ctrlp_max_height = 20
	let g:ctrlp_custom_ignore = 'node_modules\|^\.DS_Store\|^\.git\|^\.coffee'

	if executable('rg')
		let g:ctrlp_user_command = 'rg --files %s'
		let g:ctrlp_use_caching = 0
		let g:ctrlp_working_path_mode = 'ra'
		let g:ctrlp_switch_buffer = 'et'
	endif
endif
