"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => EditorConfig plugin
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" To ensure that this plugin works well with Tim Pope's fugitive & To avoid loading EditorConfig for any remote files over ssh
let g:EditorConfig_exclude_patterns = ['fugitive://.\*', 'scp://.\*']
