" Set fold levels to all be open by default (zm's the file maximally --  use zr to reduce the folds after opening) -- [/su/567352]
autocmd BufWinEnter * let &foldlevel = max(map(range(1, line('$')), 'foldlevel(v:val)'))
