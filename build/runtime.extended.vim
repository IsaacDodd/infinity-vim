

"##############################################################
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""#
"
" EXTENDED CONFIGURATION
"
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""#
"##############################################################



"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" VIMRC - Extended.Vim
" (Originally based on the .vimrc by Amir Salihefendic — @amix3k)
"
" Sections:
"	 -> Privacy & Security
"    -> Backups (Files, backups and undo)
"    -> Persistent Undo
"    -> GUI-related
"    -> Fast editing and reloading of vimrc configs
"    -> Command mode related
"    -> Parenthesis/bracket
"    -> General abbreviations
"    -> Omni complete functions
"    -> Helper functions
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Privacy & Security
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"set exrc		" forces Vim to source a .vimrc file if it's present in the working directory to set project-specific configs
"set secure		" restrict usage of some commands in non-default .vimrc files
" Reference: http://www.alexeyshmalko.com/2014/using-vim-as-c-cpp-ide/

" SecureModeToggle: Set a cluster of settings at once that makes the current buffer and session more secure.
" 	This also resets viminfo, which will stop this file from saving data about ALL open files (global), not just the buffer where the function is called.
nnoremap <Leader>sec :call SecureModeToggle()<Cr>
command! SecureToggle SecureModeToggle()
let g:SecureModeToggle=0

function! SecureModeToggle()
	if exists("g:SecureModeToggle") && g:SecureModeToggle == 1
		let g:SecureModeToggle = 0
	elseif exists("g:SecureModeToggle") && g:SecureModeToggle == 0
		let g:SecureModeToggle = 1
	elseif !exists("g:SecureModeToggle")
		let g:SecureModeToggle = 1
	endif
	if g:SecureModeToggle == 1
		" Turn backup off, since most things are git version controlled.
		setlocal nobackup
		" Security: Turn swapfiles off, keeping files only in memory so even root can't access it; tradeoff==can't recover files from crashes
		setlocal noswapfile
		" When writing a file, do not create a temporary backup for a split second; tradeoff==write-failures will also lose the original
		setlocal nowritebackup
		" Turn off the undofile features
		if exists('+undofile')
			setlocal noundofile
		endif
		" Prevent things from being written to the ~/.viminfo file
		if exists('+viminfo')
			set viminfo=
		endif
		autocmd VimLeavePre * call SecureModeFlushTemp()

		echo "Secure Mode On"

	elseif g:SecureModeToggle == 0
		" Reset all the above settings
		setlocal backup
		setlocal swapfile
		setlocal writebackup
		if exists('+undofile')
			setlocal undofile
		endif
		" Don't restore the viminfo -- this is so that nothing is written to this file if SecureModeToggle is used.

		echo "Secure Mode Off"

	endif
endfunction

" Erase: Clobbers/Deletes centralized temporary storage directories and rebuilds them from scratch. Useful on remote machines to not leave a trace.
nnoremap <Leader>era :call SecureModeFlushTemp()<Cr>
command! SecureFlush SecureModeFlushTemp()

function! SecureModeFlushTemp()
	if exists("$HOME/.vim/temp_dirs")
		silent !rm -f $HOME/.vim/temp_dirs
		silent !mkdir -p ~/.vim/temp_dirs
		silent !mkdir -p ~/.vim/temp_dirs/backup
		silent !mkdir -p ~/.vim/temp_dirs/swap
		silent !mkdir -p ~/.vim/temp_dirs/undo
		silent !mkdir -p ~/.vim/temp_dirs/ctags
	endif
endfunction


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Backups (Files, backups and undo)
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Remote Settings: (More secure)
"set nobackup  		" The strategy is to turn backups off on remote systems, since most things are git version controlled
"set noswapfile 	" Turn swapfiles off, keeping files only in memory so even root can't access it; tradeoff==can't recover files from crashes
"set nowritebackup	" When writing a file, do not create a temporary backup for a split second; tradeoff==write-failures will also lose the original


" Local Settings: (So you don't lose your work locally before a git commit)
" 	Add local backup directories to the beginning of the &backupdir setting so that these get preference if the user decides to create them for their project.
"	These functions are only added when Vim starts, not when vimrc is sourced. -- [/so/6821033]
"set backupdir=~/.vim/temp_dirs/backup/
"set directory=~/.vim/temp_dirs/swap/

