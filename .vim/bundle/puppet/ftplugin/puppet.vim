if exists("b:local_puppetftplugin") | finish | endif
let b:local_puppetftplugin = 1
let s:save_cpo = &cpo

" mark colons as part of the filename
setlocal isfname+=:

" puppet syntax check
nmap <C-c><C-c> :!puppet --parseonly --ignoreimport %<CR>

" remap gf to call our function that loads the filename under the cursor
nmap <buffer> gf :call PuppetEditFilename()<CR>
" same with C-wC-f, for opening in a split
nmap <C-w><C-f> :call PuppetEditFilename()<CR>

" Restore the saved compatibility options.
let &cpo = s:save_cpo
