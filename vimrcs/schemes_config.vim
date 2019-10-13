

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