set backup
set writebackup
set swapfile
" Backup & Swap Directories:
" 	A './' means relative to the file's directory. A leading dot in the directory name (i.e., '/.dirname') is for Unix's hidden file format, which is also understood by git.
" 	All backup directory names can be hidden from a git repository by putting it in .gitignore. See :help backupdir for more on the // and \\ directory structure.
" 	Recommended: The first directory listed should be a relative local directory to the same directory as the file, then centralized if preferred, then finally the same directory as the file.
if has("win16") || has("win32") || has("win64") || has("gui_win32")
	set backupdir^=.\\_tmp\\backup//,.\\.tmp\\backup//,.\\_backup\\backup//,.\\.backup\\backup//,.\\_backup//,.\\.backup//,.\\.backup.vim//,$HOME\\.vim\\temp_dirs\\backup//,.
	set directory^=.\\_tmp\\swap//,.\\.tmp\\swap//,.\\_backup\\swap//,.\\.backup\\swap//,.\\_backup.vim\\swap//,.\\.backup.vim\\swap//,$HOME\\.vim\\temp_dirs\\swap//,.
else
	" Backup Directories: Comma-separated list of where to keep backups. The directory must exist for the backup to be saved. Vim will try each one until it works.
	set backupdir^=./_tmp/backup//,./.tmp/backup//,./_backup/backup//,./.backup/backup//,./_backup//,./.backup//,./_backup.vim//,./.backup.vim//,~/.vim/temp_dirs/backup//,.
	" Swap File Directores: Comma-separated list of where to keep swap files
	set directory^=./_tmp/swap//,./.tmp/swap//,./_backup/swap//,./.backup/swap//,./_backup.vim/swap//,./.backup.vim/swap//,~/.vim/temp_dirs/swap//,.
endif


" Create a specified temporary directory (e.g., /.tmp/ or /.backup/) -- [/so/1549263]
function! MakeTempDir(dir)
	if !isdirectory(a:dir)
		if exists("*mkdir")
			" Try to create a tmp directory using Vim's native features (which is faster than the command-line)
			try
				" If it's Windows, create the directories and also set the hidden directory attribute.
				if has("win16") || has("win32") || has("win64") || has("gui_win32")
					silent call mkdir(a:dir, "p")
					silent call mkdir(a:dir . "\backup", "p")
					silent call mkdir(a:dir . "\swap", "p")
					silent call mkdir(a:dir . "\undo", "p")
					silent call mkdir(a:dir . "\ctags", "p")
					silent !attrib +h a:dir
				else
					call mkdir(a:dir, "p")
					call mkdir(a:dir . "/backup", "p")
					call mkdir(a:dir . "/swap", "p")
					call mkdir(a:dir . "/undo", "p")
					call mkdir(a:dir . "/ctags", "p")
				endif
				echo "Created Temporary Directory: " . a:dir
			catch
				echo "Could not create directory: " . a:dir
			endtry
		elseif has("win16") || has("win32") || has("win64") || has("gui_win32")
			" Try to create a tmp directory from the command-line in Windows
			try
				silent !mkdir a:dir a:dir\backup a:dir\swap a:dir\undo
				silent !attrib +h a:dir
				echo "Created Temporary Directory: ".a:dir
			catch
				echo "Could not create directory: ".a:dir
			endtry
		else
			" Try to create a tmp directory from the command-line in Linux or MacOS
			try
				silent !mkdir -p a:dir > /dev/null 2>&1
				silent !mkdir -p a:dir/backup > /dev/null 2>&1
				silent !mkdir -p a:dir/swap > /dev/null 2>&1
				silent !mkdir -p a:dir/undo > /dev/null 2>&1
				silent !mkdir -p a:dir/ctags > /dev/null 2>&1
				echo "Created Temporary Directory: ".a:dir
			catch
				echo "Could not create directory: ".a:dir
			endtry
		endif
	else
		echo "Directory already exists!"
	endif
endfunction

if g:vimsetup_platform == "win"
	nnoremap <Leader>tmp :call MakeTempDir(expand('%:p:h').'\.tmp')<Cr>
else
	nnoremap <Leader>tmp :call MakeTempDir(expand('%:p:h').'/.tmp')<Cr>
