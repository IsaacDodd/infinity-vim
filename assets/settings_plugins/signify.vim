""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Signify (Sy) plugin
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if &runtimepath =~ 'vim-signify'
	" Always show the sign column so it doesn't flicker with updates
	set signcolumn=yes
	" Spare buffer loading time by only checking for relevant, commonly-used DVCS's 
	let g:signify_vcs_list = [ 'git' ]
	" Change sign changed to a less stressful character than !
	let g:signify_sign_change = '*'
	" 0 = Only check for changes when opening or saving a buffer; 1 = Check in real-time for changes (can slow down setup)
	let g:signify_realtime = 0
	" 0 = Do not update on mode changes
	let g:signify_cursorhold_normal = 0
	let g:signify_cursorhold_insert = 0
	" 0 = Do not update on opening a new buffer / focus gained
	let g:signify_update_on_bufenter = 1
	let g:signify_update_on_focusgained = 1

	" Key Mappings
	nnoremap <leader>gt :SignifyToggle<CR>
	nnoremap <leader>gh :SignifyToggleHighlight<CR>
	nnoremap <leader>gr :SignifyRefresh<CR>
	nnoremap <leader>gd :SignifyDebug<CR>

	" hunk jumping
	nmap <leader>gj <plug>(signify-next-hunk)
	nmap <leader>gk <plug>(signify-prev-hunk) 
	nmap <leader>gJ 9999<leader>gj
	nmap <leader>gK 9999<leader>gk
	" hunk text object
	omap ic <plug>(signify-motion-inner-pending)
	xmap ic <plug>(signify-motion-inner-visual)
	omap ac <plug>(signify-motion-outer-pending)
	xmap ac <plug>(signify-motion-outer-visual)
endif
