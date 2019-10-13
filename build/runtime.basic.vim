

"##############################################################
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""#
"
" BASIC CONFIGURATION
"
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""#
"##############################################################



"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" VIMRC - Basic.Vim
" (Based on the .vimrc by Amir Salihefendic — @amix3k)
"
" Sections:
"    -> General
"    -> VIM user interface
"    -> Colors and Fonts
"    -> Text, tab and indent related
"    -> Visual mode related
"    -> Moving around, tabs and buffers
"    -> Line operations
"    -> Status line
"    -> Editing mappings
"    -> vimgrep searching and cope displaying
"    -> Spell checking
"    -> Misc
"    -> Helper functions
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Detect the OS for conditionals
if has('win16') || has('win95') || has('win32') || has('win64')
	let g:vimsetup_platform = 'win'
else
	let s:os = substitute(system('uname'), '\n', '', '')
	if has('macunix') || system('uname') =~? '^darwin'
		let g:vimsetup_platform = 'mac'
	elseif system('cat /proc/sys/kernel/osrelease') =~? 'Microsoft' || has('wsl')
		let g:vimsetup_platform = 'wsl'
	elseif has('win32unix')
		let g:vimsetup_platform = 'cygwin'
	elseif has('linux') || s:os == 'Linux' || system('uname') =~? '^linux'
		let g:vimsetup_platform = 'linux'
	elseif executable('lemonade')
		let g:vimsetup_platform = 'lemonade'
	else
		let g:vimsetup_platform = 'unknown'
	endif
endif

" Sets how many lines of history VIM has to remember
set history=1000

" Enable filetype plugins
filetype plugin on
filetype indent on

" Set to auto read when a file is changed from the outside
set autoread

" Leader:
"	First Map Leader: With a map leader it's possible to do additional key combinations beyond Vim's feature-set
let mapleader = ","
"	Second Map Leader: Recursively map <space> to <Leader> to have space as a second leader option (without replacing the default leader)
map <Space> <Leader>
" 	Second ESC Key: Use jk in rapid succession as the <ESC> key (a third method is Ctrl [) - TODO: Does not work in Terminal Vim with Tmux
"inoremap jk <ESC>
"cnoremap jk <C-C>
" Note: In command mode mappings to esc run the command for some odd
" historical vi compatibility reason. We use the alternate method of
" existing which is Ctrl-C
" Reference: https://vi.stackexchange.com/questions/16963/remap-esc-key-in-vim

" 	Third ESC Key: Use \ as an <ESC> key and Ctrl-\ to insert the \ character.
" inoremap \ <ESC>
" inoremap <C-\> \

" Fast saving
"nmap <leader>w :w!<cr>

" Eliminate issues where you accidentally hold shift for too long with :w or :q -- Reference: [https://github.com/nickjj/dotfiles/blob/master/.vimrc]
cnoreabbrev W! w!
cnoreabbrev Q! q!
cnoreabbrev Qall! qall!
cnoreabbrev Wq wq
cnoreabbrev Wa wa
cnoreabbrev wQ wq
cnoreabbrev WQ wq
cnoreabbrev W w
cnoreabbrev Q q
cnoreabbrev Qall qall
cnoreabbrev Qa qa
" :W sudo saves the file (useful for handling the permission-denied error)
cnoreabbrev ws w !sudo tee % > /dev/null
cnoreabbrev Ws ws
" References: [https://github.com/ryanbas21/dotfiles/blob/without-fzf/nvim/init.vim]

" Use Line Numbering
set number                     " Show current line number
" Use Modelines: If they appear at the beginning or end of a word within the first few lines of a file, honor them.
set modeline
" Append modeline after last line in buffer.
" Use substitute() instead of printf() to handle '%%s' modeline in LaTeX files.
function! AppendModeline()
	let l:modeline = printf(" vim: set ff=%s ts=%d sw=%d tw=%d %set :",
		\ &fileformat, &tabstop, &shiftwidth, &textwidth, &expandtab ? '' : 'no')
	let l:modeline = substitute(&commentstring, "%s", l:modeline, "")
	" $ = Append at the end of the file; 0 = Append at the beginning of the file
	call append(line("0"), l:modeline)
endfunction
nnoremap <silent> <Leader>ml :call AppendModeline()<CR>
" Reference: https://vim.fandom.com/wiki/ Vim Tip #331

" Reference:
"	https://github.com/kana/vim-fakeclip/blob/3132f4ac97b00c9259416927aad2c7ab62d9afd9/autoload/fakeclip.vim
"	https://vi.stackexchange.com/a/2577

