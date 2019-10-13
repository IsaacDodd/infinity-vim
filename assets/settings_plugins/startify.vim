"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Startify plugin
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Mapped key to quickly open Startify in a new tab
nnoremap <Leader>st :tabnew<CR>:Startify<CR>
" Starts both Startify and NERDTree at the same time.
if &runtimepath =~ 'nerdtree'
	augroup PluginStartifyNERDTreeLoad
		autocmd!
		autocmd VimEnter *
			\   if !argc()
			\ |   NERDTree
			\ |   wincmd w
			\ |   Startify
			\ | endif
	augroup END
endif

let g:startify_custom_header = []

let g:vimsetup_asciiheader1 = [
	\ '',
	\ '.##.....##.####.##.....##..######..########.########.##.....##.########.',
	\ '.##.....##..##..###...###.##....##.##..........##....##.....##.##.....##',
	\ '.##.....##..##..####.####.##.......##..........##....##.....##.##.....##',
	\ '.##.....##..##..##.###.##..######..######......##....##.....##.########.',
	\ '..##...##...##..##.....##.......##.##..........##....##.....##.##.......',
	\ '...##.##....##..##.....##.##....##.##..........##....##.....##.##.......',
	\ '....###....####.##.....##..######..########....##.....#######..##.......',
	\ ''
	\]

let g:vimsetup_asciiheader2 = [
	\ '',
	\ ' __  __  ______     ,   ,     ',
	\ '/\ \/\ \/\__  _\   / \_/ \    ',
	\ '\ \ \ \ \/_/\ \/  /\      \   ',
	\ ' \ \ \ \ \ \ \ \  \ \ \__\ \  ',
	\ '  \ \ \_/ \ \_\ \__\ \ \_/\ \ ',
	\ '   \ `\___/ /\_____\\ \_\\ \_\',
	\ '    `\/__/  \/_____/ \/_/ \/_/',
	\ '',
	\ '',
	\ ''
	\]

"let g:startify_custom_header = []
let g:startify_custom_header = g:vimsetup_asciiheader2
