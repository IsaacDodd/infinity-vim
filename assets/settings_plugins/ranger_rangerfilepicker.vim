""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Ranger (ranger.vim and rangerFilePicker.vim) / LF (listfiles) plugin
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if executable('ranger')
	" Plugin: Ranger.vim
	let g:ranger_map_keys = 0
	let g:lf_map_keys = 0
	map <leader>r :RangerNewTab<CR>
	" Show hidden files by default
	let g:ranger_command_override = 'ranger --cmd "set show_hidden=true"'
	" Plugin: RangerFilePicker.vim
	let g:ranger_remap_key = 1
		nnoremap <leader>rc :RangerChooser<CR>
	let g:ranger_remap_key_tab = 1
		nnoremap <leader>rt :RangerChooserTab<CR>
	let g:ranger_remap_key_split = 1
		nnoremap <leader>rs :RangerChooserSplit<CR>
	let g:ranger_remap_key_vsplit = 1
		nnoremap <leader>rv :RangerChooserVsplit<CR>
elseif executable('lf')
	" Plugin: lf.vim
	let g:ranger_map_keys = 0
	let g:lf_map_keys = 0
	map <leader>r :LfNewTab<CR>
	" Show hidden files by default
	let g:lf_command_override = 'lf --cmd "set show_hidden=true"'
endif
