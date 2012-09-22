" yield.vim -- Interactive tests
" @Author:      Thomas Link (mailto:micathom AT gmail com?subject=[vim])
" @Website:     http://www.vim.org/account/profile.php?user_id=4037
" @License:     GPL (see http://www.gnu.org/licenses/gpl.txt)
" @Created:     2009-02-21.
" @Last Change: 2012-09-22.
" @Revision:    0.0.40

let s:save_cpo = &cpo
set cpo&vim


" Compare the current buffer with the contents of filename after 
" |:exe|cuting expr.
" Useful for testing normal commands, mappings etc.
function! should#yield#Buffer(...) "{{{3
    if a:0 == 1
        let expr = ''
        let filename = a:1
    elseif a:0 == 2
        let [expr, filename] = a:000
    else
        throw "spec: should#yield#Buffer: Must provide either one or two arguments"
    endif
    " TLogVAR &selection
    " TLogVAR expr, filename
    " TLogVAR getline(1, '$')
    if !empty(expr)
        call should#__Eval(expr)
    endif
    let buf = getline(1, '$')
    let file = readfile(filename)
    " TLogVAR buf, file
    return s:CompareLines(buf, file)
endf


" Compare the current buffer with the contents of filename after 
" |:exe|cuting expr but ignore changes in whitespace.
function! should#yield#SqueezedBuffer(expr, filename) "{{{3
    call should#__Eval(a:expr)
    let buf = getline(1, '$')
    call s:Squeeze(buf)
    let file = readfile(a:filename)
    call s:Squeeze(file)
    return s:CompareLines(buf, file)
endf


function! s:CompareLines(lines1, lines2) "{{{3
    " TLogVAR a:lines1, a:lines2
    for i in range(len(a:lines1))
        let line1 = a:lines1[i]
        let line2 = a:lines2[i]
        if line1 != line2
            call should#__Explain('In line '. (i + 1) .': Expected '. line2 .' but got '. line1)
            return 0
        endif
    endfor
    return 1
endf


function! s:Squeeze(lines) "{{{3
    call map(a:lines, 'substitute(v:val, ''^\s\+'',   "",  "")')
    call map(a:lines, 'substitute(v:val, ''\s\+$'',   "",  "")')
    call map(a:lines, 'substitute(v:val, ''\s\{2,}'', " ", "g")')
endf


let &cpo = s:save_cpo
unlet s:save_cpo