" Clipboard specification
"" if g:vimsetup_platform == 'linux'
"" 	set clipboard ^= unnamedplus
"" endif


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => VIM user interface
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Set 7 lines to the cursor - when moving vertically using j/k
set so=7

" Avoid garbled characters in the Chinese language on Windows OS
if has("win16") || has("win32") || has("win64") || has("gui_win32")
	let $LANG='en'
	set langmenu=en
	source $VIMRUNTIME/delmenu.vim
	source $VIMRUNTIME/menu.vim
else
	set langmenu=en
endif

" Turn on the Wild menu
set wildmenu

" Ignore compiled files
set wildignore=*.o,*~,*.pyc
if has("win16") || has("win32") || has("win64")
    set wildignore+=.git\*,.hg\*,.svn\*
else
    set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/.DS_Store
endif

"Always show current position (file stats)
set ruler

" Height of the command bar
set cmdheight=2

" A buffer becomes hidden when it is abandoned
set hid

" Configure backspace so it acts as it should act in insert mode
set backspace=eol,start,indent

" Make the left and right arrows wrap to the previous or next lines when they hit the beginning or end of a line respectively
set whichwrap+=<,>,h,l

" Searching
" 	Ignore casing when searching such that upper or lowercase search terms find the same results by default
set ignorecase
" 	When searching, if the term uses capitals, make it case sensitive, and if lowercase make it case insensitive
set smartcase
" 	Highlight search results
set hlsearch
" 	Makes search act like search in modern browsers
set incsearch
" Disable highlighting when <leader>/ is pressed to quickly get rid of highlighting after a search.
nnoremap <Leader>/ :noh<CR>
" Disable highlight when <leader><cr> is pressed
map <silent> <leader><cr> :noh<cr>
" [DISABLED: / and ? are single characters easy enough to achieve this functionality] Map <Space> to / (search) and Ctrl-<Space> to ? (backwards search)
"map <space> /
"map <c-space> ?

" Don't redraw while executing macros (good performance config)
set lazyredraw

" Set ttyfast to improve performance with redrawing multiple windows
set ttyfast

" For regular expressions turn magic on
set magic

" Show matching brackets when text indicator is over them
set showmatch
" How many tenths of a second to blink when matching brackets
set mat=2

" No annoying sound on errors
set noerrorbells
set novisualbell
set t_vb=
set tm=500

" Properly disable sound on errors on MacVim
if has("gui_macvim")
	augroup DisableSoundonErrorsMacVim
		autocmd!
		autocmd GUIEnter * set vb t_vb=
	augroup END
endif

" Start graphical Vim with a larger window size /so/4722684
if has("gui_running")
  " GUI is running or is about to start.
  " Maximize gvim window.
  set lines=999 columns=999
endif

" Add a bit extra margin to the left
set foldcolumn=1

" Highlight the current line wherever the cursor is placed (in every window) and update the highlight as the cursor moves
set cursorline
" Reference: https://vim.fandom.com/wiki/Highlight_current_line

" Expand paths with a tab in Ex mode, and using the :find command, using globbing in the path variable - TODO: Does not work with coc.nvim in terminal vim
"set path+=**

try
	colorscheme Tomorrow
	set background=light
catch
	colorscheme shine
endtry

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Colors and Fonts
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Enable syntax highlighting
filetype plugin indent on " Required by Vimtex
syntax enable

" Enable 256 colors palette in Gnome Terminal
if $COLORTERM == 'gnome-terminal'
    set t_Co=256
endif

" Set extra options when running in GUI mode
if has("gui_running")
    set guioptions-=T
    set guioptions-=e
    set t_Co=256
    set guitablabel=%M\ %t
endif

" Set utf8 as standard encoding and en_US as the standard language
set encoding=utf-8
set termencoding=utf-8

" Use Unix as the standard file type
set ffs=unix,dos,mac


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Text, tab and indent related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" --- Space-Based Indentation Preferences: [DISABLED] ---
"set expandtab			" Use spaces instead of tabs
"set smarttab			" Be smart when using tabs ;)
"set autoindent			" Auto indent
"set smartindent		" Smart indent
"set shiftwidth=4		" 1 tab == 4 spaces
"set tabstop=4			"

" --- Tab-Based Indentation Preferences: ---
"set noexpandtab		" Do not use spaces instead of tabs (use tabs instead)
"set smarttab			" When on, a <Tab> in front of a line inserts blanks according to 'shiftwidth'
"set autoindent			" Copy indent from current line when starting a new line (uses indentation of the first line)
"set smartindent		" C-style indentation for curly braces and #'s
"set shiftwidth=4		"
"set tabstop=4

