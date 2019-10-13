""""""""""""""""""""""""""""""
" => UltiSnips plugin
""""""""""""""""""""""""""""""
if &runtimepath =~ 'UltiSnips'
	" Trigger Configuration: Do not use <tab> if you use https://github.com/ycm-core/YouCompleteMe.
	"	Ctrl+e activates the snippet after typing its shortcut (E = [E]xpand)
	"	Plugin UltiSnip has a bug that significantly slows cursor speeds (use au CursorMove to see) with <Tab> and YouCompleteMe https://github.com/SirVer/ultisnips/issues/278
	"	Example Configuration: https://www.npmjs.com/package/coc-ultisnips
	let g:UltiSnipsExpandTrigger = '<C-e>'
	let g:UltiSnipsJumpForwardTrigger = '<C-e>'
	let g:UltiSnipsJumpBackwardTrigger = '<S-C-e>'
	" Define an absolute path to speed searching the &runtimepath.
	let g:UltiSnipsSnippetDirectories=[$HOME.'/.vim/plugin_ultisnips']

	" If you want :UltiSnipsEdit to split your window.
	let g:UltiSnipsEditSplit="vertical"
endif
