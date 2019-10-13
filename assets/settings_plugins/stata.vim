"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Stata (Vim-Stata) plugin
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if &runtimepath =~ 'vim-stata'
	" Path to Stata - Set either one of these but not both. Paste in the path with the executable filename
	"	Example: On Linux, /usr/local/stata15/stata, On Windows C:\\Program Files\Stata\RunDo.exe
	" -- Option (1) Path to the Stata binary
	let g:vimforstata_pathbin_sh = "~/Programs/stata.sh"

	" -- Option (2) Path to shell script with code that runs Stata
	"let g:vimforstata_pathbin = ""

	" Select Do file lines and run them with Ctrl+Shift+X
	vmap <C-S-x> :<C-U>call RunDoLines()<CR><CR>
endif
