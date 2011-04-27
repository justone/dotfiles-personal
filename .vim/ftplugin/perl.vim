if exists("b:local_perlftplugin") | finish | endif
let b:local_perlftplugin = 1

" Make sure the continuation lines below do not cause problems in
" compatibility mode.
let s:save_cpo = &cpo

" keywords have colons
set isk+=:

" unfold the top level by default
setlocal foldlevel=1

" function to perl tidy
function! PerlTidy()
    let ptline = line('.')
    if executable('perltidy')
        %! perltidy -pbp
    else
        %! lwp-request -m POST http://perlster.com/tools/perltidy/service.pl
    endif
    exe ptline
endfunction

map <F9> :call PerlTidy()<CR>
map ,pt :call PerlTidy()<CR>

" perl syntax check
nmap <C-c><C-c> :!perl -Wc %<CR>

" Restore the saved compatibility options.
let &cpo = s:save_cpo
