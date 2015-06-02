
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
    let $PMB_KEY = ''
endfunction

function! remotecopy#getkey()
    if strlen($PMB_KEY) == 0
        let output = system("pmb copy-key")
        let $PMB_KEY = input("Input key: ")
    endif
endfunction

function remotecopy#rcopy(data)
    call remotecopy#getkey()
    let output = system("pmb remotecopy", a:data)
    echo "Remote copied."
endfunction

let &cpo = s:save_cpo
