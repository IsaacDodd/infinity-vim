

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" === PACKAGE MANAGEMENT: Vim-Plug
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set encoding=utf-8			  					" Explicit declaration of encoding to prevent character incompatibilities
let g:vimsetup_pluginmanager = 'vim-plug'		" Declare a variable with the plugin manager chosen

" === Vim-Plug ===
" Check to determine if Vim-Plug is installed, install if not present, then initialize
" This enables this installer to be used on Windows platforms
if has("win16") || has("win32") || has("win64") || has("gui_win32")
	" Begin Vim-Plug Call - Windows
	set rtp+=$USERPROFILE\.vim
	set rtp+=$USERPROFILE\.vim\autoload
	call plug#begin(expand('$USERPROFILE\.vim\bundle'))
else
	" Begin Vim-Plug Call - Other Systems
	call plug#begin('~/.vim/bundle')
endif

" === Plugins Profile: ===
Plug 'hyiltiz/vim-plugins-profile'			" Profiler: Time startup times for each plugin (execute scripts in bundle)
"======


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" === Packages: Installed via Vim-Plug
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" === Main Plugins ===
" Description: These plugins modify the vim editor itself to provide additional functionalities.
" 	References: [https://vimawesome.com/] , [https://github.com/vim-ide/vim-ide,]  [https://www.vim.org/] , [http://vimcasts.org/]
" --- Abolish
Plug 'tpope/vim-abolish'					" Vim Feature: Search and replace word variations with :%s replaced by :%Subvert and :Abolish
" --- ALE (Asynchronous Linting Engine)
Plug 'dense-analysis/ale'							" IDE Behavior: Linting - language syntax error-checking
" --- BBye
Plug 'moll/vim-bbye'						" Vim Feature: delete buffers (close files) without closing your windows or messing up your layout
" --- Bookmarks
Plug 'MattesGroeger/vim-bookmarks'			" IDE Behavior: Add bookmarks with annotations to the
" --- Bufexplorer
Plug 'jlanzarotta/bufexplorer'			" Vim Feature: List open and hidden buffers and jump to them (improved version of :ls
" --- Caser (Vim-Caser)
" Plug 'arthurxavierx/vim-caser'			" Vim Feature: Change whole sentences to proper sentence casing with gss
" --- CtrlP
"Plug 'ctrlpvim/ctrlp.vim'					" IDE Behavior: Search - Fuzzy file finder: Pressing Ctrl+p to enable fuzzy search of buffers (as in Sublime) (map to ,j)
" --- CtrlSF
"Plug 'dyng/ctrlsf.vim'					" [DISABLED-slow] IDE Behavior: Search, but with a menu for refactoring variables
" --- Coloresque
"Plug 'vim-ide/vim-coloresque'			" [DISABLED-errors] IDE Behavior: Color preview for vim (will show the resulting color in the background of a hexcode or named color)
" --- DelimitMate
" Plug 'Raimondi/delimitMate'				" [DISABLED-slow] IDE Behavior: Auto-completion for the automatic closing of quotes, parenthesis, brackets, etc. in insert mode
" --- Do
" Plug 'joonty/vim-do'						" Vim Feature: Run shell scripts asynchronously within Vim.
" --- EasyMotion
" Plug 'easymotion/vim-easymotion'		" [DISABLED-slow] Vim Feature: Add convenient jump-points motion option
" --- EditorConfig
" Plug 'editorconfig/editorconfig-vim'		" IDE Feature: Uniformity of Editor Configurations
" --- FastFold
Plug 'Konfekt/FastFold'					" Vim Feature: Reduces vim slowness due to automatic folds
"Plug 'zhimsel/vim-stay'					" [DISABLED] Vim Feature: Integrates with FastFold - stores and restores the last folds by `:mkview` and `:loadview`.
Plug 'Konfekt/FoldText'					" Vim Feature: Integrates with FastFold - displays the % of buffer lines the folded text takes up, indents folds according to nesting levels
" --- Floaterm
Plug 'voldikss/vim-floaterm', has('nvim') ? {} : { 'on': ['FloatermToggle'] }			" Vim Feature: opens the vim terminal in a floating window and toggles it quickly
" --- gdb
Plug 'sakhnik/nvim-gdb', { 'branch': 'legacy' }
" --- Goyo
Plug 'junegunn/goyo.vim', { 'on': 'Goyo' }					" IDE Behavior: Window feature to isolate 1 single buffer for distraction-free writing
" --- Grepper
Plug 'mhinz/vim-grepper', { 'on': ['Grepper', '<plug>(GrepperOperator)'] }		" IDE Behavior: A more convenient 'Find in Files' feature for Vim with improvements over :grep and :vimgrep
" --- Gundo
Plug 'sjl/gundo.vim', { 'on': 'GundoToggle' }					" Vim Feature: Visualize Vim's undo history in a tree.
" --- GutenTags
Plug 'ludovicchabant/vim-gutentags'		" IDE Behavior: Manages ctags' tag files in the background
" --- Hugefile
Plug 'mhinz/vim-hugefile'					" Vim Feature: Speed up loading large files by saving current settings then reducing vim features (restore with :HugefileToggle)
" --- Indent Line
Plug 'Yggdroot/indentLine'				" IDE Behavior: Indent - Show tabbed or spaced indentation level indicators
" --- Indent Guides
"Plug 'nathanaelkane/vim-indent-guides'	" [DISABLED-NoLongerNecessary] IDE Behavior: Indent - Show indentation level by vertical color change
" --- Indent Object
"Plug 'michaeljsmith/vim-indent-object'	" [DISABLED-NoLongerNecessary]
" --- MatchUp
" Plug 'andymass/vim-matchup'				" [DISABLED-Slow] IDE Behavior: jump between opening/closing words (if, elseif, else), highlight parentheses and brackets
" --- Most Recently Used (MRU)
Plug 'yegappan/mru', { 'on': 'MRU' }						" IDE Behavior: Recent Files List - Provides easy access to a list of recently opened/edited files in Vim
" --- Move
" Plug 'matze/vim-move'						" IDE Behavior: Use Alt-j/k to move lines or blocks of text up or down.
" --- Multiple Cursors
Plug 'terryma/vim-multiple-cursors'
" --- NerdTree
Plug 'scrooloose/nerdtree'				" Vim Feature: Add directory tree structure to Vim
Plug 'Xuyuanp/nerdtree-git-plugin', { 'on': 'NERDTreeToggle' }		" IDE Behavior: Shows the Git status of directories and files
Plug 'PhilRunninger/nerdtree-visual-selection', { 'on': 'NERDTreeToggle' }	" Vim Feature: Allow multiple file selection via visual selections
" Plug 'markgandolfo/nerdtree-fetch.vim', { 'on': 'NERDTreeToggle' }	" Vim Feature: allow a file to be pulled from the internet using wget or curl (NERDTree > m > f)
" Plug 'tiagofumo/vim-nerdtree-syntax-highlight', { 'on': 'NERDTreeToggle' }	" [DISABLED-slow] NERDtree syntax highlighting
Plug 'vwxyutarooo/nerdtree-devicons-syntax', { 'on': 'NERDTreeToggle' }			" Faster than nerdtree-syntax-highlight
" --- Nerd Commenter
"Plug 'scrooloose/nerdcommenter'			" [DISABLED]
" --- Noscrollbar
"Plug 'gcavallanti/vim-noscrollbar'		" [DISABLED] Vim Feature: Adds a scrollbar indicator widget (no = no mouse support, consistent with Vim's principles)
" --- Numbers
Plug 'myusuf3/numbers.vim'				" Vim Feature: intelligently toggle line numbers between relative and absolute numbering for the active window (,nt and ,no)
" --- Recover
"Plug 'chrisbra/Recover.vim'				" [DISABLED-Errors] IDE Behavior: Adds a diff option (Compare) when Vim finds a swap file.
" --- Repeat
"Plug 'tpope/vim-repeat'					" Vim Feature: Add the repeatable . feature to surround.vim,
" --- ReplaceWithRegister
"Plug 'vim-scripts/ReplaceWithRegister'	" Vim Feature: Replace the {motion} with text from a named register. Repeatable with the . command.
" --- Session
" Plug 'xolox/vim-misc'						" 	Dependency for Session
" Plug 'xolox/vim-session'					" [DISABLED-Using Startify's Sessioning Instead] IDE Behavior: Enhances Vim's session-persistence abilities
" --- Signature
" Plug 'kshenoy/vim-signature'				" [DISABLED-slows CursorHold] IDE Behavior: Marking - Allows marking lines with a letter for easy jump-points in lines of source code
" --- Sneak
" Plug 'justinmk/vim-sneak'				" [DISABLED-Slow] Vim Feature: Search - provides an 's' motion for searches (alternative to / for search)
" --- Startify
Plug 'mhinz/vim-startify'					" IDE Behavior: Start screen with recent files
" --- Surround
Plug 'tpope/vim-surround'					" IDE BEhavior: provides mappings to easily delete, change and add surroundings in pairs: parentheses, brackets, quotes, tags, etc.
" --- Syntastic
"Plug 'vim-syntastic/syntastic'			" [DISABLED] Syntastic - Syntax highlighting for multiple languages
" --- Table Mode
Plug 'dhruvasagar/vim-table-mode'			" IDE Behavior: Automatic table creator & formatter
" --- Tabular
Plug 'godlygeek/tabular'					" IDE Behavior: Create and format ASCII tables
" --- TComment
Plug 'tomtom/tcomment_vim'				" IDE Behavior: Comment/uncomment code with mixed language support
" --- Test
"Plug 'janko-m/vim-test'					" IDE Behavior: Run language-specific tests; Dependency: Requires Ruby to be installed;
" --- Thematic
Plug 'reedes/vim-thematic'				" Vim Feature: Theme management - specify groups of settings for colorschemes and toggle between them
" --- Tlib
Plug 'tomtom/tlib_vim'					" Dependency for other plugins
" --- Unimpaired.vim
Plug 'tpope/vim-unimpaired'				" Pairs of handy bracket mappings
" --- Better Whitespace
Plug 'ntpeters/vim-better-whitespace', { 'on': 'StripWhitespace' }	" Vim Feature: See and strip trailing white spaces at end of lines (:ToggleWhitespace and :StripWhitespace respectively)
" --- Workspace
" Plug 'thaerkh/vim-workspace'			" [DISABLED-serious-bugs] IDE Behavior: Save persistent Vim sessions: track the session in the working directory
" --- UndoTree
" Plug 'mbbill/undotree'					" Vim Feature: visualizes undo history to browse and switch between different undo branches
" --- Unicode.vim
"Plug 'chrisbra/unicode.vim'				" Vim Feature: Provides a reference for Digraphs and Unicodes
" --- ZoomWinTab
Plug 'troydm/zoomwintab.vim'				" IDE Behavior: Uses tabs to zoom into a window


" === Dependent on External Programs ===
" Description: These are plugins associated with external programs that must be installed in addition to the plugin
" --- Ack (using Ag)
Plug 'mileszs/ack.vim', executable('ag') ? {} : { 'on': [] }					" Vim Feature: Search - Fast regexp searches of source code (add settings to make ack.vim use Ag instead of Ack to avoid Perl dependencies)
" --- Vim-Clang-Format
Plug 'rhysd/vim-clang-format', executable('clang-format') ? {} : { 'on': [] }
" --- Vim LSP CXX Highlight
Plug 'jackguo380/vim-lsp-cxx-highlight', executable('ccls') ? { 'for': ['c', 'cpp', 'objc', 'objcpp'] } : { 'on': [] }
" --- fzf (Fuzzy File Finder)
Plug 'junegunn/fzf', executable('fzf') ? {} : { 'on': [] }						" IDE Behavior: Uses external fzf program (installed via package manager) to perform a fuzzy file search (alternative to Ctrlp)
Plug 'junegunn/fzf.vim', executable('fzf') ? {} : { 'on': [] }
" Plug 'pbogut/fzf-mru.vim', executable('fzf') ? {} : { 'on': [] }
" --- Ranger / LF
Plug 'francoiscabrol/ranger.vim', executable('ranger') ? {} : { 'on': [] }			" Ranger: Use ranger to search for a file
Plug 'philFernandez/rangerFilePicker.vim', executable('ranger') ? {} : { 'on': [] }
Plug 'ptzz/lf.vim', executable('lf') ? {} : { 'on': [] }
Plug 'rbgrouleff/bclose.vim', executable('nvim') ? {} : { 'on': [] }
" --- Ripgrep (Using Rg)
Plug 'jremmen/vim-ripgrep', executable('rg') ? {} : { 'on': [] }				" Vim Feature: Use Ripgrep for rg searches, opening up in the quickfix list
" --- Tagbar /Vista.vim
Plug 'majutsushi/tagbar', executable('ctags') ? {} : { 'on': 'TagbarToggle' }					" IDE Behavior: browse the ctags of the current file (methods in a C++ file display under their classes)
Plug 'liuchengxu/vista.vim', executable('ctags') ? {} : { 'on': [] }				" IDE Behavior: Use instead an asynchronous tagging system with ctags
" --- Tmux
Plug 'tpope/vim-tbone', executable('tmux') ? {} : { 'on': [] }					" tbone: Basic tmux support for Vim
Plug 'tmux-plugins/vim-tmux', executable('tmux') ? {} : { 'on': [] }				" Tmux Syntax Highlighting when editing .tmux.conf
Plug 'tmux-plugins/vim-tmux-focus-events', executable('tmux') ? {} : { 'on': [] }	" Restores FocusGained and FocusLost autocommand events inside Tmux
Plug 'christoomey/vim-tmux-navigator', executable('tmux') ? {} : { 'on': [] }		" Navigation Keys for Tmux
"Plug 'wellle/tmux-complete.vim', executable('tmux') ? {} : { 'on': [] }			" Tmux Complete: Include keywords from adjacent Tmux panes into auto-completion sources for supported plugins for convenience
Plug 'kana/vim-fakeclip', executable('tmux') ? {} : { 'on': [] }					" Fakeclip: Provides a '&' register to copy/paste from/to on remote terminals where this is not built-in; Works with Tmux, Gnu Screen, and multiple OS's


" === Security Plugins ===
" Description: These are plugins that handle sensitive security or privacy matters and thus must be handled with care.
Plug 'jamessan/vim-gnupg'					" GPG Encryption: Detect .gpg, .pgp, or .asc files and set up a secure session to encrypt/decrypt the files
Plug 'ciaranm/securemodelines'			" Modelines: Prevent new files from executing unsafe code when new files are opened. -- [https://security.stackexchange.com/a/157739]

" === Snippets ===
" Description: These plugins provide snippets for automating repetitive functions.
" --- UltiSnips
"Plug 'SirVer/ultisnips'					" [DISABLED-slow] Performance of cursor speeds significantly degraded with UltiSnips.
" --- SnipMate
"  Plug 'MarcWeber/vim-addon-mw-utils'	" 	Dependency:
"											" 	Dependency: Tlib - defined above
"  Plug 'garbas/vim-snipmate'				" IDE Behavior: Snipmate - activate snippets as shortcuts by filetype.


" === Programming Languages ===
" Description: Plugins in this list are related to adding functionality for a particular programming language.
" 	Reference: [https://github.com/sheerun/vim-polyglot]
" --- C-Family Languages (C/C++/C#/Objective-C/Objective-C++/CUDA)
"Plug 'tpope/vim-commentary' 			" [DISABLED-in favor of TComment_vim - vim-commentary is slower to start up and has no mixed language support] Commentary: use gcc and gc to comment/uncomment lines in visual mode
"Plug 'octol/vim-cpp-enhanced-highlight' " [In Vim-Polyglot] Syntax highlighting for C++11/14/17
" Plug 'pboettch/vim-cmake-syntax'		" [In Vim-Polyglot] Syntax highlighting for CMake
" Plug 'artoj/qmake-syntax-vim'			" [In Vim-Polyglot] Qt Framework: QMake syntax highlighting
" Plug 'peterhoeg/vim-qml'				" [In Vim-Polyglot] Qt Framework: QML Syntax highlighting
Plug 'NLKNguyen/c-syntax.vim', { 'for': ['c', 'cpp'] }			" C Syntax highlighting
" --- CSS
Plug 'hail2u/vim-css3-syntax', { 'for': 'css' }			" CSS syntax highlighting - CSS3 syntax (and syntax defined in some foreign specifications) support for Vim’s built-in syntax/css.vim
Plug 'groenewege/vim-less', { 'for': 'css' }			" Less
" Plug 'cakebaker/scss-syntax.vim'		" [In Vim-Polyglot] Sassy CSS (SCSS) - For highlighting SCSS elements
Plug 'rstacruz/vim-hyperstyle', { 'for': 'css' }		" CSS, SCSS, Sass, Less, Stylus: auto-completion by fuzzy-matched expansion of partial tags
" --- CSV (Command Separated Values file)
" Plug 'chrisbra/csv.vim'				" [In Vim-Polyglot] CVS files
" --- Git
Plug 'tpope/vim-fugitive' 			" FuGITive: Use git commands in vim's Ex line
"Plug 'airblade/vim-gitgutter' 		" [DISABLED-replaced by signify] GitGutter: shows a git diff in the 'gutter' (sign column) - lines added/modified/removed; never saves the buffer; airline integration
Plug 'jreybert/vimagit'				" Vimagit: use to open a git-status pane per changed line; Based on the emacs plugin 'Magit'
Plug 'mhinz/vim-signify'				" Signify: shows a sign column marking lines changed since last commit - Replaces GitGutter (faster)
Plug 'cohama/agit.vim'				" Agit: Git log viewing panes
"Plug 'kablamo/vim-git-log'			" [DISABLED-errors in git directories]
"Plug 'junegunn/gv.vim'				" [DISABLED-in favor of agit] Add-on to FuGITive: Git commit browser light enough to use with a project with thousands of commits
Plug 'rhysd/git-messenger.vim'		" Git-Messenger: Show the commit message for the text under the cursor
"Plug 'gregsexton/gitv'				" [DISABLED] Git Visualization - No longer maintained. Using gv instead.
"Plug 'git-time-metric/gtm-vim-plugin'	" [DISABLED-TODO: Overcome non-standard Installation mechanism] gtm: Store time tracking info in the git repo; Creates git notes w/ local analytics
" --- Go
" Plug 'fatih/vim-go'					" [In Vim-Polyglot] Go
" --- Haskell
" Plug 'neovimhaskell/haskell-vim'		" [In Vim-Polyglot]
" --- HTML5
" Plug 'othree/html5.vim'				" [In Vim-Polyglot] HTML5 syntax highlighting
Plug 'rstacruz/sparkup', { 'for': 'html' }				" Sparkup: Quickly create nested tag elements
" Plug 'vim-ide/matchtagalways'			" [DISABLED-slow] MatchTagAlways: Highlights the XML/HTML tags that enclose your cursor location
Plug 'alvan/vim-closetag', { 'for': 'html' }				" CloseTag: Automatically close HTML tags when a starting tag is typed
Plug 'mattn/emmet-vim', { 'for': 'html' } 				" Emmet: HTML and CSS expansion
" --- Java
Plug 'rudes/vim-java', { 'for': ['java','jar'] }
" --- Javascript
Plug 'pangloss/vim-javascript'		" [In Vim-Polyglot] Javascript: Vastly improved Javascript indentation and syntax support in Vim
Plug 'mxw/vim-jsx', { 'for': ['javascript', 'javascript.jsx'] }
Plug 'crusoexia/vim-javascript-lib', { 'for': 'js' }	" Lib: Companion to vim-javascript
Plug 'othree/javascript-libraries-syntax.vim', { 'for': 'js' }		"Syntax for JavaScript libraries, including Angular
Plug 'othree/yajs.vim', { 'for': 'js' }				" YAJS.vim: Yet Another JavaScript Syntax for Vim
Plug 'claco/jasmine.vim', { 'for': 'js' }				" unit testing experience
" Plug 'elzr/vim-json'					" [In Vim-Polyglot] JSON syntax highlighting improvements
Plug 'jparise/vim-graphql'			" GraphQl
" Plug 'posva/vim-vue'					" [In Vim-Polyglot] Vue.js syntax highlighting
Plug 'burnettk/vim-angular'			" Angular.js syntax highlighting
" Post install (yarn install | npm install) then load plugin only for editing supported files
Plug 'prettier/vim-prettier', {
			\ 'do': 'yarn install',
			\ 'for': ['javascript', 'typescript', 'css', 'less', 'scss', 'json', 'graphql', 'markdown', 'vue', 'yaml', 'html'] }
" --- Julia
" Plug 'JuliaEditorSupport/julia-vim'	" [In Vim-Polyglot] Julia syntax highlighting
" --- Kotlin
" Plug 'udalov/kotlin-vim'				" [In Vim-Polyglot] Kotlin
" --- LaTeX/Typesetting
Plug 'lervag/vimtex', { 'for': ['tex','latex'] }					" VimTeX
Plug 'KeitaNakamura/tex-conceal.vim', {'for': 'tex'}
" --- LLVM
" Plug 'rhysd/vim-llvm'				" [In Vim-Polyglot]
" --- Nginx
" Plug 'chr4/nginx.vim'					" [In Vim-Polyglot] Nginx
" --- Markdown
" Plug 'plasticboy/vim-markdown'		" [In Vim-Polyglot] Markdown: syntax highlighting for the original markdown; Dependency = Tabular (Must declare Tabular Plugin first)
" Plug 'jtratner/vim-flavored-markdown'	" [DISABLED - Possible plugin conflict; Was designed for tpope's vim-markdown]
"Plug 'suan/vim-instant-markdown'		" [DISABLED-no-dependencies-installed] Markdown: Instant-Markdown - Opening a markdown file in vim launches a browser window showing the compiled markdown in real-time
" 	Dependencies: xdg-utils, curl, nodejs-legacy, and npm: sudo npm -g install instant-markdown-d
" --- Pandoc
Plug 'vim-pandoc/vim-pandoc'			" Pandoc: Document conversions (e.g., convert markdown to HTML files)
Plug 'vim-pandoc/vim-pandoc-syntax'	" Pandoc syntax highlighting (.pdc files)
" --- PHP
" Plug 'shawncplus/phpcomplete.vim'	" [DISABLED-security] PHP auto-completion - Disabled because the developer included an executable in the code (it's not completely open source)
" Plug 'StanAngeloff/php.vim'			" [In Vim-Polyglot] PHP syntax hightlighting
Plug 'stephpy/vim-php-cs-fixer', { 'for': 'php' }
Plug 'adoy/vim-php-refactoring-toolbox', { 'for': 'php' }	" Refactor PHP code
Plug 'phpactor/phpactor', { 'for': 'php' }				" Code-completion and refactoring tool for PHP
" --- PowerShell
" Plug 'PProvost/vim-ps1'				" [In Vim-Polyglot]
" --- Python
"Plug 'vim-python/python-syntax'		" Python syntax highlighting
" Plug 'Vimjas/vim-python-pep8-indent'	" [In Vim-Polyglot] Python indentation
Plug 'andviro/flake8-vim', { 'for': ['python', 'py', 'pip'] } 			" Flake8: a static syntax and style checker for Python source code
										" 	Dependency: requires installing the separate flake8 python module
" --- R
" Plug 'vim-scripts/R.vim'				" [In Vim-Polyglot] R: Send R code from a VIM buffer to R on Unix type systems
Plug 'jalvesaq/Nvim-R', { 'for': 'r' }				" R: Improves Vim's support for R code: send lines of code to R Console; Nvim-R and R communicate via TCP connections
" --- Ruby
" Plug 'vim-ruby/vim-ruby'				" [In Vim-Polyglot]
Plug 'tpope/vim-rails'
Plug 'tpope/vim-rake'
Plug 'ecomba/vim-ruby-refactoring'
" --- Rust
"Plug 'wting/rust.vim'				" [DEPRECATED-in favor of official rust plugin] Rust
" Plug 'rust-lang/rust.vim'				" [In Vim-Polyglot] Rust
Plug 'timonv/vim-cargo'					" Run Cargo commands from Vim
" --- Stata
Plug 'IsaacDodd/vim-stata', { 'for': 'stata' }			" Stata: Runs do files, provides syntax highlighting for Stata code
" --- TypeScript
"Plug 'HerringtonDarkholme/yats.vim'	" YaTS = Yet Another TypeScript Syntax
" Plug 'Quramy/tsuquyomi'				" [Use coc.nvim instead] Client for TSServer (ditor service bundled into TypeScript): Auto-completion, quickfix syntax checking, navigation to definitions in code, etc.
" --- XML, XLST
" Plug 'amadeus/vim-xml'				" [In Vim-Polyglot]
" Plug 'vim-scripts/XSLT-syntax'		" [In Vim-Polyglot]
" --- Overall
Plug 'sheerun/vim-polyglot'			" Language Plugins (syntax highlighting, filetype detection, and autoloading, asynchronously loaded on demand when a file is opened.
	" Disable plugins that are in Polyglot but replaced below.
	let g:polyglot_disabled = ['tmux', 'latex', 'jsx', 'javascript', 'javascript.jsx']


" === Protocols ===
Plug 'mhinz/vim-rfc'					" RFC Standards/Protocols: Allows querying the RFC database and opening any RFC/STD document in Vim


" === Status Line & Tab Line ===
" Only choose 1 of the below (or ones known not to conflict)
" --- Airline
Plug 'vim-airline/vim-airline'		" Airline (vim-airline also integrates with ALE for displaying error information)
Plug 'vim-airline/vim-airline-themes'	" 	Themes
" --- Bufferline
" Plug 'bling/vim-bufferline'			" [DISABLED-slowness] Bufferline: Show the list of buffers in the command bar
" --- Buffet
" Plug 'bagrat/vim-buffet'					" [DISABLED-slowness] IDE Behavior: Creates IDE-like tabs for buffers in the tabline for easy navigation; when many, truncates the tabline with # indicators
" --- Lightline
"Plug 'itchyny/lightline.vim'			" [DISABLED] Lightline
"Plug 'maximbaz/lightline-ale'		" 	Work-around: To show ALE errors in lightline
"set laststatus=2
" --- Tmuxline
"" if !( has('win16') || has('win32') || has('win64') )
"" 	Plug 'edkolev/tmuxline.vim'			" [DISABLED-errors-on-Windows] Statusline for Tmux
"" endif



" === Color Schemes ===
" References: [https://vimcolors.com/] ; [http://bytefluent.com/vivify/]

" +++ General +++
" --- Color Schemes
"Plug 'flazz/vim-colorschemes'			" [DISABLED] Vim Feature: Installs many color schemes to make them available (slows down Vim -- only enable when scheme-hopping to add scheme to Vim-thematic)

" +++ Dark Themes +++
" --- Afterglow
Plug 'danilo-augusto/vim-afterglow'
" --- Ayu
"Plug 'ayu-theme/ayu-vim'
" --- Bubblegum
"Plug 'baskerville/bubblegum'
" --- Challenger Deep Theme
Plug 'challenger-deep-theme/vim'
" --- Deep Space
Plug 'tyrannicaltoucan/vim-deep-space'
" --- Despacio
"Plug 'AlessandroYorba/Despacio'
" --- Eldar
"Plug 'agude/vim-eldar'
" --- Gruvbox
"Plug 'morhetz/gruvbox'
" --- Hybrid
"Plug 'w0ng/vim-hybrid'
"Plug 'kristijanhusak/vim-hybrid-material'
" --- Hydrangea
Plug 'yuttie/hydrangea-vim'
" --- Iceberg
Plug 'cocopon/iceberg.vim'
" --- Janah
"Plug 'mhinz/vim-janah'
" --- Jellybeans
Plug 'nanotech/jellybeans.vim'
" --- Material
Plug 'jdkanani/vim-material-theme'
" --- Monokai
Plug 'crusoexia/vim-monokai'
Plug 'ErichDonGubler/vim-sublime-monokai'
" --- Oceanic-Next
Plug 'mhartington/oceanic-next'
" --- One
Plug 'laggardkernel/vim-one'
" --- OneDark (Atom theme)
Plug 'joshdick/onedark.vim'
" --- NeoSolarized
"Plug 'iCyMind/NeoSolarized'
" --- Nord
Plug 'arcticicestudio/nord-vim'
" --- Palenight
Plug 'drewtempelmeyer/palenight.vim'
" --- Peaksea
Plug 'vim-scripts/peaksea'
" --- Pyte
Plug 'therubymug/vim-pyte'
" --- Solarized
Plug 'altercation/vim-colors-solarized'
" --- Tomorrow
Plug 'ChrisKempson/Tomorrow-Theme', {'rtp': 'vim'}
" --- Yowish
"Plug 'KabbAmine/yowish.vim'

" +++ Light Themes+++
" --- Am
Plug 'muellan/am-colors'
" --- Basic
Plug 'zcodes/vim-colors-basic'
" --- EditPlus
"Plug 'vim-scripts/EditPlus'
" --- Fruchtig
Plug 'schickele/vim-fruchtig'
" --- Mac_Classic
"Plug 'nelstrom/vim-mac-classic-theme'
" --- MacVim Light
"Plug 'aunsira/macvim-light'
" --- Playroom
"Plug 'vim-scripts/playroom'
" --- Raggi
"Plug 'raggi/vim-color-raggi'
" --- Seoul256-light
"Plug 'junegunn/seoul256.vim'
" --- Summerfruit256
Plug 'baeuml/summerfruit256.vim'

" === Widgets ===
" --- Matrix
"  Plug 'uguu-org/vim-matrix-screensaver'			" Matrix-Like Screensaver

" === Icons ===
" --- DevIcons (required: must be the last plugin)
Plug 'ryanoasis/vim-devicons'			" This plugin provides icon functionalities to other plugins. Must install patched Nerd Font.