endif


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Persistent Undo
"    Thus means that you can undo even when you close a buffer/VIM
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" This stores undo history per file in a temporary directory. Centralized methods, storing it all in .vim/, can get large in filesize, and some files may be sensitive/secure. Disable centralized methods on remote systems.
" Use a local directory first to store an .undodir locally to not create artifacts of secure/sensitive files elsewhere.
" 	A './' means relative to the file's directory. A leading dot in the directory name (i.e., '/.dirname') is for Unix's hidden file format, which is also understood by git.
" 	All persistent undo directory names can be hidden from a git repository by putting the directory name in .gitignore.
" 	Recommended: The first directory listed should be a relative local directory to the same directory as the file, then centralized if preferred, then finally the same directory as the file.
"
if has('persistent_undo')
	try
		set undofile
		if g:vimsetup_platform == "win"
			set undodir^=.\\_tmp\\undo//,.\\.tmp\\undo//,.\\_backup\\undo//,.\\.backup\\undo//,.\\.backup.vim\\undo//,$HOME\\.vim\\temp_dirs\\undo//,.
		else
			set undodir^=./_tmp/undo//,./.tmp/undo//,./_backup/undo//,./.backup/undo//,./_backup.vim/undo//,./.backup.vim/undo//,~/.vim/temp_dirs/undo//,.
		endif
	catch
	endtry
endif


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => GUI related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Default Fonts: Set default font according to system (plugins can change these settings again in plugins_config.vim, e.g., plugin 'vim-devicons')
if has("mac") || has("macunix") || has("gui_macvim")
    set gfn=Hack:h10,IBM\ Plex\ Mono:h14,Hack:h14,Source\ Code\ Pro:h15,Menlo:h15
elseif has("win16") || has("win32") || has("win64") || has("gui_win32")
    set gfn=Hack:h10,IBM\ Plex\ Mono:h14,Source\ Code\ Pro:h12,Bitstream\ Vera\ Sans\ Mono:h11
elseif has("gui_gtk2")
    set gfn=Hack:h10,IBM\ Plex\ Mono:h14,Source\ Code\ Pro:h12,Bitstream\ Vera\ Sans\ Mono:h11
    " set gfn=Hack:h10,IBM\ Plex\ Mono:h14,Source\ Code\ Pro\ 12,Bitstream\ Vera\ Sans\ Mono\ 11
elseif has("linux")
    set guifont=Hack\ 10,IBM\ Plex\ Mono\ 14,Hack\ 14,Source\ Code\ Pro\ 12,Bitstream\ Vera\ Sans\ Mono\ 11
elseif has("unix")
    set guifont=Hack\ Nerd\ Font\ Mono\ Bold\ 10,Hack\ 10,Monospace\ 11
endif

" Disable scrollbars (real hackers don't use scrollbars for navigation!)
"" set guioptions-=r
"" set guioptions-=R
"" set guioptions-=l
"" set guioptions-=L
"" set guioptions-=b " Get rid of the bottom scrollbar
"" set guioptions-=T " Get rid of the toolbar
"" set guioptions-=e " Get rid of the GUI tabs
" On second thought, enable scrollbars for improved visibility of navigation if it's available
set guioptions+=r
set guioptions+=R


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Fast editing and reloading of vimrc configs
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"map <leader>e :e! ~/.vim/my_configs.vim<cr>
"autocmd! bufwritepost ~/.vim/my_configs.vim source ~/.vim/my_configs.vim

" .vimrc: Shortcut to source the .vimrc file - Reference: http://vimcasts.org/e/24
" 	If the current file being saved/written is .vimrc, automatically source it.
augroup FastEditingVimrc
	autocmd!
	if &runtimepath =~ 'vim-airline'
		autocmd! bufwritepost .vimrc source $MYVIMRC | :AirlineRefresh
		" Windows-equivalent
		autocmd! bufwritepost _vimrc source $MYVIMRC | :AirlineRefresh
		" Neovim-equivalent
		autocmd! bufwritepost init.vim source g:vimsetup_runtimepath_nvim."init.vim" | :AirlineRefresh
		autocmd! bufwritepost ginit.vim source g:vimsetup_runtimepath_nvim."init.vim" | :AirlineRefresh
	else
		autocmd! bufwritepost .vimrc source $MYVIMRC
		autocmd! bufwritepost _vimrc source $MYVIMRC
		autocmd! bufwritepost init.vim source g:vimsetup_runtimepath_nvim."init.vim"
		autocmd! bufwritepost ginit.vim source g:vimsetup_runtimepath_nvim."ginit.vim"
	endif