augroup SetSpacingSettings
	" Remove all auto-commands from the group when sourced
	autocmd!
	" Default Setings: Tab-Based
	autocmd FileType * set noexpandtab | set smarttab | set autoindent | set smartindent | set shiftwidth=4 | set tabstop=4
	" Python Settings: Space-Based
	autocmd FileType python set tabstop=4|set shiftwidth=4|set expandtab|set smarttab|set autoindent|set smartindent
augroup END

" Indentation Keymappings: fast indentations changes -- Reference: [https://github.com/kracejic/dotfiles/blob/master/.vimrc]
nmap <leader>t1 :set expandtab tabstop=1 shiftwidth=1 softtabstop=1<CR>
nmap <leader>T1 :set noexpandtab tabstop=1 shiftwidth=1 softtabstop=1<CR>
nmap <leader>t2 :set expandtab tabstop=2 shiftwidth=2 softtabstop=2<CR>
nmap <leader>T2 :set noexpandtab tabstop=2 shiftwidth=2 softtabstop=2<CR>
nmap <leader>t4 :set expandtab tabstop=4 shiftwidth=4 softtabstop=4<CR>
nmap <leader>T4 :set noexpandtab tabstop=4 shiftwidth=4 softtabstop=4<CR>
nmap <leader>t6 :set expandtab tabstop=6 shiftwidth=6 softtabstop=6<CR>
nmap <leader>T6 :set noexpandtab tabstop=6 shiftwidth=6 softtabstop=6<CR>
nmap <leader>t8 :set expandtab tabstop=8 shiftwidth=8 softtabstop=8<CR>
nmap <leader>T8 :set noexpandtab tabstop=8 shiftwidth=8 softtabstop=8<CR>


" Reference: https://vim.fandom.com/wiki/Converting_tabs_to_spaces

" --- Line Management, Indendation & Wrapping ---

" Wrapping
set wrap 				" Wrap all lines by default (since left/right scrolling on long lines is difficult on remote terminals)

" Linebreak on 500 characters
set lbr
set tw=500

" Indentation strategy for wrapped lines -- /su/72714
" 	Citation for Symbol: U-21B3 @ https://graphemica.com/%E2%86%B3
set breakindent			" Indent long lines under the column of the long line (set the 'break')
let &showbreak=''		" Make this like Notepad++ so that tab-indented long lines line up properly at the column position of the first part of the long line.
" Other showbreak settings: '  →|' ; '↳ '
	" Increase the indentation of the wrapped lines by 4 spaces and show a pipe character as a guide (show a 'break' of 4 spaces)

" Show tab character for tab-indented documents -- /se/vi/422
set list				" Allows for tab indicators to be specified
set listchars=tab:¦\ 	" First character is a marker, second character is expanded to the length of the tab
" Alternatives: Use one of these instead if the above is too unbearable
"set listchars=tab:!·
"set listchars=tab:▸·
"set listchars=tab:├─
" set listchars=tab:▷⋅,trail:⋅,nbsp:⋅
" Other characters: ¦, ┆, │, ⎸, ▏, ¦', '┆', '┊

" Reference:
"	[http://vimcasts.org/episodes/whitespace-preferences-and-filetypes/]
"	[https://github.com/scrooloose/vimfiles/blob/25c21417dea6ec7baf9af0e5270b8263efe345f4/vimrc#L75]


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Insert mode related
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Automatically exit insert mode after a certain time-period -- https://www.reddit.com/r/vim/comments/bk3nup/because_vim_is_about_commandmode_and_not/
"augroup AutoExitInsertMode
"	au InsertEnter * let updaterestore=&updatetime | set updatetime=4000
"	au InsertLeave * let &updatetime=updaterestore
"	au CursorHoldI * stopinsert
"augroup END



""""""""""""""""""""""""""""""
" => Visual mode related
""""""""""""""""""""""""""""""
" Visual mode pressing * or # searches for the current selection
" Super useful! From an idea by Michael Naumann
vnoremap <silent> * :<C-u>call VisualSelection('', '')<CR>/<C-R>=@/<CR><CR>
vnoremap <silent> # :<C-u>call VisualSelection('', '')<CR>?<C-R>=@/<CR><CR>

