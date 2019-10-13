""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => gv.vim plugin
" """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" " This plugin provides a user-friendly git log - ,gl for 'git log'
if &runtimepath =~ 'gv.vim'
	nmap <Leader>gl :GV<CR>
	"<leader>gv is remapped to reselect the last visual selection instead.
	"map <Leader>gv :GV<CR>
endif
