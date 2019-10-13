""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Clang Format (Vim-Clang-Format) plugin
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if &runtimepath =~ 'vim-clang-format'
	let g:clang_format#style_options = {
				\ "AccessModifierOffset" : -4,
				\ "AllowShortIfStatementsOnASingleLine" : "true",
				\ "AlwaysBreakTemplateDeclarations" : "true",
				\ "Standard" : "C++20"}
	let g:clang_format#code_style = 'llvm'
	let g:clang_format#command = 'clang-format'
	" 0 = don't automatically format on leaving insert mode
	let g:clang_format#auto_format_on_insert_leave = 0
	" 0 = don't automatically format on saving/writing the buffer; 1 = automatically format the document on saving the document.
	let g:clang_format#auto_format = 0
	" Map to <Leader>cf in C++ code
	autocmd FileType c,cpp,objc nnoremap <buffer><Leader>cf :<C-u>ClangFormat<CR>
	autocmd FileType c,cpp,objc vnoremap <buffer><Leader>cf :ClangFormat<CR>
	" Toggle auto formatting:
	nmap <Leader>CF :ClangFormatAutoToggle<CR>
endif
