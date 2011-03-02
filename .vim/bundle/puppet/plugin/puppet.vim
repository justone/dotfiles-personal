if (exists("g:loaded_puppet") && g:loaded_puppet) || v:version < 700
    finish
endif
let g:loaded_puppet = 1

let s:cpo_save = &cpo

function! PuppetEditFilename(split)
    let l:fname = expand('<cfile>')

    if match(l:fname, '/') == -1
        " no / in the name, meaning it's a puppet include
        if match(l:fname, '::') == -1 
            " TODO: check for init.pp vs {l:fname}.pp
            let l:fname = l:fname . '/manifests/init.pp'
        else
            let l:fname =  substitute(substitute(substitute(l:fname,'::','/','g'),'$','.pp',''),'/','/manifests/','')
        endif
    else
        if match(l:fname, '^puppet:') != -1
            " this is a file, like this:
            " puppet:///modules/mt_ci/config.xml
            " convert to:
            " mt_ci/files/config.xml
            let l:fname = substitute(substitute(l:fname,'^puppet:///modules/','',''),'/','/files/','')
        else
            " this is a template, like this:
            " mt_ci/user_config.xml.erb
            " convert to:
            " mt_ci/templates/user_config.xml.erb
            let l:fname = substitute(l:fname,'/','/templates/','')
        endif
    endif

    if a:split
        exec "split ".l:fname
    else
        exec "edit ".l:fname
    endif
endfunction

let &cpo = s:cpo_save
