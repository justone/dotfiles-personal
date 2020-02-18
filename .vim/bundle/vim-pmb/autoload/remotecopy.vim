
if exists('s:loaded') && s:loaded
    finish
endif
let s:loaded = 1

let s:save_cpo = &cpo
set cpo&vim

let s:secret = 'none'

function! remotecopy#docopy(visual, line1, line2)
    " if it's a visual selection
    if (a:visual)

        " save the old value of the default register
        let old_reg = getreg('"')
        let old_regtype=getregtype('"')

        " grab the last visual selection
        normal! gvy

        " send it
        call remotecopy#rcopy(getreg('"'))

        " restore old register value
        call setreg('"', old_reg, old_regtype)
    else

        " if not visual, then just send the entire file
        call remotecopy#rcopy(join(getline(a:line1, a:line2),"\r"))
    endif
endfunction

function! remotecopy#copyreg()
    call remotecopy#rcopy(getreg(v:register))
endfunction

function! remotecopy#clearkey()
    let s:key = ''
    let $PMB_KEY = ''
    let output = system("pmb key clear")
    echo "Key cleared."
endfunction

function! remotecopy#getkey()
    let s:key = ""
    while strlen(s:key) == 0
        let output = system("pmb key copy")
        let s:key = input("Input key: ")
        let output = system("pmb key check -f -", s:key)
        if v:shell_error != 0
            let s:key = ''
        endif
    endwhile
endfunction

function! remotecopy#storekey()
    if strlen(s:key) > 0
        let output = system("pmb key store -f -", s:key)
        if v:shell_error != 0
            let $PMB_KEY = s:key
        endif
    endif
endfunction

function remotecopy#cachekey()
    if strlen($PMB_KEY) == 0
        let output = system("pmb key get -l")
        if v:shell_error != 0
            call remotecopy#getkey()
            call remotecopy#storekey()
        endif
    endif
endfunction

function remotecopy#rcopy(data)
    call remotecopy#cachekey()

    let output = system("pmb remotecopy", a:data)
    echo "Remote copied."
endfunction

let &cpo = s:save_cpo
