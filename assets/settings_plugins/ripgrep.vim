""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Ripgrep (Rg) plugin
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if executable('rg')
	set grepprg=rg\ --vimgrep
	" Reference: https://medium.com/@crashybang/supercharge-vim-with-fzf-and-ripgrep-d4661fc853d2

	" :F command for fast searching
	let g:rg_command = '
	  \ rg --column --line-number --no-heading --fixed-strings --ignore-case --no-ignore --hidden --follow --color "always"
	  \ -g "*.{js,json,php,md,styl,jade,html,config,py,cpp,c,go,hs,rb,conf}"
	  \ -g "!*.{min.js,swp,o,zip}" 
	  \ -g "!{.git,node_modules,.tmp,temp_dirs}/*" '
	command! -bang -nargs=* F call fzf#vim#grep(g:rg_command .shellescape(<q-args>), 1, <bang>0)
	" Reference: https://gist.github.com/bag-man/076433a0fc0da1b8f382c80b9697f823
endif
