""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => gtm (Git Time Metrics) plugin
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if &runtimepath =~ 'gtm-vim-plugin'
	"" Enable displaying it in the status line
	"let g:gtm_plugin_status_enabled = 1
	"" Add it to Airline
	"function! AirlineGTMInit()
	"if exists('*GTMStatusline')
	"  call airline#parts#define_function('gtmstatus', 'GTMStatusline')
	"  let g:airline_section_b = airline#section#create([g:airline_section_b, ' ', '[', 'gtmstatus', ']'])
	"endif
	"endfunction
	"autocmd User AirlineAfterInit call AirlineGTMInit()
endif
