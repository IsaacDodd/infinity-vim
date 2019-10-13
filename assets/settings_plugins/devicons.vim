""""""""""""""""""""""""""""""
" => Devicons plugin (vim-devicons)
""""""""""""""""""""""""""""""

" Patched Fonts: Override defaults - Set font according to system -- TODO: Mac font setup for vim-devicons has not yet been configured
if has("mac") || has("macunix") || has("gui_macvim")
    set guifont=Hack\ Nerd\ Font\ Mono\ Bold:h10,Hack:h10,IBM\ Plex\ Mono:h12,Source\ Code\ Pro:h12,Menlo:h12
	set macligatures
elseif has("win16") || has("win32") || has("win64") || has("gui_win32")
	set guifont=DroidSansMono_NF:h10:cANSI:qDRAFT,Hack\ Nerd\ Font\ Mono\ Bold:h10,Hack:h10,IBM\ Plex\ Mono:h12,Source\ Code\ Pro:h12,Bitstream\ Vera\ Sans\ Mono:h11
elseif has("gui_gtk2")
    set gfn=DroidSansMono\ NF\ 10,Hack\ 10,IBM\ Plex\ Mono\ 12,Source\ Code\ Pro\ 12,Bitstream\ Vera\ Sans\ Mono\ 11
elseif has("linux") || g:vimsetup_platform=='linux'
    set guifont=DroidSansMono\ NF\ 10,Hack\ Nerd\ Font\ Mono\ Bold\ 10,Hack\ Nerd\ Font\ 10,Hack\ 10
elseif has("unix")
    set guifont=Hack\ Nerd\ Font\ Mono\ Bold\ 10,Hack\ 10,Monospace\ 11
endif

" Work-around: Reset conceallevel to 3 (but unfortunately this conflicts with vim's LaTeX concealing methods)
set conceallevel=3

" Explicitly loading the plugin
let g:webdevicons_enable = 1

" Work-around: After a re-source, fix syntax matching issues (concealing brackets) (/se/vi/7932)
if exists('g:loaded_webdevicons')
    call webdevicons#refresh()
endif

" Plugins:
" 	Plugin: Vim Airline
if &runtimepath =~ 'vim-airline'
	" Adding to vim-airline's tabline
	let g:webdevicons_enable_airline_tabline = 1
	" Adding to vim-airline's statusline
	let g:webdevicons_enable_airline_statusline = 1
endif
" 	Plugin: ctrlp glyphs
if &runtimepath =~ 'ctrlp.vim'
	let g:webdevicons_enable_ctrlp = 1
endif
" 	Plugin: vim-startify screen
if &runtimepath =~ 'startify'
	let g:webdevicons_enable_startify = 1
endif
" 	Plugin: NerdTree
if &runtimepath =~ 'nerdtree'
	let g:webdevicons_enable_nerdtree = 1
	" Work-around: Conceal the nerdtree brackets around flags
	let g:webdevicons_conceal_nerdtree_brackets = 1

	" enable folder/directory glyph flag (disabled by default with 0)
	let g:WebDevIconsUnicodeDecorateFolderNodes = 1
	" enable custom folder/directory glyph exact matching (enabled by default when g:WebDevIconsUnicodeDecorateFolderNodes is set to 1)
	let g:WebDevIconsUnicodeDecorateFolderNodesExactMatches = 1
	" enable open and close folder/directory glyph flags (disabled by default with 0)
	let g:DevIconsEnableFoldersOpenClose = 1
	" enable pattern matching glyphs on folder/directory (enabled by default with 1)
	let g:DevIconsEnableFolderPatternMatching = 1
	" enable file extension pattern matching glyphs on folder/directory (disabled by default with 0)
	let g:DevIconsEnableFolderExtensionPatternMatching = 0

	" change the default folder/directory glyph/icon
	let g:WebDevIconsUnicodeDecorateFolderNodesDefaultSymbol = '📁'
	" change the default open folder/directory glyph/icon (default is '') 📁🗂🗁 🗁 🗀📖 🗅 🗐📂 ⚿ 🗝 🔑 🔏 🔐 🔒 🔓⛔
	let g:DevIconsDefaultFolderOpenSymbol = '📂'
	"
	" vim-devicons
	if !exists('g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols')
		let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols = {}
	endif
	let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['html'] = ''
	let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['js'] = ''
	let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['json'] = ''
	let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['jsx'] = 'ﰆ'
	let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['md'] = ''
	let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['vim'] = ''
	let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['yaml'] = ''
	let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['yml'] = ''

	if !exists ('g:WebDevIconsUnicodeDecorateFileNodesPatternSymbols')
		let g:WebDevIconsUnicodeDecorateFileNodesPatternSymbols = {}
	endif
	let g:WebDevIconsUnicodeDecorateFileNodesPatternSymbols['.*vimrc.*'] = ''
	let g:WebDevIconsUnicodeDecorateFileNodesPatternSymbols['.gitignore'] = ''
	let g:WebDevIconsUnicodeDecorateFileNodesPatternSymbols['package.json'] = ''
	let g:WebDevIconsUnicodeDecorateFileNodesPatternSymbols['package.lock.json'] = ''
	let g:WebDevIconsUnicodeDecorateFileNodesPatternSymbols['node_modules'] = ''
	let g:WebDevIconsUnicodeDecorateFileNodesPatternSymbols['webpack\.'] = 'ﰩ'
	" Reference: [https://github.com/aswathkk/dotfiles/blob/master/nvim/init.vim]
endif

" Reference: See example vim-devicons configurations here: https://github.com/ryanoasis/vim-devicons/wiki/examples
