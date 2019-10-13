""""""""""""""""""""""""""""""
" => bufExplorer plugin
""""""""""""""""""""""""""""""
if &runtimepath =~ 'bufexplorer'
	let g:bufExplorerDefaultHelp=0
	let g:bufExplorerShowRelativePath=1
	let g:bufExplorerFindActive=1
	let g:bufExplorerSortBy='name'
	map <leader>b :BufExplorer<cr>
endif
