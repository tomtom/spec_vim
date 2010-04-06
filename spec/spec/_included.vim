" @Author:      Tom Link (mailto:micathom AT gmail com?subject=[vim])
" @Website:     http://www.vim.org/account/profile.php?user_id=4037
" @License:     GPL (see http://www.gnu.org/licenses/gpl.txt)
" @Created:     2009-03-06.
" @Last Change: 2009-03-06.

let s:save_cpo = &cpo
set cpo&vim



SpecBegin 'title': 'Included File',
            \ 'cleanup': ['SpecFoo()']
            " \ 'sfile': '<+SCRIPT CONTEXT+>',
            " \ 'scratch': '<+SCRATCH FILE+>',
            " \ 'before': '<+BEFORE EX COMMANDS+>',
            " \ 'after': '<+AFTER EX COMMANDS+>'

It should remove temporary global variables & functions when done.
let g:spec_foo = 1

function! SpecFoo(a) "{{{3
    return a:a * 2
endf



let &cpo = s:save_cpo
unlet s:save_cpo
