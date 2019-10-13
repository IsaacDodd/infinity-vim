""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Markdown plugins (Vim Instant Markdown)
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if &runtimepath =~ 'vim-instant-markdown'
	" Settings for the vim-instant-markdown plugin
	let g:instant_markdown_slow = 1                     " Slows execution due to realtime updates to keep Vim at its normal speed
	let g:instant_markdown_autostart = 1                " automatically launch the preview window when you open a markdown file
	let g:instant_markdown_open_to_the_world = 0        " 0 = the server only listens on localhost, and not available to others in your network
	let g:instant_markdown_allow_unsafe_content = 0     " 0 = blocks scripts from running
	let g:instant_markdown_allow_external_content = 0   " 0 = block external resources such as images, stylesheets, frames and plugins
endif
