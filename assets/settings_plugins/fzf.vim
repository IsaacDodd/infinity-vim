""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => FZF plugin
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if executable('fzf')
	" Environmental variables
	if executable('rg')
		" --files: List files that would be searched but do not search
		" --no-ignore: Do not respect .gitignore, etc...
		" --hidden: Search hidden files and folders
		" --follow: Follow symlinks
		" --glob: Additional conditions for search (in this case ignore everything in the .git/ folder)
		if g:vimsetup_platform == 'win'
			let $FZF_DEFAULT_COMMAND='rg --files --no-ignore --hidden --follow'
		else
			let $FZF_DEFAULT_COMMAND='rg --files --no-ignore --hidden --follow --glob "!{.git,node_modules,.tmp,temp_dirs}/*" 2> /dev/null'
		endif

		" --column: Show column number
		" --line-number: Show line number
		" --no-heading: Do not show file headings in results
		" --fixed-strings: Search term as a literal string
		" --ignore-case: Case insensitive search
		" --no-ignore: Do not respect .gitignore, etc...
		" --hidden: Search hidden files and folders
		" --follow: Follow symlinks
		" --glob: Additional conditions for search (in this case ignore everything in the .git/ folder)
		" --color: Search color options
		command! -bang -nargs=* Find call fzf#vim#grep('rg --column --line-number --no-heading --fixed-strings --ignore-case --no-ignore --hidden --follow --glob "!.git/*" --color "always" '.shellescape(<q-args>), 1, <bang>0)
	elseif g:vimsetup_platform == 'win'
		let $FZF_DEFAULT_COMMAND='dir'
	else
		let $FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
	endif
	" Reference:
	" https://github.com/BurntSushi/ripgrep
	" https://www.reddit.com/r/vim/comments/bvo3i8/fzf_shows_hidden_files_in_vim_but_not_gvim/epuu57l/
	" https://medium.com/@crashybang/supercharge-vim-with-fzf-and-ripgrep-d4661fc853d2

	""" Key Mappings
	" FZF
	map <Leader>f :FZF<Cr>
	map <Leader>ff :FZF<Cr>
	map <Leader>fz :FZF<Cr>
	" nmap <leader><tab> :FZF<Cr>
	" xmap <leader><tab> :FZF<Cr>
	" omap <leader><tab> :FZF<Cr>
	map <Leader>f. :FZF ..<Cr>
	map <Leader>f.. :FZF ../..<Cr>
	" Search Git-tracked files
		" git ls-files
		map <Leader>F :GFiles<Cr>
		map <Leader>FF :GFiles<Cr>
		" git status
		map <Leader>Fs :GFiles?<Cr>
		" git log (c for Commits - Search commits for buffer or directory-wide) - Requires Fugitive
		if &runtimepath =~ 'vim-fugitive'
			map <Leader>Fc :BCommits<Cr>
			map <Leader>FC :Commits<Cr>
		endif
	" Search Open Buffers & Buffer History
	map <Leader>fb :Buffers<Cr>
	map <Leader>fh :History<Cr>
	" Search for Lines: Buffer, Directory-wide, & Marks
	map <Leader>fl :BLines<Cr>
	map <Leader>fL :Lines<Cr>
	" Search for Tags: Buffer & Directory-wide
	map <Leader>ft :BTags<Cr>
	map <Leader>fT :Tags<Cr>
	" Search Vim Help Tags
	map <Leader>f? :Helptags<Cr>
	" Search Vim Marks
	map <Leader>f' :Marks<Cr>
	map <Leader>f` :Marks<Cr>
	" Search Vim Windows
	map <Leader>fw :Windows<Cr>
	" Search Vim Commands & Command History
	map <Leader>fc :Commands<Cr>
	map <Leader>f: :History:<Cr>
	" Search Vim Search History
	map <Leader>f/ :History/<Cr>
	" Search Vim Filetype Syntaxes (s for Syntaxes)
	map <Leader>fs :Filetypes<Cr>
	" Search Vim Key Mappings
	"map <Leader>fm :Maps<Cr>
	nmap <Leader>fm <plug>(fzf-maps-n)
	xmap <Leader>fm <plug>(fzf-maps-x)
	omap <Leader>fm <plug>(fzf-maps-o)
	" Search Vim Colorschemes (p for Palette)
	map <Leader>fp :Colors<Cr>

	" Linewise Completion using FZF instead
	" imap <c-x><c-l> <plug>(fzf-complete-line)
	" Reference: http://tilvim.com/2016/01/06/fzf.html
	let g:fzf_action = {
	  \ 'ctrl-t': 'tab split',
	  \ 'ctrl-s': 'split',
	  \ 'ctrl-v': 'vsplit' }

	" Command-Local Options:
	"	[Buffers] Jump to the existing window if possible
	let g:fzf_buffers_jump = 1
	"	[Tags] Command to generate tags file
	let g:fzf_tags_command = 'ctags -R'

	" Customize fzf colors to match your color scheme
	"" let g:fzf_colors =
	"" \ { 'fg':      ['fg', 'Normal'],
	""   \ 'bg':      ['bg', 'Normal'],
	""   \ 'hl':      ['fg', 'Comment'],
	""   \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
	""   \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
	""   \ 'hl+':     ['fg', 'Statement'],
	""   \ 'info':    ['fg', 'PreProc'],
	""   \ 'border':  ['fg', 'Ignore'],
	""   \ 'prompt':  ['fg', 'Conditional'],
	""   \ 'pointer': ['fg', 'Exception'],
	""   \ 'marker':  ['fg', 'Keyword'],
	""   \ 'spinner': ['fg', 'Label'],
	""   \ 'header':  ['fg', 'Comment'] }
endif
