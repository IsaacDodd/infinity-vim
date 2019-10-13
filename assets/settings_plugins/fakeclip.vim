""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => FakeClip plugin
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if !exists('$TMUX') && &runtimepath =~ 'vim-fakeclip'
	" If in a regular Vim session, turn off fakeclip (i.e., turn on FakeClip key remappings only in Tmux)
	let g:fakeclip_no_default_key_mappings = 1
endif
