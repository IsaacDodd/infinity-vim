"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Session (vim-session) plugin
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if &runtimepath =~ 'vim-session'
	" yes = always automatically save open sessions when you quit Vim; no = always decline saving when quitting
	let g:session_autosave = 'no'
	" Interval (in minutes) for periodic saving of active sessions; plug-in will not prompt for your permission.
	let g:session_autosave_periodic = 3

	" The following uses the directory name as a session name to support directory-based sessions
	let g:session_default_name = fnamemodify(getcwd(), ':t')
	nnoremap <leader>s :SaveSession<CR> " Start new session
	nnoremap <leader>sd :DeleteSession<CR> " Delete the session
	" Don't save hidden and unloaded buffers in sessions.
	set sessionoptions-=buffers

	" Don't prompt to auto-save
	let g:session_autosave = 'no'
endif
