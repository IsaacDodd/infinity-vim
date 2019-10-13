""" Neovim Settings: -----------------------------------------

" Link .vimrc to init.vim
set runtimepath^=~/.vim
	set runtimepath+=~/.vim/after
	let &packpath = &runtimepath
	if has('win16') || has('win95') || has('win32') || has('win64') || has('gui_win32')
		source ~/_vimrc
	else
		source ~/.vimrc
	endif

" Root path where coc-settings.json is located.
let g:coc_config_home = '~/.vim'