augroup END
" 	Map ,vrc to open and edit the .vimrc file
if &runtimepath =~ 'vim-airline'
	nmap <Leader>vrc :tabedit $MYVIMRC<Cr>:AirlineRefresh<Cr>
	map <Leader>e :e! $MYVIMRC<Cr>:AirlineRefresh<Cr>
else
	nmap <Leader>vrc :tabedit $MYVIMRC<Cr>
	map <Leader>e :e! $MYVIMRC<Cr>
endif

" .vim_runtime: Shortcut to source the .vim_runtime file
augroup FastEditingVimRuntime
	autocmd!
	if &runtimepath =~ 'vim-airline'
		autocmd! bufwritepost runtime.basic.vim source ~/.vim_runtime/runtime.basic.vim | source ~/.vim_runtime/runtime.extended.vim | :AirlineRefresh
		autocmd! bufwritepost runtime.extended.vim source ~/.vim_runtime/runtime.basic.vim | source ~/.vim_runtime/runtime.extended.vim | :AirlineRefresh
	else
		autocmd! bufwritepost runtime.basic.vim source ~/.vim_runtime/runtime.basic.vim | source ~/.vim_runtime/runtime.extended.vim
		autocmd! bufwritepost runtime.extended.vim source ~/.vim_runtime/runtime.basic.vim | source ~/.vim_runtime/runtime.extended.vim
	endif
augroup END
if &runtimepath =~ 'vim-airline'
	nmap <Leader>vrt :tabedit ~/.vim_runtime/runtime.basic.vim<Cr>:tabedit ~/.vim_runtime/runtime.extended.vim<Cr>:AirlineRefresh<Cr>gT
else
	nmap <Leader>vrt :tabedit ~/.vim_runtime/runtime.basic.vim<Cr>:tabedit ~/.vim_runtime/runtime.extended.vim<Cr>gT
endif

"	To only source part of a file, a visual selection in vimrc or another file with <Leader>vss for Visual Selection Source -- [/so/26433659]
vmap <leader>vss y:@"<CR>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Command mode related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Smart mappings on the command line
cno $h e ~/
cno $d e ~/Desktop/
cno $j e ./
cno $c e <C-\>eCurrentFileDir("e")<cr>

" $q is super useful when browsing on the command line
" it deletes everything until the last slash
cno $q <C-\>eDeleteTillSlash()<cr>

