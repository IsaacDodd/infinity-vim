""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => ALE plugin (Asynchronous Linting Engine)
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

if &runtimepath =~ 'ale'

	""" Linters: -----------------------------------------------------------------
	" Run only linters you've explicitly configured
	let g:ale_linters_explicit = 1

	let g:ale_linters = {
				\  'javascript':       ['eslint', 'tsserver'],
				\  'typescript':       ['eslint', 'tsserver'],
				\  'javascript.jsx':   ['eslint', 'tsserver'],
				\  'typescript.tsx':   ['eslint', 'tsserver'],
				\  'json':             ['jsonlint'],
				\  'vue':              ['eslint'],
				\  'html':             ['htmlhint'],
				\  'markdown':         ['mdl'],
				\  'ruby':             ['rubocop'],
				\  'c':                ['clang', 'clangtidy'],
				\  'cpp':              ['clang', 'clangtidy'],
				\  'css':              ['csslint', 'stylelint'],
				\  'scss':             ['sasslint', 'stylelint'],
				\  'yaml':             ['yamllint'],
				\  'python':           ['flake8', 'pylint'],
				\  'rust':             ['rls'],
				\  'lua':              ['luac'],
				\  'go':               ['go', 'golint', 'errcheck'],
				\  'java':             ['javac']
				\}
				" For Bash: \  'sh':               ['language_server']
	let g:ale_lint_on_save = 0
	" Only run linting when saving the file
	let g:ale_lint_on_text_changed = 'never'
	let g:ale_lint_on_enter = 0

	let g:ale_lint_on_insert_leave = 0
	let g:ale_lint_on_filetype_changed = 0

	" Increase the lint delay.
	let g:ale_lint_delay = 500

	""" Fixers: -----------------------------------------------------------------
	let g:ale_fix_on_save = 1
	let g:ale_fixers = {
				\ '*':                ['remove_trailing_lines', 'trim_whitespace'],
				\ 'javascript':       ['prettier'],
				\ 'typescript':       ['prettier'],
				\ 'javascript.jsx':   ['prettier'],
				\ 'typescript.tsx':   ['prettier'],
				\ 'vue':              ['eslint'],
				\ 'css':              ['prettier'],
				\ 'json':             ['prettier', 'jq'],
				\ 'scss':             ['prettier'],
				\ 'html':             ['prettier'],
				\ 'reason':           ['refmt'],
				\ 'python':           ['autopep8'],
				\ 'c':                ['clang-format'],
				\ 'cpp':              ['clang-format'],
				\ 'java':             ['clang-format'],
				\ 'rust':             ['rustfmt'],
				\ 'lua':              ['lua-format'],
				\ 'php':              ['php_cs_fixer'],
				\ 'ruby':             ['standardrb']
				\}

	" ALE Specific Settings:  ---------------------------------------------

	" Completion: Let coc.nvim or YouCompleteMe do the completion instead.
	let g:ale_completion_enabled = 0
	" Invoke tsserver auto-completion for JavaScript -- autocmd FileType javascript imap <C-Space> <Plug>(ale_complete)
	"" augroup PluginALEGroup
	"" 	autocmd!
	""
	"" 	autocmd FileType javascript imap <C-Space> <Plug>(ale_complete)
	"" augroup END

	" Disabling Highlighting:
	"let g:ale_set_highlights = 0

	" Echo Line Settings:
	let g:ale_echo_msg_error_str = '◆E◆'
	let g:ale_echo_msg_warning_str = '◇W◇'
	let g:ale_echo_msg_info_str = '-I-'
	let g:ale_echo_msg_format = '[%linter%]% <code>:% %s [%severity%]'
	" Increase the echo delay
	let g:ale_echo_delay = 20

	" Sign Column:
	let g:ale_sign_column_always = 1

	" List Management:
	" Set Quickfix
	"	0 = Location List (List error messages for just the window containing the buffer at hand)
	"	1 = Quickfix List (List error messages for all buffers in all windows )
	let g:ale_set_quickfix = 0
	"	Only open
	let g:ale_open_list = 'on_save'
	" When there are no errors, close the list
	let g:ale_keep_list_window_open = 0
	" Close the location list automatically when the buffer is closed.
	augroup CloseLoclistWindowGroup
		autocmd!
		autocmd QuitPre * if empty(&buftype) | lclose | endif
	augroup END
	" Reduce the Height of the List
	let g:ale_list_window_size = 5

	" Language Specific Settings: ------------------------------------------------------------
	if g:vimsetup_platform == 'win'
		let g:ale_rust_rustc_options = "--emit=mir -o $TMP"
		let g:ale_cpp_ccls_init_options = {
					\	'cache': {
					\		'directory': "$TMP/ccls/cache",
					\	},
					\ }
		let g:ale_c_ccls_init_options = {
					\	'cache': {
					\		'directory': '$TMP/ccls/cache',
					\	},
					\ }
	else
		let g:ale_rust_rustc_options = '--emit=mir -o /dev/null'
		let g:ale_cpp_ccls_init_options = {
					\	'cache': {
					\		'directory': '/tmp/ccls/cache',
					\	},
					\ }
		let g:ale_c_ccls_init_options = {
					\	'cache': {
					\		'directory': '/tmp/ccls/cache',
					\	},
					\ }
	endif
	let g:ale_javascript_prettier_options = '--single-quote --trailing-comma es5'
	let g:ale_javascript_prettier_use_local_config = 1
	let g:ale_javascript_eslint_use_local_config = 1

	" Do not lint or fix minified files.
	let g:ale_pattern_options = {
				\ '\.min\.js$': {'ale_linters': [], 'ale_fixers': []},
				\ '\.min\.css$': {'ale_linters': [], 'ale_fixers': []},
				\}
	" If you configure g:ale_pattern_options outside of vimrc, you need this.
	let g:ale_pattern_options_enabled = 1


	" Reference:
	" 	[https://freshman.tech/vim-javascript/]
	" 	[https://gitlab.com/DanManN/dotfiles/blob/master/.vim/plugins.vim]
	" 	[https://github.com/liuchengxu/space-vim/blob/master/layers/%2Bcheckers/syntax-checking/config.vim]

	""" Key Mappings: ---------------------------------------------
	" Enable/Disable ALE or Reset it
	nmap <silent> <leader>lt <Plug>(ale_toggle)
	nmap <silent> <leader>lx <Plug>(ale_reset)
	" Linting or Fixing
	nmap <silent> <leader>ll <Plug>(ale_lint)
	nmap <silent> <leader>lf <Plug>(ale_fix)
	nmap <silent> <leader>ld <Plug>(ale_detail)
	" Navigation
	nmap <silent> <leader>lj <Plug>(ale_next_wrap)
	nmap <silent> <leader>lk <Plug>(ale_previous_wrap)
	nmap <silent> <leader>lJ <Plug>(ale_next)
	nmap <silent> <leader>lK <Plug>(ale_previous)
	" Chosen letter so as not to conflict with the mappings for :help unimpaired - These wrap just ALE errors in the quickfix/location lists
	nmap <silent> [r <Plug>(ale_previous_wrap)
	nmap <silent> ]r <Plug>(ale_next_wrap)
	if g:ale_set_quickfix == 1
		" Use the quickfix list window instead (also use [q and ]q from unimpaired.vim)
		nmap <silent> <leader>lo :copen 5<Cr>
		nmap <silent> <leader>lc :cclose<Cr>
		nmap <silent> <leader>lp :cprevious<Cr>
		nmap <silent> <leader>ln :cnext<Cr>
		nmap <silent> <leader>lr :crewind<Cr>
	else
		" Use the location list window instead (also use [l and ]l from unimpaired.vim)
		nmap <silent> <leader>lo :lopen 5<Cr>
		nmap <silent> <leader>lc :lclose<Cr>
		nmap <silent> <leader>lp :lprevious<Cr>
		nmap <silent> <leader>ln :lnext<Cr>
		nmap <silent> <leader>lr :lrewind<Cr>
	endif
	" Toggling Lists: Whether the quickfix or the location list is set, use common key bindings to toggle displaying the list for ALE.
	" 	References: The list toggling code and the plugin based on it are reproduced and quoted here since it is so small a codebase it wouldn't make sense to install it as a plugin and have it uninstallable separate from ALE.
	" 		[https://github.com/milkypostman/vim-togglelist/blob/master/plugin/togglelist.vim]
	" 		[https://vim.fandom.com/wiki/Toggle_to_open_or_close_the_quickfix_window]
	"	Key Mappings: l; is fast to type with touch typing, and these are similar to the g; for changelist (but instead this points to the quicklist or location list)
	if g:ale_set_quickfix == 1
		nmap <script> <silent> <leader>l; :call ToggleQuickfixList()<CR>
	else
		nmap <script> <silent> <leader>l; :call ToggleLocationList()<CR>
	endif

	"	Functions:
	function! s:GetBufferList()
		redir =>buflist
		silent! ls
		redir END
		return buflist
	endfunction

	function! ToggleLocationList()
		let curbufnr = winbufnr(0)
		for bufnum in map(filter(split(s:GetBufferList(), '\n'), 'v:val =~ "Location List"'), 'str2nr(matchstr(v:val, "\\d\\+"))')
			if curbufnr == bufnum
				lclose
				return
			endif
		endfor

		let winnr = winnr()
		let prevwinnr = winnr("#")

		let nextbufnr = winbufnr(winnr + 1)
		try
			lopen
		catch /E776/
			echohl ErrorMsg
			echo "Location List is Empty."
			echohl None
			return
		endtry
		if winbufnr(0) == nextbufnr
			lclose
			if prevwinnr > winnr
				let prevwinnr-=1
			endif
		else
			if prevwinnr > winnr
				let prevwinnr+=1
			endif
		endif
		" restore previous window
		exec prevwinnr."wincmd w"
		exec winnr."wincmd w"
	endfunction

	function! ToggleQuickfixList()
		for bufnum in map(filter(split(s:GetBufferList(), '\n'), 'v:val =~ "Quickfix List"'), 'str2nr(matchstr(v:val, "\\d\\+"))')
			if bufwinnr(bufnum) != -1
				cclose
				return
			endif
		endfor
		let winnr = winnr()
		if exists("g:toggle_list_copen_command")
			exec(g:toggle_list_copen_command)
		else
			copen
		endif
		if winnr() != winnr
			wincmd p
		endif
	endfunction

endif
