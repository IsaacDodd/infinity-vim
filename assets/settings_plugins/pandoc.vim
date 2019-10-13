"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Pandoc (vim-pandoc) plugin
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" nmap <Leader>pdf :Pandoc! pdf<CR> - Temporary fix for this Plugin: use LaTeX to compile a PDF in the CWD then open it.
if has("win16") || has("win32") || has("win64") || has("gui_win32")
	nmap <Leader>pdf :exe "silent !pandoc ".expand('%:t')." -f markdown -t latex -s -o ".expand('%:t').".pdf"<Cr>:exe "!start ".expand('%:t').".pdf"<Cr>
else
	nmap <Leader>pdf :exe "silent !pandoc ".expand('%:t')." -f markdown -t latex -s -o ".expand('%:t').".pdf"<Cr>:exe "! ./".expand('%:t').".pdf"<Cr>
endif
nmap <Leader>phtm :Pandoc! html<CR>
nnoremap <Leader>mu :!mupdf %:r.pdf &<CR><CR>

" Reference: 
" 	https://stackoverflow.com/a/20799071
"	https://www.reddit.com/r/vim/comments/1hy5o5/best_latex_plugin/caz4qei/
