"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Ack.vim (using Ag) plugin
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Ack searching and cope displaying
"    (requires ack.vim - it's much better than vimgrep/grep)
" Use Ag with ack.vim (so Ack doesn't have to be pre-installed)
" Use the the_silver_searcher if possible (much faster than Ack)
if executable('rg')
	let g:ackprg = 'rg --vimgrep --no-heading'
elseif executable('ag')
	let g:ackprg = 'ag --vimgrep --smart-case'
endif
" This has the same effect as let g:ackprg = 'ag --nogroup --nocolor --column' but will report every match on a given line
" References:
" 	http://www.philipbradley.net/ripgrep-with-ctrlp-and-vim/

if &runtimepath =~ 'ack.vim'
	" When you press gv you Ack after the selected text
	vnoremap <silent> gv :call VisualSelection('gv', '')<CR>

	" Open Ack and put the cursor in the right position
	map <leader>ac :Ack

	" When you press <leader>r you can search and replace the selected text
	vnoremap <silent> <leader>r :call VisualSelection('replace', '')<CR>

	" Do :help cope if you are unsure what cope is. It's super useful!
	"
	" When you search with Ack, display your results in cope by doing:
	"   <leader>cc
endif
