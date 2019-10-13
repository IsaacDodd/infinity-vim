"""""""""""""""""""""""""""""""""""""""""""""
" => Fugitive plugin
"""""""""""""""""""""""""""""""""""""""""""""
if &runtimepath =~ 'vim-fugitive'
	" Key mappings
	nnoremap <leader>g :G<CR>
	nnoremap <leader>gd :Gdiff<CR>
	nnoremap <leader>gb :Gblame<CR>
	nnoremap <leader>gc :Gcommit<CR>

	nnoremap <leader>G <nop>
	nnoremap <leader>GS :<c-u>Gstatus<cr>
	nnoremap <leader>GE :<c-u>Gedit<cr>
	nnoremap <leader>GD :<c-u>Gdiff<cr>
	nnoremap <leader>GB :<c-u>Gblame -w<cr>
	nnoremap <leader>GC :<c-u>Gcommit<cr>
	nnoremap <leader>GY :<c-u>Gpull<cr>
	nnoremap <leader>GP :<c-u>Gpush<cr>
endif
