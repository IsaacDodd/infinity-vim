""""""""""""""""""""""""""""""""""""""""
" => CTRL-SF (ctrlsf) plugin
""""""""""""""""""""""""""""""""""""""""
if &runtimepath =~ 'ctrlsf.vim'
	nnoremap <leader>fs :CtrlSF<CR>
	nmap <leader>fst :CtrlSFToggle<CR>
	nmap <leader>fsr :CtrlSF -R ""<Left>

	if executable('rg')
		if has("macunix")
			let g:ctrlsf_ackprg = '/usr/local/bin/rg'
		elseif has("unix")
			let g:ctrlsf_ackprg = '/usr/bin/rg'
		endif
	endif
	" Reference: https://github.com/jeremyckahn/dotfiles/blob/master/.vimrc
endif
