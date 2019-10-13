"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Thematic plugin
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Map convenience commands for quickly switching themes: ,thn to switch to the next theme, and so on
nmap <Leader>thn :ThematicNext<CR>
nmap <Leader>thp :ThematicPrevious<CR>
nmap <Leader>thr :ThematicRandom<CR>
nmap <Leader>thf :ThematicFirst<CR>
nmap <Leader>tho :ThematicOriginal<CR>

" Widen the window = ,0 (since 9 and 0 are next to - and + on the qwerty keyboard)
noremap <silent> <Leader>0 :<C-u>ThematicWiden<cr>
inoremap <silent> <Leader>0 <C-o>:ThematicWiden<cr>
" Narrow the window = ,9 (since 9 and 0 are next to - and + on the qwerty keyboard)
noremap <silent> <Leader>9 :<C-u>ThematicNarrow<cr>
inoremap <silent> <Leader>9 <C-o>:ThematicNarrow<cr>

" Switch to a Default Dark Theme:
nnoremap <Leader>thd :Thematic atom-theme<CR>
" Switch to a Default Light Theme:
nnoremap <Leader>thl :Thematic tomorrow-light-theme<CR>