" Navigation: Bash like keys for the command line
"	Home: Redundant to <C-B>
cnoremap <C-A>		<Home>
"	End: Redundant to <C-E>
cnoremap <C-Z>		<End>
"	Clear Line: Delete from the cursor to the beginning of the line at :
cnoremap <C-K>		<C-U>
"	Up
cnoremap <C-P> <Up>
cnoremap <C-K> <Up>
"	Down
cnoremap <C-N> <Down>
cnoremap <C-J> <Down>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Parenthesis/bracket
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Map auto complete of (, ", ', [
vnoremap $1 <esc>`>a)<esc>`<i(<esc>
vnoremap $2 <esc>`>a]<esc>`<i[<esc>
vnoremap $3 <esc>`>a}<esc>`<i{<esc>
vnoremap $$ <esc>`>a"<esc>`<i"<esc>
vnoremap $q <esc>`>a'<esc>`<i'<esc>
vnoremap $e <esc>`>a"<esc>`<i"<esc>

" These slow down the use of the dollar sign symbol
""" inoremap $1 ()<esc>i
""" inoremap $2 []<esc>i
""" inoremap $3 {}<esc>i
""" inoremap $4 {<esc>o}<esc>O
""" inoremap $q ''<esc>i
""" inoremap $e ""<esc>i


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General abbreviations
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
iab xdate <c-r>=strftime("%d/%m/%y %H:%M:%S")<cr>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Omni complete functions
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
augroup OmniCompleteFunctions
	autocmd!
	autocmd FileType css set omnifunc=csscomplete#CompleteCSS
augroup END


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Helper functions
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
func! DeleteTillSlash()
    let g:cmd = getcmdline()

    if has("win16") || has("win32") || has("win64")
        let g:cmd_edited = substitute(g:cmd, "\\(.*\[\\\\]\\).*", "\\1", "")
    else
        let g:cmd_edited = substitute(g:cmd, "\\(.*\[/\]\\).*", "\\1", "")
    endif

    if g:cmd == g:cmd_edited
        if has("win16") || has("win32") || has("win64")
            let g:cmd_edited = substitute(g:cmd, "\\(.*\[\\\\\]\\).*\[\\\\\]", "\\1", "")
        else
            let g:cmd_edited = substitute(g:cmd, "\\(.*\[/\]\\).*/", "\\1", "")
        endif
    endif

    return g:cmd_edited
endfunc

func! CurrentFileDir(cmd)
    return a:cmd . " " . expand("%:p:h") . "/"
endfunc


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


"##############################################################
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""#
"
" SCHEMES CONFIGURATION
"
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""#
"##############################################################



"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Default Colorscheme
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Colorscheme
"set background=dark
"colorscheme onedark

let g:thematic#theme_name = 'tomorrow-light-theme'

" Italics: Force the colorscheme to make comments or other highlights italicized
let g:vimsetup_schemes_italics = 1



"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Status-Line Manager: airline
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Overall: Settings that affect Airline overall:

" Skip sections of airline that are empty
let g:airline_skip_empty_sections = 1

" ALE:
if &runtimepath =~ 'ale'
	" ALE Workaround: Set these. Airline will handle the rest.
	let g:airline#extensions#ale#enabled=1
	let g:airline#extensions#ale#error_symbol=1
	let g:airline#extensions#ale#warning_symbol=1

	let g:airline#extensions#ale#error_symbol = '◆E◆'
	let g:airline#extensions#ale#warning_symbol = '◇W◇'

	" Signs: Determines which signs to use to be represented in the sign column
	" let g:ale_sign_error = '❌'
	" let g:ale_sign_warning = '⚠️'
	" let g:ale_sign_error = '● '
	" let g:ale_sign_warning = '▲'
	" let g:ale_sign_error = '●'
	" let g:ale_sign_warning = '🚩'
	let g:ale_sign_error = '✘'
	let g:ale_sign_warning = '🚩'
	let g:ale_sign_info = '◆'
	" u25c6 = ◆; u2666 = ♦; u2756 = ❖; u25c8 = ◈ -- References [https://www.alt-codes.net/diamond-symbols]
	" u25a0 = ■; u25a1 = □; u25a2 = ▢; u25a3 = ▣; u25c6 = ◆; u25c7 = ◇; u25c8 = ◈; u25c9 = ◉; u25ca = ◊
	let g:ale_sign_highlight_linenrs = 0

	" highlight ALEErrorSign guifg=#FF0000
	" highlight ALEWarningSign guifg=#FFA500

	" highlight clear ALEErrorSign
	" highlight clear ALEWarningSign
	" highlight ALEErrorSign    guifg=#FF6E6E guibg=#FF0000 ctermbg=NONE ctermfg=LightRed
	" highlight ALEWarningSign  guifg=#FFB86C guibg=#FFA500 ctermbg=NONE ctermfg=DarkYellow
	" highlight ALEErrorLine    guifg=#FF6E6E ctermbg=LightRed
	" highlight ALEWarningLine  guifg=#FFB86C ctermbg=DarkYellow
	" highlight ALEErrorSign ctermbg=NONE ctermfg=red
	" highlight ALEWarningSign ctermbg=NONE ctermfg=yellow

	" highlight SignColumn guibg=NONE gui=NONE ctermbg=NONE
	" highlight ALEWarning gui=NONE
	" highlight ALEError gui=NONE
	" highlight ALEErrorSign guifg=#D75F5F guibg=NONE gui=NONE
	" highlight ALEWarningSign guifg=#FFAF5F guibg=NONE gui=NONE

	" References: [https://www.w3schools.com/charsets/ref_utf_geometric.asp]
endif

" Alternative Separators: (Enable for straight tab separators)
"let g:airline#extensions#tabline#left_sep = ' '
"let g:airline#extensions#tabline#left_alt_sep = '|'

" Coc: Integration of Diagnostic Information:
" 	To disable auto detect, comment out those two lines
"let g:airline#extensions#disable_rtp_load = 1
"let g:airline_extensions = ['branch', 'hunks', 'coc']
if g:vimsetup_autocompletion=='coc.nvim'
	let g:airline#extensions#coc#enabled = 1
	let g:airline_section_error = '%{airline#util#wrap(airline#extensions#coc#get_error(),0)}'
	let g:airline_section_warning = '%{airline#util#wrap(airline#extensions#coc#get_warning(),0)}'
	let g:airline#extensions#coc#stl_format_err = '%E{[%e(#%fe)]}'
	let g:airline#extensions#coc#stl_format_warn = '%W{[%w(#%fw)]}'

	let g:coc_status_error_sign = '×'
	let g:coc_status_warning_sign = '●'
	" let g:coc_status_error_sign = '•'
	" let g:coc_status_warning_sign = '••'
endif

" Devicons: Required if using 'bling/vim-airline' with 'vim-devicons'
if &runtimepath =~ 'vim-devicons'
	let g:airline_powerline_fonts = 1
	" adding to vim-airline's tabline
	let g:webdevicons_enable_airline_tabline = 1
	" adding to vim-airline's statusline
	let g:webdevicons_enable_airline_statusline = 1
endif

" Signify/GitGutter: Display Hunks in the statusline
if &runtimepath =~ 'signify' || &runtimepath =~ 'GitGutter'
	let g:airline#extensions#hunks#enabled = 1
	let g:airline#extensions#hunks#non_zero_only = 1
	" Changes Symbol: ~; u0394 = Δ for '+1 Δ4 -3'
	" let g:airline#extensions#hunks#hunk_symbols = ['+', 'Δ', '-']
	let g:airline#extensions#hunks#hunk_symbols = ['+', '~', '-']
endif

" TagBar: Integrates TagBar with Airline
if &runtimepath =~ 'tagbar'
	let g:airline#extensions#tagbar#enabled = 1
endif

" Vimtex: Integrates Vimtex with Airline
if &runtimepath =~ 'vimtex'
	let g:airline#extensions#vimtex#enabled=1
endif

" Vimagit: Integrates Vimagit with Airline
if &runtimepath =~ 'vimagit'
	let g:airline#extensions#vimagit#enabled = 1
endif

" YouCompleteMe: Integrates YCM with Airline
if &runtimepath =~ 'YouCompleteMe'
	let g:airline#extensions#ycm#enabled = 1
endif

" Fix airline slowness -- [https://github.com/vim-airline/vim-airline/issues/421]
if ! has('gui_running')
	set ttimeoutlen=10
	augroup FastEscape
		autocmd!
		au InsertEnter * set timeoutlen=0
		au InsertLeave * set timeoutlen=1000
	augroup END
endif


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Status-Line Manager: lightline
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"let g:lightline = {
"      \ 'colorscheme': 'wombat',
"      \ }
"
"let g:lightline = {
"      \ 'colorscheme': 'wombat',
"      \ 'active': {
"      \   'left': [ ['mode', 'paste'],
"      \             ['fugitive', 'readonly', 'filename', 'modified'] ],
"      \   'right': [ [ 'lineinfo' ], ['percent'] ]
"      \ },
"      \ 'component': {
"      \   'readonly': '%{&filetype=="help"?"":&readonly?"🔒":""}',
"      \   'modified': '%{&filetype=="help"?"":&modified?"+":&modifiable?"":"-"}',
"      \   'fugitive': '%{exists("*fugitive#head")?fugitive#head():""}'
"      \ },
"      \ 'component_visible_condition': {
"      \   'readonly': '(&filetype!="help"&& &readonly)',
"      \   'modified': '(&filetype!="help"&&(&modified||!&modifiable))',
"      \   'fugitive': '(exists("*fugitive#head") && ""!=fugitive#head())'
"      \ },
"      \ 'separator': { 'left': ' ', 'right': ' ' },
"      \ 'subseparator': { 'left': ' ', 'right': ' ' }
"      \ }


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Tab-Line Manager: airline
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Airline's Tabline
let g:airline#extensions#tabline#enabled = 1 " Creates IDE-like tabs by taking the buffers and tabs and displaying them combined in the tabline
" How much of the filename to display in the tabline. Options: default, jsformatter, unique_tail, unique_tail_improved
let g:airline#extensions#tabline#formatter = 'unique_tail'


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Theme Manager: vim-thematic
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:thematic#themes = {
\ 'atom-theme'  : {  'colorscheme': 'onedark',
\					'background': 'dark',
\					'airline-theme': 'onedark',
\					'typeface': 'Hack Nerd Font',
\					'font-size': 10,
\					'transparency': 10,
\					'linespace': 0,
\                },
\ 'atom-light-theme'  : {  'colorscheme': 'one',
\					'background': 'light',
\					'airline-theme': 'one',
\					'typeface': 'Hack Nerd Font Mono Bold',
\					'font-size': 10,
\					'transparency': 10,
\					'linespace': 0,
\                },
\ 'tomorrow-light-theme' : { 'colorscheme': 'Tomorrow',
\					'background': 'light',
\               	'airline-theme': 'tomorrow',
\					'typeface': 'Hack Nerd Font Mono Bold',
\					'font-size': 10,
\ 				},
\ 'peaksea-light-theme' :{ 'colorscheme': 'peaksea',
\                  'background': 'light',
\                  'airline-theme': 'peaksea',
\                  'ruler': 1,
\                  'laststatus': 0,
\                  'typeface': 'Hack Nerd Font',
\                  'font-size': 10,
\                  'transparency': 10,
\                  'linespace': 0,
\                },
\ 'amlight-light-theme' :{ 'colorscheme': 'amlight',
\                  'background': 'light',
\                  'airline-theme': 'base16',
\                  'ruler': 1,
\                  'laststatus': 0,
\                  'typeface': 'Hack Nerd Font Mono Bold',
\                  'font-size': 10,
\                  'transparency': 10,
\                  'linespace': 0,
\                },
\ 'basiclight-light-theme' :{ 'colorscheme': 'basic-light',
\                  'background': 'light',
\                  'airline-theme': 'base16',
\                  'ruler': 1,
\                  'laststatus': 0,
\                  'typeface': 'Hack Nerd Font Mono Bold',
\                  'font-size': 10,
\                  'transparency': 10,
\                  'linespace': 0,
\                },
\ 'hydrangea-theme'  : {  'colorscheme': 'hydrangea',
\					'background': 'dark',
\					'airline-theme': 'iceberg',
\					'typeface': 'Droid Sans Mono',
\					'font-size': 10,
\					'transparency': 10,
\					'linespace': 0,
\                },
\ 'iceberg-theme'  : {  'colorscheme': 'iceberg',
\					'background': 'dark',
\					'airline-theme': 'iceberg',
\					'typeface': 'Droid Sans Mono',
\					'font-size': 10,
\					'transparency': 10,
\					'linespace': 0,
\                },
\ 'nord-theme'  : {  'colorscheme': 'nord',
\					'background': 'dark',
\					'airline-theme': 'nord',
\					'typeface': 'Droid Sans Mono',
\					'font-size': 10,
\					'transparency': 10,
\					'linespace': 0,
\                },
\ 'deepspace-theme'  : {  'colorscheme': 'deep-space',
\					'background': 'dark',
\					'airline-theme': 'deep_space',
\					'typeface': 'Droid Sans Mono',
\					'font-size': 10,
\					'transparency': 10,
\					'linespace': 0,
\                },
\ 'palenight-theme'  : {  'colorscheme': 'palenight',
\					'background': 'dark',
\					'airline-theme': 'tomorrow',
\					'typeface': 'Droid Sans Mono',
\					'font-size': 10,
\					'transparency': 10,
\					'linespace': 0,
\                },
\ 'lowbattery-theme'  : {  'colorscheme': 'vividchalk',
\					'background': 'dark',
\					'airline-theme': 'jellybeans',
\					'typeface': 'Droid Sans Mono',
\					'font-size': 10,
\					'transparency': 0,
\					'linespace': 0,
\                },
\ }

if g:vimsetup_schemes_italics == 1
	" This must come after the colorscheme is loaded so that it is not overridden.
	highlight Comment cterm=italic gui=italic
	" References: [/so/3494435]
endif


" vim:set noet sw=4 ts=4 sts=4
