"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Neomake and vim-test plugins
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if &runtimepath =~ 'neomake'
	let g:neomake_open_list = 1
	let g:neomake_warning_sign = {
		\   'text': '❗'
		\ }
	" Warning Symbols: ⚠️ ⏹⏱△▲ ⛛🔺🔻⯈⯆⯇⯅❗ ⯑
	let g:neomake_error_sign = {
		\   'text': '🔴'
		\ }
	" Error Symbols: '⛒ ⛞ ⭙ ㊀ 🔁🔴🔵🔄●' ⭕ ⭗ ⭘ ⭙ ⭓ ⭔⮾ ⮿ ⮽ 
	" Stars: ★☆✮✯🌠✪✮ ⭐ ⭑ ⭒⯌ ⯍ ⯎ ⯏

	let g:TESTING_STATUS = 'passing'

	" Show message that tests have started
	function! MyOnNeomakeJobStarted() abort
	  let g:TESTING_STATUS = 'running'
	endfunction

	" Show message when all tests are passing
	function! MyOnNeomakeJobFinished() abort
	  let context = g:neomake_hook_context
	  if context.jobinfo.exit_code == 0
		let g:TESTING_STATUS = 'passing'
	  endif
	  if context.jobinfo.exit_code == 1
		let g:TESTING_STATUS = 'failing'
	  endif
	endfunction

	augroup my_neomake_hooks
	  au!
	  autocmd User NeomakeJobFinished call MyOnNeomakeJobFinished()
	  autocmd User NeomakeJobStarted call MyOnNeomakeJobStarted()
	augroup END
endif

if &runtimepath =~ 'vim-test'
	let g:test#javascript#jest#options = '--reporters jest-vim-reporter'
	let test#strategy = "neomake"
	let g:test#preserve_screen = 0
endif
