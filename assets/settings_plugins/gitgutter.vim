"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => GitGutter (aka Git diff) plugin
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if &runtimepath =~ 'vim-gitgutter'
	" 1 = enable GitGutter by default on startup; 0 = disable by default
	let g:gitgutter_enabled=1
	" ,gg = Git Gutter (the name is intuitive enough)
	nnoremap <silent> <leader>gg :GitGutterToggle<cr>

	" Jump between hunks -- References: [https://jakobgm.com/posts/vim/git-integration/]
	nmap <Leader>gn <Plug>GitGutterNextHunk<CR>			" git next
	nmap <Leader>gp <Plug>GitGutterPrevHunk<CR>			" git previous
	nmap <Leader>ga <Plug>GitGutterStageHunk<CR>		" git add (chunk)
	nmap <Leader>gu <Plug>GitGutterUndoHunk<CR>			" git undo (chunk)
elseif &runtimepath =~ 'vim-signify'
	" If GitGutter is not enabled and Signify is available instead, map its toggle key binding to Signify
	nnoremap <silent> <leader>gg :SignifyToggle<cr>
endif