" Re-select last pasted (or changed) text -- /se/vi/5751
" 	`[ and `] mark the last lines and columns visually selected; '[ and '] mark the last lines (only) visually selected
nmap <Leader>gv `[v`]		" Reselect visual selection with v
nmap <Leader>gV `[V`]		" Line-wise reselection with V

" Keep visual selection after using > or <
" Reference:
"	http://vim.1045645.n5.nabble.com/How-to-keep-selection-selected-td1168950.html
"	https://www.reddit.com/r/vim/comments/bbcnor/handy_keymap_retaining_selection_after_shifting/
vnoremap <lt> <lt>gv
vnoremap <gt> <gt>gv


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Moving around, tabs, windows and buffers
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Replaced by TMUX-compliant code in the plugins section
"" " Smart way to move between windows
"" map <C-j> <C-W>j
"" map <C-k> <C-W>k
"" map <C-h> <C-W>h
"" map <C-l> <C-W>l

" Splits: Tmux-equivalent window splitting for Vim
nnoremap <C-w>\| <C-w>v
nnoremap <C-w>_ <C-w>s

" Allow cursor movements during insert mode
inoremap <C-h> <C-o>h
inoremap <C-j> <C-o>j
inoremap <C-k> <C-o>k
inoremap <C-l> <C-o>l
inoremap <C-d> <end>
" References: https://github.com/jeremyckahn/dotfiles/blob/master/.vimrc

" Linear Movements: Remap j and k to scroll by visual lines with more precision
nnoremap j gj
nnoremap k gk
" Reference: https://vim.fandom.com/wiki/Short_mappings_for_common_tasks

