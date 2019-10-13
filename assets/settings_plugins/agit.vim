""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Agit plugin
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" This plugin is a gitk clone; provides a user-friendly git log - Therefore, map it to ,gl for 'git log'
if &runtimepath =~ 'agit.vim'
	nmap <Leader>gl :Agit<Cr>
endif
