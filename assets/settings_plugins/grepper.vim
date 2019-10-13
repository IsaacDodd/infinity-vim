""""""""""""""""""""""""""""""""""""""""""""""""""
" => vim-grepper plugin
""""""""""""""""""""""""""""""""""""""""""""""""""

" Reserved key mappings: iv, il, and ig

nnoremap <leader>i <nop>
nnoremap <leader>ii :Grepper<Cr>

if executable('rg')
	command! -nargs=+ -complete=file GrepperRg Grepper -noprompt -tool rg -query <args>
	nnoremap <leader>irg :GrepperRg<Space>
endif
if executable('git')
	command! -nargs=+ -complete=file GrepperGit Grepper -noprompt -tool git -query <args>
	nnoremap <leader>igt :GrepperGit<Space>
	nnoremap <leader>igi :GrepperGit<Space>
endif
if executable('ag')
	command! -nargs=+ -complete=file GrepperAg Grepper -noprompt -tool ag -query <args>
	nnoremap <leader>iag :GrepperAg<Space>
endif
if executable('ack')
	command! -nargs=+ -complete=file GrepperAck Grepper -noprompt -tool ag -query <args>
	nnoremap <leader>iac :GrepperAck<Space>
	nnoremap <leader>iak :GrepperAck<Space>
endif
