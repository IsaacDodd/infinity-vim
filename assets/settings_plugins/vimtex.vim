""""""""""""""""""""""""""""""
" => Vimtex plugin
""""""""""""""""""""""""""""""
if &runtimepath =~ 'vimtex'
	let g:tex_flavor='latex'
	let g:vimtex_view_method='mupdf'

	let g:vimtex_compiler_latexmk = {
				\ 'background' : 1,
				\ 'build_dir' : '',
				\ 'callback' : 1,
				\ 'continuous' : 1,
				\ 'executable' : 'latexmk',
				\ 'options' : [
				\   '-verbose',
				\   '-file-line-error',
				\   '-synctex=1',
				\   '-interaction=nonstopmode',
				\ ],
				\}
	"let g:vimtex_quickfix_mode=0
	" Text concealment options (TODO: Find work-around due to conflicts with other plugins [vim-devicons])
	"set conceallevel=1
	"let g:tex_conceal='abdmg'

	" Turn off vim's annoying LaTeX hierarchical concealing feature
	" Set tex_conceal = "" to turn if hiding TeX code; LaTeX syntax concealing is set to show the unicode/pretty format
	let g:tex_conceal=""

	" concealcursor=c = In visual (v), insert (i) and normal (n) mode, reveal the code when the cursor is at the line. Conceal the code only in command (c) mode.
	"	(Setting concealcursor=nc would hide the code at the cursor in normal mode and only reveal it at the cursor in include or visual mode.)
	set concealcursor=c				" Reveal the line at the cursor in v/i/n, Conceal the line at the cursor in c

	" Option 1: save the file whenever you leave insert mode:
	"" augroup PluginVimTeXGroup
	"" 	autocmd!
	"" 	autocmd InsertLeave *.tex update
	"" augroup END
	" Option 2: automatically saves the file when writing, and therefore vimtex does update the preview
	"autocmd TextChanged,TextChangedI <buffer> silent update

	"map I :! pdflatex %<CR><CR>
	"map S :! mupdf-x11 $(echo % \| sed 's/tex$/pdf/') & disown<CR><CR>
endif
