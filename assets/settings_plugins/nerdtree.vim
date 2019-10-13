"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => NERDTree plugin
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if &runtimepath =~ 'nerdtree'

	let g:NERDTreeHighlightFolders = 1
	let g:NERDTreeHighlightFoldersFullName = 1
	let NERDTreeHijackNetrw=1
	let NERDTreeShowHidden=0

	" Default size of nerd tree = 35 lines
	let g:NERDTreeWinSize=35

	" Default position of tree = on the left (not right)
	let g:NERDTreeWinPos = "left"

	" let NERDTreeShowHidden=0
	let NERDTreeIgnore = ['\.pyc$', '__pycache__']

	" Toggle nerdtree with <leader>nt - maps these specific keys as a shortcut to open NERDTree; 
	" 	db = directory bar, eb = explorer bar - These are redundant to be consistent with other leader key mappings (i.e., tb for tag bar)
	noremap <leader>nt :NERDTreeToggle<cr>
	noremap <leader>db :NERDTreeToggle<cr>
	noremap <leader>eb :NERDTreeToggle<cr>
	" map <C-n> :NERDTreeToggle<CR>
	map <F10> :NERDTreeToggle<CR>
	noremap <leader>nb :NERDTreeFromBookmark<Space>
	" Show where current file is in nerdtree
	noremap <leader>nf :NERDTreeFind<cr>
	map <F9> :NERDTreeFind<CR>

	" Set PWD (present working directory): 2 = PWD is set to the directory it is initialized in when NERDTree first loads and changed whenever the tree root is changed
	let g:NERDTreeChDirMode=2

	" Opens a NERDTree automatically when vim starts up if no files were specified (to start vim with plain vim, not vim .)
	augroup PluginNERDTreeGroup
		autocmd!
		autocmd StdinReadPre * let s:std_in=1
		autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
		" Opens NERDTree automatically when vim starts up on opening a directory and sets the PWD of the new edit window
		"	Also uses the same NerdTree for all windows in the tab && prevents NERDTree from hiding when first selecting a file
		autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | exe 'cd '.argv()[0] | endif

		" Closes vim if the only window left open is a NERDTree
		autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
	augroup END

	" Change the default arrow symbols; -- [/so/5853994] - ◄ = &#9668; ► = &#9658; ▼ = &#9660; ▲ = &#9650; ➤ = &#x27A4; 📂
	" let g:NERDTreeDirArrowExpandable = '📁'
	" let g:NERDTreeDirArrowCollapsible = '📂'
	" let g:NERDTreeDirArrowExpandable = '➤'
	" let g:NERDTreeDirArrowCollapsible = '▼'
	" let g:NERDTreeDirArrowExpandable = '▸'
	" let g:NERDTreeDirArrowCollapsible = '▾'
	" let g:NERDTreeDirArrowExpandable = '⇨'
	" let g:NERDTreeDirArrowCollapsible = '⇩'
	" let g:NERDTreeDirArrowExpandable = '►'
	" let g:NERDTreeDirArrowCollapsible = '▼'
	" let g:NERDTreeDirArrowExpandable = '⮚'
	" let g:NERDTreeDirArrowCollapsible = '⮛'
	" let g:NERDTreeDirArrowExpandable = '⯈'
	" let g:NERDTreeDirArrowCollapsible = '⯆'
	if g:vimsetup_platform == 'win'
		let g:NERDTreeDirArrowExpandable = '⯈'
		let g:NERDTreeDirArrowCollapsible = '⯆'
	else
		let g:NERDTreeDirArrowExpandable = '⇨'
		let g:NERDTreeDirArrowCollapsible = '▼'
	endif

	" Expandable/Closed Arrow Characters '➤'► ⇨ ↦  → ↠ ⇛ ⇨ ⇒ ⇾ ⇰ ⇢ ⥤ ⮱ ⮩ ⮚⮞ ⮊ ⮕ ⮡ ⯈ 
	" Collapsible/Open Arrow Characters ⮶ ⮮⮟ ⮛ ⮋ ⮦ ⯆ ▼⇓⬇
	" References:
	" 	https://unicode-table.com/en/1F4C2/
	" 	https://www.key-shortcut.com/en/writing-systems/35-symbols/arrows/
	let g:NERDTreeIndicatorMapCustom = {
        \ "modified"  : "✹",
        \ "staged"    : "✚",
        \ "untracked" : "✭",
        \ "renamed"   : "➜",
        \ "unmerged"  : "=",
        \ "deleted"   : "✖",
        \ "dirty"     : "✗",
        \ "clean"     : "✔︎",
        \ 'ignored'   : '☒',
        \ "unknown"   : "?"
        \ }

endif
