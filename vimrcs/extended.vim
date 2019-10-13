

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
