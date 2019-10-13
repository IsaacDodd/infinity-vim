"""""""""""""""""""""""""""""""""""""""
" => Tagbar plugin / Vista.vim plugin "
"""""""""""""""""""""""""""""""""""""""
" If ctags is installed, these plugins. If coc.nvim is used, choose Vista. Else, choose TagBar.
if executable('ctags')
	if g:vimsetup_autocompletion=='coc.nvim'
		" Vista:

		" Map the main key mappings for Vista.vim instead of TagBar.
		nmap <F8> :Vista!!<CR>
		nmap <leader>tb :Vista!!<CR>

		" Additional Key mappings
		if executable('fzf')
			nnoremap <silent><leader>vf :Vista finder coc<CR>
		endif

		let g:vista_default_executive = 'ctags'

		let g:vista_executive_for = {
		  \ 'go': 'ctags',
		  \ 'javascript': 'coc',
		  \ 'typescript': 'coc',
		  \ 'javascript.jsx': 'coc',
		  \ 'python': 'coc',
		  \ 'c': 'coc',
		  \ }

		" Ensure you have installed some decent font to show these pretty symbols, then you can enable icon for the kind.
		let g:vista#renderer#enable_icon = 1

		" The default icons can't be suitable for all the filetypes, you can extend it as you wish.
		let g:vista#renderer#icons = {
		\   "function": "\uf794",
		\   "variable": "\uf71b",
		\  }

		" let g:vista_icon_indent = ["╰─▸ ", "├─▸ "]
		let g:vista_icon_indent = ["➤ ", ""]


		if executable('typescript-language-server')
		  au User lsp_setup call lsp#register_server({
			  \ 'name': 'typescript-language-server',
			  \ 'cmd': {server_info->[&shell, &shellcmdflag, 'typescript-language-server --stdio']},
			  \ 'root_uri':{server_info->lsp#utils#path_to_uri(lsp#utils#find_nearest_parent_file_directory(lsp#utils#get_buffer_path(), 'tsconfig.json'))},
			  \ 'whitelist': ['typescript', 'typescript.tsx'],
			  \ })
		endif
		" References:
		" 	[https://github.com/davemackintosh/dotfiles/blob/master/.config/nvim/configs/vista.vim]
		" 	[https://github.com/liuchengxu/vista.vim]

	else
		" Tagbar:
		" Use the Tagbar plugin instead of Vista.vim
		nmap <F8> :TagbarToggle<CR>
		nmap <leader>tb :TagbarToggle<CR>
	endif
endif
