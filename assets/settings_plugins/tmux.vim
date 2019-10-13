""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Tmux plugins (vim-tmux-navigator, tbone, ...)
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Tmux Keybindings:
"	This remaps Ctrl + h,j,k,l to pane movements in Tmux (and if Tmux isn't running, remaps them for movements with Vim's windows)
if exists('$TMUX')
	function! TmuxOrSplitSwitch(wincmd, tmuxdir)
		let previous_winnr = winnr()
		silent! execute "wincmd " . a:wincmd
		if previous_winnr == winnr()
			call system("tmux select-pane -" . a:tmuxdir)
			redraw!
		endif
	endfunction
	
	let previous_title = substitute(system("tmux display-message -p '#{pane_title}'"), '\n', '', '')
	let &t_ti = "\<Esc>]2;vim\<Esc>\\" . &t_ti
	let &t_te = "\<Esc>]2;". previous_title . "\<Esc>\\" . &t_te
	
	nnoremap <silent> <C-h> :call TmuxOrSplitSwitch('h', 'L')<cr>
	nnoremap <silent> <C-j> :call TmuxOrSplitSwitch('j', 'D')<cr>
	nnoremap <silent> <C-k> :call TmuxOrSplitSwitch('k', 'U')<cr>
	nnoremap <silent> <C-l> :call TmuxOrSplitSwitch('l', 'R')<cr>
else
	map <C-h> <C-w>h
	map <C-j> <C-w>j
	map <C-k> <C-w>k
	map <C-l> <C-w>l
endif

" Tmux Clipboard Behavior: With Tmux, make copying/pasting to the system clipboard easier
if exists('$TMUX')
	"" set clipboard=unnamedplus
	"" " Prevent x from overriding the clipboard but give it its normal behavior.
	"" noremap x "_x
	"" noremap X "_x
	"" " Reference: https://github.com/nickjj/dotfiles/blob/master/.vimrc

	" Strategies: clip.exe for WSL
	if g:vimsetup_platform == 'wsl' && executable("clip.exe")
		" Strategy 1: Use copy.exe Copying to clipboard to a temporary swap file.
		" copy (write) highlighted text to clipbuffer
		"vmap <C-c> :w! ~/.vim/temp_dirs/swap/clipbuffer.swp \| !cat ~/.vim/temp_dirs/swap/clipbuffer.swp \| clip.exe <CR><CR>
		"vmap <C-c> y:new ~/.vim/temp_dirs/swap/clipbuffer.swp<CR>ggVGp:w<CR>:bwipeout<CR> :!cat ~/.vim/temp_dirs/swap/clipbuffer.swp \| clip.exe <CR><CR>
		vmap <silent> <Leader>c y:new ~/.vim/temp_dirs/swap/clipbuffer.swp<CR>ggVGp:w<CR>:bwipeout<CR>:silent !cat ~/.vim/temp_dirs/swap/clipbuffer.swp \| clip.exe <CR>:redraw!<CR>gv
		" cut text
		vmap <silent> <Leader>x d:new ~/.vim/temp_dirs/swap/clipbuffer.swp<CR>ggVGp:w<CR>:bwipeout<CR>:silent !cat ~/.vim/temp_dirs/swap/clipbuffer.swp \| clip.exe <CR>:redraw!<CR>
		" paste from buffer
		map <silent> <Leader>v :-1read ~/.vim/temp_dirs/swap/clipbuffer.swp<CR>
	"" elseif executable("clip.exe") && has('clipboard')
	"" 	" Strategy 2: Use copy.exe Copying to clipboard, but use Vim's 'system' function to call clip.exe
	"" 	function! WSLGetSelectedText()
	"" 		normal gv"xy
	"" 		let result = getreg("x")
	"" 		return result
	"" 	endfunction
	"" 	" Keybindings
	"" 	noremap <C-C> :call system('clip.exe', WSLGetSelectedText())<CR>
	"" 	noremap <C-X> :call system('clip.exe', WSLGetSelectedText())<CR>gvx
	"" 	" Reference: https://stackoverflow.com/questions/44480829/how-to-copy-to-clipboard-in-vim-of-bash-on-windows
	elseif (g:vimsetup_platform=='wsl' && executable("xclip") && has('clipboard')) || (g:vimsetup_platform=='linux' && executable("xclip"))
		" Yank/put from/to the + register
		set clipboard ^=unnamedplus
		vmap <Leader>c "ry:call system('xclip -selection c', @r)<CR>
		vmap <Leader>x "rd:call system('xclip -selection c', @r)<CR>
		map <Leader>v "+p
		" Reference:
		"	https://stackoverflow.com/questions/45362175/vim-copy-and-paste-between-remote-vim-instances-using-tmux
		"	http://squidarth.com/programming/2018/12/14/tmux-linux.html
	elseif (g:vimsetup_platform=='mac') && executable('pbcopy')
		" Yank/put from/to the * register
		set clipboard ^=unnamed
	else
		" Strategy 3: Set up the prerequisites for an X server (i.e., VcXsrv) to copy to the clipboard instead for X-forwarding
		"export DISPLAY=localhost:0
	endif
	" References: https://stackoverflow.com/a/46995591
else
	" Remap these keys to the system clipboard for normal register usage in normal circumstances
	vmap <Leader>c "+y
	vmap <Leader>x "+d
	map <Leader>v "+p
endif


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Tmux Complete plugin
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"" let g:tmuxcomplete#asyncomplete_source_options = {
""             \ 'name':      'TC',
""             \ 'whitelist': ['*'],
""             \ 'config': {
""             \     'splitmode':      'words',
""             \     'filter_prefix':   1,
""             \     'show_incomplete': 1,
""             \     'sort_candidates': 0,
""             \     'scrollback':      0,
""             \     'truncate':        0
""             \     }
""             \ }
" Name: change how it appears in the pop-up
" Whitelist: enable this integration only for certain filetypes (or all filetypes with *)
" Split Mode: words, lines, ilines, or ilines,words
" Filter Prefix: filter candidates based on the entered text, this usually gives faster results
" Show Incomplete: start showing candidates as soon as they come in
" Sort Candidates: Controls whether we sort candidates from tmux externally. If it's enabled we can't get early incomplete results
" Scrollback: if positive we will consider that many lines in each tmux pane's history for completion
" Truncate: only prefixes of the matches up to this length are shown in the completion pop-up
"
" References:
" 	https://github.com/wellle/tmux-complete.vim
