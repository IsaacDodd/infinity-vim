

""""""""""""""""""""""""""""""
" FILETYPES
"
""""""""""""""""""""""""""""""
" These are specific to a particular file extension or programming language


""""""""""""""""""""""""""""""
" => CoffeeScript section
"""""""""""""""""""""""""""""""
"function! CoffeeScriptFold()
"    setl foldmethod=indent
"    setl foldlevelstart=1
"endfunction
"au FileType coffee call CoffeeScriptFold()

"au FileType gitcommit call setpos('.', [0, 1, 1, 0])


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => PGP section
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Transparent editing of gpg encrypted files.
" By Wouter Hanegraaff
augroup Encrypted
	autocmd!

	" First make sure nothing is written to ~/.viminfo while editing
	" an encrypted file.
	autocmd BufReadPre,FileReadPre *.gpg set viminfo=
	" We don't want a swap file, as it writes unencrypted data to disk
	autocmd BufReadPre,FileReadPre *.gpg set noswapfile

	" Switch to binary mode to read the encrypted file
	autocmd BufReadPre,FileReadPre *.gpg set bin
	autocmd BufReadPre,FileReadPre *.gpg let ch_save = &ch|set ch=2
	" (If you use tcsh, you may need to alter this line.)
	autocmd BufReadPost,FileReadPost *.gpg '[,']!gpg --decrypt 2> /dev/null

	" Switch to normal mode for editing
	autocmd BufReadPost,FileReadPost *.gpg set nobin
	autocmd BufReadPost,FileReadPost *.gpg let &ch = ch_save|unlet ch_save
	autocmd BufReadPost,FileReadPost *.gpg execute ":doautocmd BufReadPost " . expand("%:r")

	" Convert all text to encrypted text before writing
	" (If you use tcsh, you may need to alter this line.)
	autocmd BufWritePre,FileWritePre *.gpg '[,']!gpg --default-recipient-self -ae 2>/dev/null
	" Undo the encryption so we are back in the normal text, directly
	" after the file has been written.
	autocmd BufWritePost,FileWritePost *.gpg u
augroup END
" References:
"	[https://www.endpoint.com/blog/2012/05/16/vim-working-with-encryption]
"	[https://vim.wikia.com/wiki/Encryption]


""""""""""""""""""""""""""""""
" => HTML5 section
"""""""""""""""""""""""""""""""

" === matchtagalways settings
let g:mta_use_matchparen_group = 1

" === vim-closetag
" These are the file extensions where this plugin is enabled.
let g:closetag_filenames = '*.htm,*.html,*.xhtml,*.phtml'

" This will make the list of non-closing tags self-closing in the specified files.
let g:closetag_xhtml_filenames = '*.xhtml,*.jsx'

" These are the file types where this plugin is enabled.
let g:closetag_filetypes = 'htm,html,xhtml,phtml'

" This will make the list of non-closing tags self-closing in the specified files.
let g:closetag_xhtml_filetypes = 'xhtml,jsx'


""""""""""""""""""""""""""""""
" => JavaScript section
"""""""""""""""""""""""""""""""
augroup FiletypesJavaScript
	autocmd!
	au FileType javascript call JavaScriptFold()
	au FileType javascript setl fen
	au FileType javascript setl nocindent

	au FileType javascript imap <c-t> $log();<esc>hi
	au FileType javascript imap <c-a> alert();<esc>hi

	au FileType javascript inoremap <buffer> $r return
	au FileType javascript inoremap <buffer> $f // --- PH<esc>FP2xi
augroup END

function! JavaScriptFold()
    setl foldmethod=syntax
    setl foldlevelstart=1
    syn region foldBraces start=/{/ end=/}/ transparent fold keepend extend

    function! FoldText()
        return substitute(getline(v:foldstart), '{.*', '{...}', '')
    endfunction
    setl foldtext=FoldText()
endfunction


""""""""""""""""""""""""""""""
" => (Neo)vim
""""""""""""""""""""""""""""""
augroup FiletypesVim
	autocmd!
	autocmd BufNewFile,BufRead,BufReadPre,FileReadPre *.vim set ft=vim
augroup END

augroup FiletypesNeovim
	autocmd!
	autocmd BufNewFile,BufRead,BufReadPre,FileReadPre *.nvim set ft=vim
augroup END


""""""""""""""""""""""""""""""
" => Python section
""""""""""""""""""""""""""""""
let python_highlight_all = 1
augroup FiletypesPython
	autocmd!
	au FileType python syn keyword pythonDecorator True None False self

	au BufNewFile,BufRead *.jinja set syntax=htmljinja
	au BufNewFile,BufRead *.mako set ft=mako

	au FileType python map <buffer> F :set foldmethod=indent<cr>

	au FileType python inoremap <buffer> $r return
	au FileType python inoremap <buffer> $i import
	au FileType python inoremap <buffer> $p print
	au FileType python inoremap <buffer> $f # --- <esc>a
	au FileType python map <buffer> <leader>1 /class
	au FileType python map <buffer> <leader>2 /def
	au FileType python map <buffer> <leader>C ?class
	au FileType python map <buffer> <leader>D ?def
	au FileType python set cindent
	au FileType python set cinkeys-=0#
	au FileType python set indentkeys-=0#
augroup END


""""""""""""""""""""""""""""""
" => Shell section
""""""""""""""""""""""""""""""
if exists('$TMUX')
    if has('nvim')
        set termguicolors
    else
        set term=tmux-256color
        " set term=screen-256color
    endif

	" Map Ctrl + vim directionality keys to tmux window transitions
	"" nnoremap <c-j> <c-w>j
	"" nnoremap <c-k> <c-w>k
	"" nnoremap <c-h> <c-w>h
	"" nnoremap <c-l> <c-w>l

endif

""""""""""""""""""""""""""""""
" => Stata section
""""""""""""""""""""""""""""""
" TODO: Add cross-platform Stata do file running support
" http://fmwww.bc.edu/repec/bocode/t/textEditors.html#vim
" https://tcry.blogspot.com/2010/04/stata-indenting-in-vim.html
" https://stackoverflow.com/questions/22482843/indenting-stata-do-files-in-vim

augroup FiletypesStata
	autocmd!
	autocmd FileType BufNewFile,BufRead *.do,*.ado set filetype=stata
	autocmd FileType stata setlocal ts=4 sts=4 sw=4 noexpandtab
augroup END


""""""""""""""""""""""""""""""
" => Twig section
""""""""""""""""""""""""""""""
"autocmd BufRead *.twig set syntax=html filetype=html
