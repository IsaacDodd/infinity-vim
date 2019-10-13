
"======================================
" Plugin Manager:
if g:vimsetup_pluginmanager == 'vundle'
	" Vundle: All of your Plugins must be added before the following line
	call vundle#end()            " required
	filetype plugin indent on    " required
elseif g:vimsetup_pluginmanager == 'vim-plug'
	call plug#end()
endif

"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line




" === Custom Runtime

" Runtime Path: This adds a runtime code with all the compiled settings. This also works on Windows platforms. -- [/su/86246] , [/so/8977682] , [https://github.com/mrded/dotfiles/blob/master/.vimrc]
if has("win16") || has("win32") || has("win64") || has("gui_win32")
	set runtimepath+=$HOME\.vim_runtime
	let g:vimsetup_runtimepath = expand("$HOME\\.vim_runtime\\")
	let g:vimsetup_runtimepath_nvim = expand("$HOME\\AppData\\Local\\nvim\\")
	source $HOME\.vim_runtime\runtime.basic.vim
	if g:vimsetup_level == 'full'
		source $HOME\.vim_runtime\runtime.extended.vim
	endif
else
	set runtimepath+=~/.vim_runtime
	let g:vimsetup_runtimepath = expand("~/.vim_runtime/")
	let g:vimsetup_runtimepath_nvim = expand("~/.config/nvim/")
	source ~/.vim_runtime/runtime.basic.vim
	if g:vimsetup_level == 'full'
		source ~/.vim_runtime/runtime.extended.vim
	endif
endif

" Configurations: List of configurations to include.
" Specify a list of all Vim configurations to include
let g:vimsetup_configlist = [
			\ 'config.vim',
			\ 'settings_plugins/*.vim',
			\ 'settings_plugins/*.nvim'
			\]

" Load Settings: Load all configuration files with settings.
for configfiles in g:vimsetup_configlist
	for f in glob(g:vimsetup_runtimepath.configfiles, 1, 1)
		if filereadable(expand(f))
			silent exec 'source' f
		endif
	endfor
endfor

" Platform Detection: Detect the OS for conditionals
if has('win16') || has('win95') || has('win32') || has('win64') || has("gui_win32")
	let g:vimsetup_platform = 'win'
else
	let s:os = tolower( substitute(system('uname'), '\n', '', '') )
	if has('macunix') || s:os =~ 'darwin' || system('uname') =~? '^darwin'
		let g:vimsetup_platform = 'mac'
	elseif system('cat /proc/sys/kernel/osrelease') =~? 'Microsoft' || s:os =~ 'microsoft' || has('wsl')
		let g:vimsetup_platform = 'wsl'
	elseif has('win32unix') || s:os =~ 'cygwin'
		let g:vimsetup_platform = 'cygwin'
	elseif s:os =~ 'mingw'
		let g:vimsetup_platform = 'mingw'
	elseif executable('lemonade')
		let g:vimsetup_platform = 'lemonade'
	elseif s:os =~ 'raspbian'
		let g:vimsetup_platform = 'raspbian'
	elseif has('linux') || s:os =~ 'linux' || system('uname') =~? '^linux'
		let g:vimsetup_platform = 'linux'
	else
		let g:vimsetup_platform = 'unknown'
	endif
endif

" ===


" === Built-In Packages & Help Files
" packloadall
" silent! helptags ALL


" vim:set noet sw=4 ts=4 sts=4
