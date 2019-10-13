""""""""""""""""""""""""""""""""""""""""""""""""""
" => vim-bookmarks plugin
""""""""""""""""""""""""""""""""""""""""""""""""""

if &runtimepath =~ 'vim-bookmarks'

	""" Keymappings: --------------------------------------------------

	" Reserved by other plugins: ml, md, and mu

	" Toggle: Add/remove bookmark at current line
	nmap <Leader>mm <Plug>BookmarkToggle
	" Insert: Add/edit/remove annotation at current line (mark insert)
	nmap <Leader>mi <Plug>BookmarkAnnotate
	" All: Show all bookmarks
	nmap <Leader>ma <Plug>BookmarkShowAll
	" Navigation: Jump to next/previous bookmark in the buffer
	nmap <Leader>mj <Plug>BookmarkNext
	nmap <Leader>mk <Plug>BookmarkPrev
	nmap <Leader>mn <Plug>BookmarkNext
	nmap <Leader>mp <Plug>BookmarkPrev
	" Clear: (Current Buffer) Clear bookmarks in current buffer only
	nmap <Leader>mc <Plug>BookmarkClear
	" Extinguish: (All Open Buffers) Extinguish / Clear bookmarks in all open buffers
	nmap <Leader>mx <Plug>BookmarkClearAll
	" Move Bookmarks: Move bookmarks from one line to another (can be given a count)
	nmap <Leader>mK <Plug>BookmarkMoveUp
	nmap <Leader>mJ <Plug>BookmarkMoveDown
	nmap <Leader>mg <Plug>BookmarkMoveToLine
endif