" Window Resizing: Mapped keys for resizing split windows with Ctrl + Arrow keys -- /so/35869593
if exists('$TMUX')
	" Resize horzontal split windows
	nmap [1;5A <C-W>-<C-W>-
	nmap [1;5B <C-W>+<C-W>+
	" Resize vertical split windows
	nmap [1;5C <C-W>><C-W>>
	nmap [1;5D <C-W><<C-W><
else
	" Resize horzontal split windows
	nmap <C-Up> <C-W>-<C-W>-
	nmap <C-Down> <C-W>+<C-W>+
	" Resize vertical split windows
	nmap <C-Right> <C-W>><C-W>>
	nmap <C-Left> <C-W><<C-W><
endif


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Buffers: Close buffers
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Close the current buffer: just close the window, but leave the buffer in memory to switch to (:bnext)
map <Leader>q <Leader>bd<Cr>
" Close the current buffer: completely close (delete) the buffer without closing the window, shifting to the next buffer (or an empty buffer if no others are open), still allowing reopening the buffer from the jumplist (Ctrl-o)
" If the BBye plugin is present, use its function, otherwise use Vim's built-in function
if &runtimepath =~ 'vim-bbye'
	map <leader>bd :Bdelete<Cr>:tabclose<cr>
	map <leader>bw :Bwipeout<Cr>:tabclose<cr>
else
	map <leader>bd :bdelete<Cr>:tabclose<cr>
	map <leader>bw :bwipeout<Cr>:tabclose<cr>
endif

" Close all the buffers
map <leader>ba :bufdo <Leader>bd<cr>


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Buffers: Switch to next/previous buffers
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Switch Buffers: gb = go to next buffer; gB = go to previous buffer; This is similar to the built-in gt and gT commands for tab pages.
nnoremap gb :bnext<CR>
nnoremap gB :bprevious<CR>

" Tmux: Use Ctrl-V then Ctrl+Some Key to enter the literal terminal characters
if exists('$TMUX')
	nnoremap <silent> [1;5H :bp<CR>	" Ctrl-Home
	nnoremap <silent> [1;5F :bn<CR>	" Ctrl-End
	" Reference: https://stackoverflow.com/questions/1814373/why-do-c-pageup-and-c-pagedown-not-work-in-vim#1814395
endif
" Ctrl+Home = go to previous buffer; Ctrl+End = go to next buffer
nnoremap <silent> <C-Home> :bp<CR>
nnoremap <silent> <C-End> :bn<CR>
" Home = go to previous buffer; End = go to next buffer; To use the native Home and End buttons, hold Alt and press the key instead.
nnoremap <silent> <Home> :bp<CR>
nnoremap <silent> <End> :bn<CR>


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Tabs: Switch to next/previous tabs
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Switch Tabs: Ctrl+Tab = go to next tab (same as gt); Ctrl+Shift+Tab = go to previous tab (same as gT) -- /so/28003386
" 	Unfortunately, Ctrl-Tab and Ctrl-Shift-Tab may only work in gVim, not in terminal Vim
if exists('$TMUX')
	nnoremap <silent> [1;5I gt			" Ctrl-Tab
	nnoremap <silent> [1;6I gT			" Ctrl-Shift-Tab
	nnoremap <silent> [6;5~ gt			" Ctrl-PageDown
	nnoremap <silent> [5;5~ gT			" Ctrl-PageUp
	nnoremap <silent> [6~ gt				" PageDown
	nnoremap <silent> [5~ gT				" PageUp
endif
" Tab Page Switching: Ctrl+PageDown = go to next tab; Ctrl+PageUp = go to previous tab (PageUp for TabPage Up, PageDown for TabPage Down)
nnoremap <silent> <C-PageDown> gt
nnoremap <silent> <C-PageUp> gT
nnoremap <silent> <C-Tab> gt
nnoremap <silent> <C-S-Tab> gT
" PageDown/Up = Go to next/previous tab (one can use Ctrl-FDE/BUY for the PageDown/Up functions in Vim instead) To use the native PageDown and PageUp buttons, hold Alt and press the key instead.
nnoremap <silent> <PageDown> gt
nnoremap <silent> <PageUp> gT
" Home row keys: Alt + ; or ' for Tab Page Switching
nnoremap <silent> § gt
nnoremap <silent> » gT
nnoremap <silent> ' gt
nnoremap <silent> ; gT

" Move Tabs: Ctrl+Shift+Arrow keys = move tabs; TMUX terminal equivalents
if exists('$TMUX')
	nnoremap <silent> [1;6D :tabmove-<CR>		" Ctrl-Shift L/R to Move -- /so/40919415 , /so/40919415
	nnoremap <silent> [1;6C :tabmove+<CR>
	"inoremap <silent> [1;6D :tabmove+<CR>		" Ctrl-Shift L/R to Move -- /so/40919415 , /so/40919415
	"inoremap <silent> [1;6C :tabmove-<CR>
endif
" Move tabs with Ctrl-Shift and Alt keys + Arrow keys
nnoremap <silent> <C-S-Right> :tabmove+<CR>		" Ctrl-Shift L/R to Move -- /so/40919415 , /so/40919415
nnoremap <silent> <C-S-Left> :tabmove-<CR>
" nnoremap <silent> <C-S-l> :tabmove+<CR>		" Ctrl-Shift L/R to Move -- /so/40919415 , /so/40919415
" nnoremap <silent> <C-S-h> :tabmove-<CR>
"inoremap <silent> <C-S-Right> :tabmove+<CR>		" Ctrl-Shift L/R to Move -- /so/40919415 , /so/40919415
"inoremap <silent> <C-S-Left> :tabmove-<CR>

" Ctrl-Shift-T: These key mappings work the same way for tabs that Ctrl-w does for Vim Windows
" Ctrl-Shift-T = open new tab
nnoremap <silent> <C-S-T> :tabnew<CR>
" Close the current tab
nnoremap <silent> <C-S-T>c :tabclose<CR>
nnoremap <silent> <C-S-T>q :tabclose<CR>
" Keep only the current tab open (close all other tabs)
nnoremap <silent> <C-S-T>o :tabonly<CR>
" Move the tab to last
nnoremap <silent> <C-S-T>m :tabmove<Cr>
" Use h and l arrow keys to move the tab by 1 position
nnoremap <silent> <C-S-T>l :tabmove +1<CR>
nnoremap <silent> <C-S-T>h :tabmove -1<CR>


" Tab Navigation: Tmux + Vim Navigation using Alt keys
if exists('$TMUX')
	function! TmuxOrTabSwitch(tabcmd, tmuxdir)
		let previous_winnr = tabpagenr()
		silent! execute "tabnext " . a:tabcmd
		if previous_winnr == tabpagenr()
			call system("tmux select-window -t " . a:tmuxdir)
			redraw!
		endif
	endfunction

	let previous_title = substitute(system("tmux display-message -p '#{pane_title}'"), '\n', '', '')
	let &t_ti = "\<Esc>]2;vim\<Esc>\\" . &t_ti
	let &t_te = "\<Esc>]2;". previous_title . "\<Esc>\\" . &t_te

	nnoremap <silent> <A-Left> :call TmuxOrTabSwitch('-', '-')<cr>
	nnoremap <silent> <A-Right> :call TmuxOrTabSwitch('+', '+')<cr>
	nnoremap <silent> <A-Up> :tabprevious<Cr>
	nnoremap <silent> <A-Down> :tabnext<Cr>
else
	noremap <silent> <A-Left>  :tabprevious<Cr>			" Alt + Left -- /so/40919415
	noremap <silent> <A-Right> :tabnext<Cr>				" Alt + Right
	noremap <silent> <A-Up> :tabprevious<Cr>
	noremap <silent> <A-Down> :tabnext<Cr>
	"noremap <A-Left>  :tabmove-<Cr>			" Alt + Left -- /so/40919415
	"noremap <A-Right> :tabmove+<Cr>			" Alt + Right
endif

" Useful mappings for managing tabs
nnoremap <silent> <leader>t :tabnew<Cr>			" Create a new tab quickly
"nnoremap <silent> <leader>t :tabnext<Cr>			" Alternative to gt
"nnoremap <silent> <leader>T :tabprevious<Cr>		" Alternative to gT
nnoremap <silent> <leader>tn :tabnew<Cr>			" New tab
nnoremap <silent> <leader>tc :tabclose<Cr>		" Close the tab
nnoremap <silent> <leader>tq :tabclose<Cr>		" Close the tab
nnoremap <silent> <leader>to :tabonly<Cr>		" Close all but this tab
nnoremap <silent> <leader>t= :tabmove +1<Cr>		" Move tab 1 position left
nnoremap <silent> <leader>t- :tabmove -1<Cr>		" Move tab 1 position right
nnoremap <silent> <leader>tg :tabr<Cr>			" Go to first tab
nnoremap <silent> <leader>tG :tabl<Cr>			" Go to last tab

" Transpose lines up/down
nnoremap <silent> <leader>tj ddp
nnoremap <silent> <leader>tk ddkkp


" Let 'tl' toggle between this and the last accessed tab
let g:lasttab = 1
nmap <Leader>tl :exe "tabn ".g:lasttab<CR>
au TabLeave * let g:lasttab = tabpagenr()


" Opens a new tab with the current buffer's path
" Super useful when editing files in the same directory
map <leader>te :tabedit <c-r>=expand("%:p:h")<cr>/

" PWD = Present Working Directory
" Switch PWD to the directory of the current buffer for ALL windows -- change to the directory of the currently open file (this sets the PWD for all open vim windows)
map <leader>cd :cd %:p:h<cr>:pwd<cr>

" Switch PWD to the directory of the current buffer but ONLY for the active window -- (each window has a local PWD that can be different from Vim's global PWD)
map <leader>lcd :lcd %:p:h<cr>:pwd<cr>

" autochdir = change directories to the current file's directory when switching buffers -- Causes problems with some plugins
"set autochdir
"autocmd BufEnter * if expand("%:p:h") !~ '^/tmp' | silent! lcd %:p:h | endif

" Specify the behavior when switching between buffers
try
  set switchbuf=useopen,usetab,newtab
  set stal=2
catch
endtry

" Return to last edit position when opening files (You want this!)
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif


""""""""""""""""""""""""""""""
" => Line operations
""""""""""""""""""""""""""""""
" Map keys Ctrl-Shift-Arrow-keys to move lines up or down, similar to Notepadqq or Sublime Text. -- Reference: https://vim.fandom.com/wiki/Moving_lines_up_or_down
nnoremap <C-S-Down> :m .+1<CR>==
nnoremap <C-S-Up> :m .-2<CR>==
inoremap <C-S-Down> <Esc>:m .+1<CR>==gi
inoremap <C-S-Up> <Esc>:m .-2<CR>==gi
vnoremap <C-S-Down> :m '>+1<CR>gv=gv
vnoremap <C-S-Up> :m '<-2<CR>gv=gv

" Map <leader>o and O to make new lines without leaving Normal mode -- /se/vi/3875
nnoremap <silent> <leader>o :<C-u>call append(line("."),   repeat([""], v:count1))<CR>
nnoremap <silent> <leader>O :<C-u>call append(line(".")-1, repeat([""], v:count1))<CR>

" Substitute the word under the cursor
nmap <leader>sw :%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>
" References: [https://github.com/jeremyckahn/dotfiles/blob/master/.vimrc]


""""""""""""""""""""""""""""""
" => Status line
""""""""""""""""""""""""""""""
" Always show the status line
set laststatus=2

" Format the status line
set statusline=\ %{HasPaste()}%F%m%r%h\ %w\ \ CWD:\ %r%{getcwd()}%h\ \ \ Line:\ %l\ \ Column:\ %c

" Add Reading Time (naive) estimate to g<C-g> -- /se/vi/19477
fun! s:readtime()
    let l:status = v:statusmsg
    try
		exe "silent normal! g\<C-g>"
		echo printf('%s; Reading Estimate: About %.0f minutes',
					\ v:statusmsg, ceil(wordcount()['words'] / 160.0))
	finally
		let v:statusmsg = l:status
	endtry
endfun
nnoremap g<C-g> :call <SID>readtime()<CR>

" Print the number of occurrences of the current word under the cursor with <leader>* -- Reference: https://github.com/jeremyckahn/dotfiles/blob/master/.vimrc
map <leader>* *<C-O>:%s///gn<CR>

" Color Column: Set Vim's colorcolumn setting to the position of the current cursor.
nnoremap <Leader>cc :call ColorColumnToggle()<Cr>
	let g:setting_colorcolumn_set = 0

function! ColorColumnToggle()
	if g:setting_colorcolumn_set
		let g:setting_colorcolumn_set = 0
		set colorcolumn=""
		echo "Color column: Off"
	else
		let g:setting_colorcolumn_set = 1
		let &colorcolumn = virtcol(".")
		echomsg "Color column:" &colorcolumn
	endif
endfunction

" Cursor Column: Turn on Vim's cursorcolumn setting.
nnoremap <Leader>cu :call CursorColumnToggle()<Cr>
	let g:setting_cursorcolumn_set = 0

function! CursorColumnToggle()
	if g:setting_cursorcolumn_set
		let g:setting_cursorcolumn_set = 0
		set nocursorcolumn
		echo "Cursor column: Off"
	else
		let g:setting_cursorcolumn_set = 1
		let &cursorcolumn = col(".")
		echomsg "Cursor column:" &cursorcolumn
	endif
endfunction


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Editing mappings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Remap VIM 0 to first non-blank character
"map 0 ^

" Move a line of text using ALT+[jk] or Command+[jk] on mac
nmap <M-j> mz:m+<cr>`z
nmap <M-k> mz:m-2<cr>`z
vmap <M-j> :m'>+<cr>`<my`>mzgv`yo`z
vmap <M-k> :m'<-2<cr>`>my`<mzgv`yo`z

if has("mac") || has("macunix")
  nmap <D-j> <M-j>
  nmap <D-k> <M-k>
  vmap <D-j> <M-j>
  vmap <D-k> <M-k>
endif

" Delete trailing white space on save, useful for some filetypes ;)
fun! CleanExtraSpaces()
    let save_cursor = getpos(".")
    let old_query = getreg('/')
    silent! %s/\s\+$//e
    call setpos('.', save_cursor)
    call setreg('/', old_query)
endfun

if has("autocmd")
	augroup CleanExtraSpaces
		autocmd!
		autocmd BufWritePre *.txt,*.js,*.py,*.wiki,*.sh,*.coffee :call CleanExtraSpaces()
	augroup END
endif


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Vimgrep
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Key mappings for searches use <leader>i for inquire...
map <leader>iv :vimgrep<space>
map <leader>il :lvimgrep<space>
map <leader>ig :grep<space>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Quickfix
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" What is the Quickfix list? It's little menu that pops up if there are errors in the buffer depending on the filetype. Different plugins (such as ALE) use it for linting. The location list is similar but is used just for a particular buffer

" copen - open the quickfix list
map <leader>qo :copen<cr>
" cclose - close the quickfix list
map <leader>qc :cclose<cr>
map <leader>qq :cclose<cr>
" Go to the first error in the next file
map <leader>qf :cnfile<cr>
"	If there are errors in the list, the command will open the quickfix list. The same command will close the quickfix list if there are no errors in the list.
map <leader>qw :cwindow<cr>
"	The last 10 lists are remembered.
map <leader>qh :chistory<cr>
map <leader>qe :botright cope<cr>

" Open a temporary file in a new buffer using the quickfix syntax
map <leader>qt ggVGy:tabnew<cr>:set syntax=qf<cr>pgg

" To go to the next search result do:
map <leader>qn :cnext<Cr>
map <leader>qj :cnext<Cr>
map <leader>ql :cnext<Cr>

" To go to the previous search results do:
map <leader>qp :cprevious<Cr>
map <leader>qk :cprevious<Cr>
map <leader>qh :cprevious<Cr>

" Go to the first or last item
map <leader>qa :cfirst<Cr>
map <leader>qz :clast<Cr>
" Same as :cfirst - :cr[ewind][!] [nr]	Display error [nr].  If [nr] is omitted, the FIRST error is displayed.
map <leader>qr :crewind<Cr>

" The vim-unimpaired plugin uses [q and ]q for the quickfix list.

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Spell checking
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Pressing ,ss will toggle and untoggle spell checking
map <leader>ss :setlocal spell!<cr>

" Shortcuts using <leader>
map <leader>sn ]s
map <leader>sp [s
map <leader>sa zg
map <leader>s? z=


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Misc
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Remove the Windows ^M - when the encodings gets messed up
"noremap <Leader>m mmHmt:%s/<C-V><cr>//ge<cr>'tzt'm

" Quickly open a buffer for scribble
map <leader>new :e ~/buffer<cr>

" Quickly open a markdown buffer for scribble
map <leader>md :e ~/buffer.md<cr>

" Set Paste Mode: Toggle paste mode on and off
map <leader>pp :setlocal paste!<cr>

" Current Filename and path: echo out the current file's filename and directory (Or just use :f to get just the filename)
map <Leader>fn :echo expand("%:p")<CR>

" OS File Explorer: Use Ctrl-Alt-e and/or the Super/Windows-Button/Meta + W (Meta-W) to open the default File Explorer:
if has("win16") || has("win32") || has("win64") || has("gui_win32")
	" Map the Windows Button (^X@s) to a character and use it to open explorer
	"map ^X@se :silent !explorer %:p:h:gs?\/?\\\\\\?<CR>
	map ^X@se :exe "silent !explorer ".expand('%:p:h:gs?\/?\\\\\\?')." &"<Cr>
	map <C-A-e> :silent !explorer %:p:h:gs?\/?\\\\\\?<CR>
elseif g:vimsetup_platform=='linux'
	" TODO: Fix Windows-button mappings in Linux
	"map ^X@sw :exe "silent !xdg-open ".expand('%:p:h')." &"<Cr>
	" Ctrl-Alt-e
	map <C-A-e> :exe "silent !xdg-open ".expand('%:p:h')." &"<Cr>
	"map ^X@sw :silent !xdg-open %:p:h:gs?\/?\\\\\\?<CR>
elseif has("unix") && has("mac")
	let g:macpath = expand("%:p:h")
	let g:macpath = substitute(g:macpath," ","\\\\ ","g")
	map ^X@sw execute '!open ' .g:macpath
endif

" Vim File Explorer: Use <Leader>sx to open Vim's internal File Explorer to the current working directory, in a split window:
map <Leader>sx :Sexplore

" References:
"	https://vim.fandom.com/wiki/Open_the_directory_for_the_current_file_in_Windows
"	https://stackoverflow.com/questions/327415/can-windows-key-be-mapped-in-vim#22938137

" Tag Jumping: Use external program 'ctags' to generate a tags file if the ctags program is installed
if executable('ctags')
	command! -nargs=0 MakeTags execute ':silent !ctags -R --exclude=.git .' | execute ':redraw!'
endif
" References:
" 	https://www.youtube.com/watch?v=XA2WjJbmmoM


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Helper functions
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Returns true if paste mode is enabled
function! HasPaste()
    if &paste
        return 'PASTE MODE  '
    endif
    return ''
endfunction

" Don't close window, when deleting a buffer
command! Bclose call <SID>BufcloseCloseIt()
function! <SID>BufcloseCloseIt()
    let l:currentBufNum = bufnr("%")
    let l:alternateBufNum = bufnr("#")

    if buflisted(l:alternateBufNum)
        buffer #
    else
        bnext
    endif

    if bufnr("%") == l:currentBufNum
        new
    endif

    if buflisted(l:currentBufNum)
        execute("bdelete! ".l:currentBufNum)
    endif
endfunction

function! CmdLine(str)
    call feedkeys(":" . a:str)
endfunction

function! VisualSelection(direction, extra_filter) range
    let l:saved_reg = @"
    execute "normal! vgvy"

    let l:pattern = escape(@", "\\/.*'$^~[]")
    let l:pattern = substitute(l:pattern, "\n$", "", "")

    if a:direction == 'gv'
        call CmdLine("Ack '" . l:pattern . "' " )
    elseif a:direction == 'replace'
        call CmdLine("%s" . '/'. l:pattern . '/')
    endif

    let @/ = l:pattern
    let @" = l:saved_reg
endfunction

"Remove all trailing whitespace by pressing <leader>rtw = [d]elete [t]railing [w]hitespace - alternative to plugin vim-better-whitespace
nnoremap <leader>dtw :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar><CR>
