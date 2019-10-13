"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Noscrollbar plugin
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" To use without a statusline plugin
"set statusline=%<%f\ %h%m%r%=%-14.(%l,%c%V%)\ %{noscrollbar#statusline()}

" To use with the Airline plugin
"function! Noscrollbar(...)
"    let w:airline_section_z = '%{noscrollbar#statusline(9,''■'',''◫'',[''◧''],[''◨''])}'
"endfunction
"call airline#add_statusline_func('Noscrollbar')
