" @Author:      Tom Link (mailto:micathom AT gmail com?subject=[vim])
" @Website:     http://www.vim.org/account/profile.php?user_id=4037
" @License:     GPL (see http://www.gnu.org/licenses/gpl.txt)
" @Created:     2009-03-06.
" @Last Change: 2009-03-06.

let s:save_cpo = &cpo
set cpo&vim

if exists('g:spec_run')
    finish
endif


unlet! g:spec_foo
exec 'Spec '. expand('<sfile>:p:h') .'/included.vim'

" TLog exists('*SpecFoo')
if exists('*SpecFoo')
    throw "Should not exists('*SpecFoo')"
endif

" TLog exists('g:spec_foo')
if exists('g:spec_foo')
    throw "Should not exists('g:spec_foo')"
endif


let &cpo = s:save_cpo
unlet s:save_cpo
