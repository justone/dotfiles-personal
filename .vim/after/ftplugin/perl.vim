if exists("b:local_afterperlftplugin") || v:version < 700 | finish | endif
let b:local_afterperlftplugin = 1

let s:save_cpo = &cpo

" grab the path as set by perl.vim
let b:bufferpath=&l:path

" look up the tree for a lib dir and add it too
let s:selfpath = expand("%:p:h")

while strlen(s:selfpath) > 1
    if match(s:selfpath, 'lib$') != -1
        break
    endif
    let s:selfpath = fnamemodify(s:selfpath, ':h')
endwhile

if strlen(s:selfpath) > 1
    let b:bufferpath=s:selfpath . "," . b:bufferpath
endif

" then look for something that ends in libs (libs or perl-libs)
" and add all anything under that that has a lib dir in it
let s:selfpath = expand("%:p:h")

while strlen(s:selfpath) > 1
    if match(s:selfpath, 'libs$') != -1
        break
    endif

    " check if there's a directory next to an ancestor
    " if so, include it instead
    let s:siblingdir = glob(s:selfpath . '/' . '*libs')
    if !empty(s:siblingdir) && isdirectory(s:siblingdir)
        let s:selfpath = s:siblingdir
        break
    endif
    let s:selfpath = fnamemodify(s:selfpath, ':h')
endwhile

if strlen(s:selfpath) > 1
    let s:libdirs = filter(map(split(globpath(s:selfpath, '*'), "\n"), 'substitute(v:val, "$", "/lib", "")'), 'isdirectory(v:val)')
    let s:libpath = join(s:libdirs, ',')
    if exists('b:bufferpath')
        let b:bufferpath = s:libpath . "," . b:bufferpath
    else
        let b:bufferpath = s:libpath
    endif
endif

au BufEnter <buffer> let &l:path=b:bufferpath

" Restore the saved compatibility options.
let &cpo = s:save_cpo
