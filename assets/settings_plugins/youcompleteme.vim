"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => YouCompleteMe (YCM) (For C/C++/C#/Objective-C/Objective-C++/CUDA)
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if g:vimsetup_autocompletion=='YouCompleteMe'
	" Put YCM Configuration options here

	" Global Configuration fall-back file to set default build flags
	let g:ycm_global_ycm_extra_conf = '~/.vim/plugin_YouCompleteMe/buildflags/ycm_global_ycm_extra_conf.py'

	" Close preview window once completion is accepted
	let g:ycm_autoclose_preview_window_after_completion=1

	" <leader>yr finds all references of the keyword under the cursor
	nnoremap <leader>yr :YcmCompleter GoToReferences<CR>

	" <leader>yR renames the keyword under the cursor
	nnoremap <leader>yR :YcmCompleter RefactorRename
	" References: [https://gist.github.com/davidlamt/77b6c48ee3b84d66711cc7922f36c5e8]

	""" Keymappings: ------------------------------------------------------------------------------------------
	nnoremap <leader>yj :YcmCompleter GoToDefinitionElseDeclaration<CR>
	nnoremap <leader>yg :YcmCompleter GoTo<CR>
	nnoremap <leader>yi :YcmCompleter GoToImplementationElseDeclaration<CR>
	nnoremap <leader>yt :YcmCompleter GetTypeImprecise<CR>
	nnoremap <leader>yd :YcmCompleter GetDoc<CR>
	nnoremap <leader>yI :YcmCompleter GetDocImprecise<CR>
	nnoremap <leader>yf :YcmCompleter FixIt<CR>
	nnoremap <leader>yr :YcmCompleter GoToReferences<CR>
	nnoremap <leader>ys :YcmDiags<CR>
	nnoremap <leader>yD :YcmForceCompileAndDiagnostics<CR>
	nnoremap <leader>yR :YcmRestartServer<CR>
	" Reference: [https://github.com/kracejic/dotfiles/blob/master/.vimrc]
endif
