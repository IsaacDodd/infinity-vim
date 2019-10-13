""""""""""""""""""""""""""""""
" => Workspace (vim-workspace) plugin
""""""""""""""""""""""""""""""
if &runtimepath =~ 'vim-workspace'
	" Press ,s to turn on Work[S]paces.
	"nnoremap <leader>s :ToggleWorkspace<CR>

	" Save the session as a hidden file called .session.vim by default
	let g:workspace_session_name = '.session.vim'

	" Option: Save all sessions in one single directory:
	"let g:workspace_session_directory = $HOME.'/.vim/temp_dirs/sessions/'

	" Undo History: in a workspace file undo history and cursor positions are persisted between sessions, without needing to keep Vim on
	let g:workspace_persist_undo_history = 1  " enabled = 1 (default), disabled = 0
	let g:workspace_undodir='.undo.vim'

	" Setting this to 0 stops vim-workspace from reseting the 'compatible' setting, which would change whichwrap and many other settings set in .vimrc.
	let g:workspace_nocompatible = 0
endif
