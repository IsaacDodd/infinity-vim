

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" === PACKAGE MANAGEMENT: Vundle
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set nocompatible              				" Required for Vundle - Must be set first since this undoes many other settings when set
filetype off                  				" Required for Vundle
set encoding=utf-8			  				" Explicit declaration of encoding to prevent character incompatibilities
let g:vimsetup_pluginmanager = 'Vundle'		" Declare a variable with the plugin manager chosen

" === Vundle ===
" Set the runtime path to include Vundle and initialize
" This enables this installer to be used on Windows platforms
if has("win16") || has("win32") || has("win64") || has("gui_win32")
	set rtp+=$USERPROFILE\.vim
	set rtp+=$USERPROFILE\.vim\bundle\Vundle.vim
	" Begin Vundle Call
	call vundle#begin('$USERPROFILE\.vim\bundle')
else
	set rtp+=~/.vim/bundle/Vundle.vim
	" Begin Vundle Call
	call vundle#begin()
endif

" === Vundle: [Required] ===
Plugin 'VundleVim/Vundle.vim'				" Package Manager: let Vundle manage Vundle
" === Plugins Profile: ===
Plugin 'hyiltiz/vim-plugins-profile'		" Profiler: Time startup times for each plugin (execute scripts in bundle)
"======


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" === Packages: Installed via Vundle
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" === Main Plugins ===
" Description: These plugins modify the vim editor itself to provide additional functionalities.
" 	References: [https://vimawesome.com/] , [https://github.com/vim-ide/vim-ide,]  [https://www.vim.org/] , [http://vimcasts.org/]
" --- Abolish
Plugin 'tpope/vim-abolish'					" Vim Feature: Search and replace word variations with :%s replaced by :%Subvert and :Abolish
" --- ALE (Asynchronous Linting Engine)
Plugin 'dense-analysis/ale'							" IDE Behavior: Linting - language syntax error-checking
" --- BBye
Plugin 'moll/vim-bbye'						" Vim Feature: delete buffers (close files) without closing your windows or messing up your layout
" --- Bookmarks
Plugin 'MattesGroeger/vim-bookmarks'		" IDE Behavior: Add bookmarks with annotations to the
" --- Bufexplorer
Plugin 'jlanzarotta/bufexplorer'			" Vim Feature: List open and hidden buffers and jump to them (improved version of :ls
" --- Caser (Vim-Caser)
" Plugin 'arthurxavierx/vim-caser'			" Vim Feature: Change whole sentences to proper sentence casing with gss
" --- CtrlP
"Plugin 'ctrlpvim/ctrlp.vim'					" IDE Behavior: Search - Fuzzy file finder: Pressing Ctrl+p to enable fuzzy search of buffers (as in Sublime) (map to ,j)
" --- CtrlSF
"Plugin 'dyng/ctrlsf.vim'					" [DISABLED-slow] IDE Behavior: Search, but with a menu for refactoring variables
" --- Coloresque
"Plugin 'vim-ide/vim-coloresque'			" [DISABLED-errors] IDE Behavior: Color preview for vim (will show the resulting color in the background of a hexcode or named color)
" --- DelimitMate
" Plugin 'Raimondi/delimitMate'				" [DISABLED-slow] IDE Behavior: Auto-completion for the automatic closing of quotes, parenthesis, brackets, etc. in insert mode
" --- Do
" Plugin 'joonty/vim-do'						" Vim Feature: Run shell scripts asynchronously within Vim.
" --- EasyMotion
" Plugin 'easymotion/vim-easymotion'		" [DISABLED-slow] Vim Feature: Add convenient jump-points motion option
" --- EditorConfig
" Plugin 'editorconfig/editorconfig-vim'		" IDE Feature: Uniformity of Editor Configurations
" --- FastFold
Plugin 'Konfekt/FastFold'					" Vim Feature: Reduces vim slowness due to automatic folds
"Plugin 'zhimsel/vim-stay'					" [DISABLED] Vim Feature: Integrates with FastFold - stores and restores the last folds by `:mkview` and `:loadview`.
Plugin 'Konfekt/FoldText'					" Vim Feature: Integrates with FastFold - displays the % of buffer lines the folded text takes up, indents folds according to nesting levels
" --- Floaterm
if has("nvim")
Plugin 'voldikss/vim-floaterm'				" Vim Feature: opens the vim terminal in a floating window and toggles it quickly
endif
" --- gdb
Plugin 'sakhnik/nvim-gdb'					" IDE Behavior: Debugging
" --- Goyo
Plugin 'junegunn/goyo.vim'					" IDE Behavior: Window feature to isolate 1 single buffer for distraction-free writing
" --- Grepper
Plugin 'mhinz/vim-grepper'					" IDE Behavior: A more convenient 'Find in Files' feature for Vim with improvements over :grep and :vimgrep
" --- Gundo
Plugin 'sjl/gundo.vim'						" Vim Feature: Visualize Vim's undo history in a tree.
" --- GutenTags
Plugin 'ludovicchabant/vim-gutentags'		" IDE Behavior: Manages ctags' tag files in the background
" --- Hugefile
Plugin 'mhinz/vim-hugefile'					" Vim Feature: Speed up loading large files by saving current settings then reducing vim features (restore with :HugefileToggle)
" --- Indent Line
Plugin 'Yggdroot/indentLine'				" IDE Behavior: Indent - Show tabbed or spaced indentation level indicators
" --- Indent Guides
"Plugin 'nathanaelkane/vim-indent-guides'	" [DISABLED-NoLongerNecessary] IDE Behavior: Indent - Show indentation level by vertical color change
" --- Indent Object
"Plugin 'michaeljsmith/vim-indent-object'	" [DISABLED-NoLongerNecessary]
" --- MatchUp
" Plugin 'andymass/vim-matchup'				" [DISABLED-Slow] IDE Behavior: jump between opening/closing words (if, elseif, else), highlight parentheses and brackets
" --- Most Recently Used (MRU)
Plugin 'yegappan/mru'						" IDE Behavior: Recent Files List - Provides easy access to a list of recently opened/edited files in Vim
" --- Move
" Plugin 'matze/vim-move'						" IDE Behavior: Use Alt-j/k to move lines or blocks of text up or down.
" --- Multiple Cursors
Plugin 'terryma/vim-multiple-cursors'
" --- NerdTree
Plugin 'scrooloose/nerdtree'				" Vim Feature: Add directory tree structure to Vim
Plugin 'Xuyuanp/nerdtree-git-plugin'		" IDE Behavior: Shows the Git status of directories and files
" Plugin 'markgandolfo/nerdtree-fetch.vim'	" Vim Feature: allow a file to be pulled from the internet using wget or curl (NERDTree > m > f)
Plugin 'PhilRunninger/nerdtree-visual-selection'	" Vim Feature: Allow multiple file selection via visual selections
" Plugin 'tiagofumo/vim-nerdtree-syntax-highlight'	" [DISABLED-slow] NERDtree syntax highlighting
Plugin 'vwxyutarooo/nerdtree-devicons-syntax'					" Faster than nerdtree-syntax-highlight
" --- Nerd Commenter
"Plugin 'scrooloose/nerdcommenter'			" [DISABLED]
" --- Noscrollbar
"Plugin 'gcavallanti/vim-noscrollbar'		" [DISABLED] Vim Feature: Adds a scrollbar indicator widget (no = no mouse support, consistent with Vim's principles)
" --- Numbers
Plugin 'myusuf3/numbers.vim'				" Vim Feature: intelligently toggle line numbers between relative and absolute numbering for the active window (,nt and ,no)
" --- Recover
"Plugin 'chrisbra/Recover.vim'				" [DISABLED-Errors] IDE Behavior: Adds a diff option (Compare) when Vim finds a swap file.
" --- Repeat
"Plugin 'tpope/vim-repeat'					" Vim Feature: Add the repeatable . feature to surround.vim,
" --- ReplaceWithRegister
"Plugin 'vim-scripts/ReplaceWithRegister'	" Vim Feature: Replace the {motion} with text from a named register. Repeatable with the . command.
" --- Session
" Plugin 'xolox/vim-misc'						" 	Dependency for Session
" Plugin 'xolox/vim-session'					" [DISABLED-Using Startify's Sessioning Instead] IDE Behavior: Enhances Vim's session-persistence abilities
" --- Signature
" Plugin 'kshenoy/vim-signature'				" [DISABLED-slows CursorHold] IDE Behavior: Marking - Allows marking lines with a letter for easy jump-points in lines of source code
" --- Sneak
" Plugin 'justinmk/vim-sneak'				" [DISABLED-Slow] Vim Feature: Search - provides an 's' motion for searches (alternative to / for search)
" --- Startify
Plugin 'mhinz/vim-startify'					" IDE Behavior: Start screen with recent files
" --- Surround
Plugin 'tpope/vim-surround'					" IDE BEhavior: provides mappings to easily delete, change and add surroundings in pairs: parentheses, brackets, quotes, tags, etc.
" --- Syntastic
"Plugin 'vim-syntastic/syntastic'			" [DISABLED] Syntastic - Syntax highlighting for multiple languages
" --- Table Mode
Plugin 'dhruvasagar/vim-table-mode'			" IDE Behavior: Automatic table creator & formatter
" --- Tabular
Plugin 'godlygeek/tabular'					" IDE Behavior: Create and format ASCII tables
" --- TComment
Plugin 'tomtom/tcomment_vim'				" IDE Behavior: Comment/uncomment code with mixed language support
" --- Test
"Plugin 'janko-m/vim-test'					" IDE Behavior: Run language-specific tests; Dependency: Requires Ruby to be installed;
" --- Thematic
Plugin 'reedes/vim-thematic'				" Vim Feature: Theme management - specify groups of settings for colorschemes and toggle between them
" --- Tlib
Plugin 'tomtom/tlib_vim'					" Dependency for other plugins
" --- Unimpaired.vim
Plugin 'tpope/vim-unimpaired'				" Pairs of handy bracket mappings
" --- Better Whitespace
Plugin 'ntpeters/vim-better-whitespace'		" Vim Feature: See and strip trailing white spaces at end of lines (:ToggleWhitespace and :StripWhitespace respectively)
" --- Workspace
" Plugin 'thaerkh/vim-workspace'			" [DISABLED-serious-bugs] IDE Behavior: Save persistent Vim sessions: track the session in the working directory
" --- UndoTree
" Plugin 'mbbill/undotree'					" Vim Feature: visualizes undo history to browse and switch between different undo branches
" --- Unicode.vim
"Plugin 'chrisbra/unicode.vim'				" Vim Feature: Provides a reference for Digraphs and Unicodes
" --- ZoomWinTab
Plugin 'troydm/zoomwintab.vim'				" IDE Behavior: Uses tabs to zoom into a window


" === Dependent on External Programs ===
" Description: These are plugins associated with external programs that must be installed in addition to the plugin
" --- Ack (using Ag)
if executable('ag')
	Plugin 'mileszs/ack.vim'					" Vim Feature: Search - Fast regexp searches of source code (add settings to make ack.vim use Ag instead of Ack to avoid Perl dependencies)
endif
" --- Vim-Clang-Format
if executable('clang-format')
	Plugin 'rhysd/vim-clang-format'
endif
" --- Vim LSP CXX Highlight
if executable('ccls')
	Plugin 'jackguo380/vim-lsp-cxx-highlight'
endif
" --- fzf (Fuzzy File Finder)
if executable('fzf')
	Plugin 'junegunn/fzf'						" IDE Behavior: Uses external fzf program (installed via package manager) to perform a fuzzy file search (alternative to Ctrlp)
	Plugin 'junegunn/fzf.vim'
	" Plugin 'pbogut/fzf-mru.vim'
endif
" --- Ranger / LF
if executable('ranger')
	Plugin 'francoiscabrol/ranger.vim'			" Ranger: Use ranger to search for a file
		if executable('nvim') && (&runtimepath =~ 'bclose.vim') == 0
			Plugin 'rbgrouleff/bclose.vim'
		endif	" Dependency for Neovim
	Plugin 'philFernandez/rangerFilePicker.vim'
elseif executable('lf')
	Plugin 'ptzz/lf.vim'
	if executable('nvim') && (&runtimepath =~ 'bclose.vim') == 0
		Plugin 'rbgrouleff/bclose.vim'
	endif
endif
" --- Ripgrep (Using Rg)
if executable('rg')
	Plugin 'jremmen/vim-ripgrep'				" Vim Feature: Use Ripgrep for rg searches, opening up in the quickfix list
endif
" --- Tagbar /Vista.vim
if executable('ctags')
	" Plugin 'majutsushi/tagbar'					" IDE Behavior: browse the ctags of the current file (methods in a C++ file display under their classes)
	Plugin 'liuchengxu/vista.vim'				" IDE Behavior: Use instead an asynchronous tagging system with ctags
endif
" --- Tmux
if executable('tmux')
	Plugin 'tpope/vim-tbone'					" tbone: Basic tmux support for Vim
	Plugin 'tmux-plugins/vim-tmux'				" Tmux Syntax Highlighting when editing .tmux.conf
	Plugin 'tmux-plugins/vim-tmux-focus-events'	" Restores FocusGained and FocusLost autocommand events inside Tmux
	Plugin 'christoomey/vim-tmux-navigator'		" Navigation Keys for Tmux
	"Plugin 'wellle/tmux-complete.vim'			" Tmux Complete: Include keywords from adjacent Tmux panes into auto-completion sources for supported plugins for convenience
	Plugin 'kana/vim-fakeclip'					" Fakeclip: Provides a '&' register to copy/paste from/to on remote terminals where this is not built-in; Works with Tmux, Gnu Screen, and multiple OS's
endif


" === Security Plugins ===
" Description: These are plugins that handle sensitive security or privacy matters and thus must be handled with care.
Plugin 'jamessan/vim-gnupg'					" GPG Encryption: Detect .gpg, .pgp, or .asc files and set up a secure session to encrypt/decrypt the files
Plugin 'ciaranm/securemodelines'			" Modelines: Prevent new files from executing unsafe code when new files are opened. -- [https://security.stackexchange.com/a/157739]

" === Snippets ===
" Description: These plugins provide snippets for automating repetitive functions.
" --- UltiSnip
"Plugin 'SirVer/ultisnips'					" [DISABLED-slow] Performance of cursor speeds significantly degraded with UltiSnips.
" --- SnipMate
"  Plugin 'MarcWeber/vim-addon-mw-utils'	" 	Dependency:
"											" 	Dependency: Tlib - defined above
"  Plugin 'garbas/vim-snipmate'				" IDE Behavior: Snipmate - activate snippets as shortcuts by filetype.


" === Programming Languages ===
" Description: Plugins in this list are related to adding functionality for a particular programming language.
" 	Reference: [https://github.com/sheerun/vim-polyglot]
" --- C-Family Languages (C/C++/C#/Objective-C/Objective-C++/CUDA)
"Plugin 'tpope/vim-commentary' 			" [DISABLED-in favor of TComment_vim - vim-commentary is slower to start up and has no mixed language support] Commentary: use gcc and gc to comment/uncomment lines in visual mode
"Plugin 'octol/vim-cpp-enhanced-highlight' " [In Vim-Polyglot] Syntax highlighting for C++11/14/17
" Plugin 'pboettch/vim-cmake-syntax'		" [In Vim-Polyglot] Syntax highlighting for CMake
" Plugin 'artoj/qmake-syntax-vim'			" [In Vim-Polyglot] Qt Framework: QMake syntax highlighting
" Plugin 'peterhoeg/vim-qml'				" [In Vim-Polyglot] Qt Framework: QML Syntax highlighting
Plugin 'NLKNguyen/c-syntax.vim'			" C Syntax highlighting
" --- CSS
Plugin 'hail2u/vim-css3-syntax'			" CSS syntax highlighting - CSS3 syntax (and syntax defined in some foreign specifications) support for Vim’s built-in syntax/css.vim
Plugin 'groenewege/vim-less'			" Less
" Plugin 'cakebaker/scss-syntax.vim'		" [In Vim-Polyglot] Sassy CSS (SCSS) - For highlighting SCSS elements
Plugin 'rstacruz/vim-hyperstyle'		" CSS, SCSS, Sass, Less, Stylus: auto-completion by fuzzy-matched expansion of partial tags
" --- CSV (Command Separated Values file)
" Plugin 'chrisbra/csv.vim'				" [In Vim-Polyglot] CVS files
" --- Git
Plugin 'tpope/vim-fugitive' 			" FuGITive: Use git commands in vim's Ex line
"Plugin 'airblade/vim-gitgutter' 		" [DISABLED-replaced by signify] GitGutter: shows a git diff in the 'gutter' (sign column) - lines added/modified/removed; never saves the buffer; airline integration
Plugin 'jreybert/vimagit'				" Vimagit: use to open a git-status pane per changed line; Based on the emacs plugin 'Magit'
Plugin 'mhinz/vim-signify'				" Signify: shows a sign column marking lines changed since last commit - Replaces GitGutter (faster)
Plugin 'cohama/agit.vim'				" Agit: Git log viewing panes
"Plugin 'kablamo/vim-git-log'			" [DISABLED-errors in git directories]
"Plugin 'junegunn/gv.vim'				" [DISABLED-in favor of agit] Add-on to FuGITive: Git commit browser light enough to use with a project with thousands of commits
Plugin 'rhysd/git-messenger.vim'		" Git-Messenger: Show the commit message for the text under the cursor
"Plugin 'gregsexton/gitv'				" [DISABLED] Git Visualization - No longer maintained. Using gv instead.
"Plugin 'git-time-metric/gtm-vim-plugin'	" [DISABLED-TODO: Overcome non-standard Installation mechanism] gtm: Store time tracking info in the git repo; Creates git notes w/ local analytics
" --- Go
" Plugin 'fatih/vim-go'					" [In Vim-Polyglot] Go
" --- Haskell
" Plugin 'neovimhaskell/haskell-vim'		" [In Vim-Polyglot]
" --- HTML5
" Plugin 'othree/html5.vim'				" [In Vim-Polyglot] HTML5 syntax highlighting
Plugin 'rstacruz/sparkup'				" Sparkup: Quickly create nested tag elements
" Plugin 'vim-ide/matchtagalways'			" [DISABLED-slow] MatchTagAlways: Highlights the XML/HTML tags that enclose your cursor location
Plugin 'alvan/vim-closetag'				" CloseTag: Automatically close HTML tags when a starting tag is typed
Plugin 'mattn/emmet-vim'				" Emmet: HTML and CSS expansion
" --- Java
Plugin 'rudes/vim-java'
" --- Javascript
Plugin 'pangloss/vim-javascript'		" [In Vim-Polyglot] Javascript: Vastly improved Javascript indentation and syntax support in Vim
Plugin 'mxw/vim-jsx'
Plugin 'crusoexia/vim-javascript-lib'	" Lib: Companion to vim-javascript
Plugin 'othree/javascript-libraries-syntax.vim'		"Syntax for JavaScript libraries, including Angular
Plugin 'othree/yajs.vim'				" YAJS.vim: Yet Another JavaScript Syntax for Vim
Plugin 'claco/jasmine.vim'				" unit testing experience
" Plugin 'elzr/vim-json'					" [In Vim-Polyglot] JSON syntax highlighting improvements
Plugin 'jparise/vim-graphql'			" GraphQl
" Plugin 'posva/vim-vue'					" [In Vim-Polyglot] Vue.js syntax highlighting
Plugin 'burnettk/vim-angular'			" Angular.js syntax highlighting
Plugin 'prettier/vim-prettier'			" Post install (yarn install | npm install) then load plugin only for editing supported files
" --- Julia
" Plugin 'JuliaEditorSupport/julia-vim'	" [In Vim-Polyglot] Julia syntax highlighting
" --- Kotlin
" Plugin 'udalov/kotlin-vim'				" [In Vim-Polyglot] Kotlin
" --- LaTeX/Typesetting
Plugin 'lervag/vimtex'					" VimTeX
Plugin 'KeitaNakamura/tex-conceal.vim'
" --- LLVM
" Plugin 'rhysd/vim-llvm'				" [In Vim-Polyglot]
" --- Nginx
" Plugin 'chr4/nginx.vim'					" [In Vim-Polyglot] Nginx
" --- Markdown
" Plugin 'plasticboy/vim-markdown'		" [In Vim-Polyglot] Markdown: syntax highlighting for the original markdown; Dependency = Tabular (Must declare Tabular Plugin first)
" Plugin 'jtratner/vim-flavored-markdown'	" [DISABLED - Possible plugin conflict; Was designed for tpope's vim-markdown]
"Plugin 'suan/vim-instant-markdown'		" [DISABLED-no-dependencies-installed] Markdown: Instant-Markdown - Opening a markdown file in vim launches a browser window showing the compiled markdown in real-time
" 	Dependencies: xdg-utils, curl, nodejs-legacy, and npm: sudo npm -g install instant-markdown-d
" --- Pandoc
Plugin 'vim-pandoc/vim-pandoc'			" Pandoc: Document conversions (e.g., convert markdown to HTML files)
Plugin 'vim-pandoc/vim-pandoc-syntax'	" Pandoc syntax highlighting (.pdc files)
" --- PHP
" Plugin 'shawncplus/phpcomplete.vim'	" [DISABLED-security] PHP auto-completion - Disabled because the developer included an executable in the code (it's not completely open source)
" Plugin 'StanAngeloff/php.vim'			" [In Vim-Polyglot] PHP syntax hightlighting
Plugin 'stephpy/vim-php-cs-fixer'
Plugin 'adoy/vim-php-refactoring-toolbox'	" Refactor PHP code
Plugin 'phpactor/phpactor'				" Code-completion and refactoring tool for PHP
" --- PowerShell
" Plugin 'PProvost/vim-ps1'				" [In Vim-Polyglot]
" --- Python
"Plugin 'vim-python/python-syntax'		" Python syntax highlighting
" Plugin 'Vimjas/vim-python-pep8-indent'	" [In Vim-Polyglot] Python indentation
Plugin 'andviro/flake8-vim' 			" Flake8: a static syntax and style checker for Python source code
										" 	Dependency: requires installing the separate flake8 python module
" --- R
" Plugin 'vim-scripts/R.vim'				" [In Vim-Polyglot] R: Send R code from a VIM buffer to R on Unix type systems
Plugin 'jalvesaq/Nvim-R'				" R: Improves Vim's support for R code: send lines of code to R Console; Nvim-R and R communicate via TCP connections
" --- Ruby
" Plugin 'vim-ruby/vim-ruby'				" [In Vim-Polyglot]
Plugin 'tpope/vim-rails'
Plugin 'tpope/vim-rake'
Plugin 'ecomba/vim-ruby-refactoring'
" --- Rust
"Plugin 'wting/rust.vim'				" [DEPRECATED-in favor of official rust plugin] Rust
" Plugin 'rust-lang/rust.vim'				" [In Vim-Polyglot] Rust
Plugin 'timonv/vim-cargo'				" Run Cargo commands from Vim
" --- Stata
Plugin 'IsaacDodd/vim-stata'			" Stata: Runs do files, provides syntax highlighting for Stata code
" --- TypeScript
"Plugin 'HerringtonDarkholme/yats.vim'	" YaTS = Yet Another TypeScript Syntax
" Plugin 'Quramy/tsuquyomi'				" [Use coc.nvim instead] Client for TSServer (ditor service bundled into TypeScript): Auto-completion, quickfix syntax checking, navigation to definitions in code, etc.
" --- XML, XLST
" Plugin 'amadeus/vim-xml'				" [In Vim-Polyglot]
" Plugin 'vim-scripts/XSLT-syntax'		" [In Vim-Polyglot]
" --- Overall
Plugin 'sheerun/vim-polyglot'			" Language Plugins (syntax highlighting, filetype detection, and autoloading, asynchronously loaded on demand when a file is opened.
	" Disable plugins that are in Polyglot but replaced below.
	let g:polyglot_disabled = ['tmux', 'latex', 'jsx', 'javascript', 'javascript.jsx']


" === Protocols ===
Plugin 'mhinz/vim-rfc'					" RFC Standards/Protocols: Allows querying the RFC database and opening any RFC/STD document in Vim


" === Status Line & Tab Line ===
" Only choose 1 of the below (or ones known not to conflict)
" --- Airline
Plugin 'vim-airline/vim-airline'		" Airline (vim-airline also integrates with ALE for displaying error information)
Plugin 'vim-airline/vim-airline-themes'	" 	Themes
" --- Bufferline
" Plugin 'bling/vim-bufferline'			" [DISABLED-slowness] Bufferline: Show the list of buffers in the command bar
" --- Buffet
" Plugin 'bagrat/vim-buffet'					" [DISABLED-slowness] IDE Behavior: Creates IDE-like tabs for buffers in the tabline for easy navigation; when many, truncates the tabline with # indicators
" --- Lightline
"Plugin 'itchyny/lightline.vim'			" [DISABLED] Lightline
"Plugin 'maximbaz/lightline-ale'		" 	Work-around: To show ALE errors in lightline
"set laststatus=2
" --- Tmuxline
"" if !( has('win16') || has('win32') || has('win64') )
"" 	Plugin 'edkolev/tmuxline.vim'			" [DISABLED-errors-on-Windows] Statusline for Tmux
"" endif



" === Color Schemes ===
" References: [https://vimcolors.com/] ; [http://bytefluent.com/vivify/]

" +++ General +++
" --- Color Schemes
"Plugin 'flazz/vim-colorschemes'			" [DISABLED] Vim Feature: Installs many color schemes to make them available (slows down Vim -- only enable when scheme-hopping to add scheme to Vim-thematic)

" +++ Dark Themes +++
" --- Afterglow
Plugin 'danilo-augusto/vim-afterglow'
" --- Ayu
"Plugin 'ayu-theme/ayu-vim'
" --- Bubblegum
"Plugin 'baskerville/bubblegum'
" --- Challenger Deep Theme
Plugin 'challenger-deep-theme/vim'
" --- Deep Space
Plugin 'tyrannicaltoucan/vim-deep-space'
" --- Despacio
"Plugin 'AlessandroYorba/Despacio'
" --- Eldar
"Plugin 'agude/vim-eldar'
" --- Gruvbox
"Plugin 'morhetz/gruvbox'
" --- Hybrid
"Plugin 'w0ng/vim-hybrid'
"Plugin 'kristijanhusak/vim-hybrid-material'
" --- Hydrangea
Plugin 'yuttie/hydrangea-vim'
" --- Iceberg
Plugin 'cocopon/iceberg.vim'
" --- Janah
"Plugin 'mhinz/vim-janah'
" --- Jellybeans
Plugin 'nanotech/jellybeans.vim'
" --- Material
Plugin 'jdkanani/vim-material-theme'
" --- Monokai
Plugin 'crusoexia/vim-monokai'
Plugin 'ErichDonGubler/vim-sublime-monokai'
" --- Oceanic-Next
Plugin 'mhartington/oceanic-next'
" --- One
Plugin 'laggardkernel/vim-one'
" --- OneDark (Atom theme)
Plugin 'joshdick/onedark.vim'
" --- NeoSolarized
"Plugin 'iCyMind/NeoSolarized'
" --- Nord
Plugin 'arcticicestudio/nord-vim'
" --- Palenight
Plugin 'drewtempelmeyer/palenight.vim'
" --- Peaksea
Plugin 'vim-scripts/peaksea'
" --- Pyte
Plugin 'therubymug/vim-pyte'
" --- Solarized
Plugin 'altercation/vim-colors-solarized'
" --- Tomorrow
Plugin 'ChrisKempson/Tomorrow-Theme', {'rtp': 'vim'}
" --- Yowish
"Plugin 'KabbAmine/yowish.vim'

" +++ Light Themes+++
" --- Am
Plugin 'muellan/am-colors'
" --- Basic
Plugin 'zcodes/vim-colors-basic'
" --- EditPlus
"Plugin 'vim-scripts/EditPlus'
" --- Fruchtig
Plugin 'schickele/vim-fruchtig'
" --- Mac_Classic
"Plugin 'nelstrom/vim-mac-classic-theme'
" --- MacVim Light
"Plugin 'aunsira/macvim-light'
" --- Playroom
"Plugin 'vim-scripts/playroom'
" --- Raggi
"Plugin 'raggi/vim-color-raggi'
" --- Seoul256-light
"Plugin 'junegunn/seoul256.vim'
" --- Summerfruit256
Plugin 'baeuml/summerfruit256.vim'

" === Widgets ===
" --- Matrix
"  Plugin 'uguu-org/vim-matrix-screensaver'			" Matrix-Like Screensaver

" === Icons ===
" --- DevIcons (required: must be the last plugin)
Plugin 'ryanoasis/vim-devicons'			" This plugin provides icon functionalities to other plugins. Must install patched Nerd Font.
