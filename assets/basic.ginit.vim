""" Neovim GUI Settings: -----------------------------------------
" Reference: [https://github.com/jdhao/nvim-config/blob/master/ginit.vim]
" To check if neovim-qt is running, use `exists("g:GuiLoaded")`,
" see https://github.com/equalsraf/neovim-qt/issues/219
if exists("g:GuiLoaded")
	" call GuiWindowMaximized(1)
	GuiTabline 0
	GuiPopupmenu 0
	GuiLinespace 2
	if has("win16") || has("win32") || has("win64")
		GuiFont! Hack:h10:l
	endif

	" Use shift+insert for paste inside neovim-qt,
	" see https://github.com/equalsraf/neovim-qt/issues/327#issuecomment-325660764
	inoremap <silent>  <S-Insert>  <C-R>+
	cnoremap <silent> <S-Insert> <C-R>+

	" For Windows, Ctrl-6 does not work. So we use this mapping instead.
	nnoremap <silent> <C-6> <C-^>
endif
