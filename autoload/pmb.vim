if exists('s:loaded') && s:loaded
    finish
endif
let s:loaded = 1

let s:save_cpo = &cpo
set cpo&vim

function pmb#openurl(url)
    call remotecopy#cachekey()
    let output = system('pmb openurl "'.a:url.'"')
endfunction

let &cpo = s:save_cpo
