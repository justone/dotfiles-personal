" settings for all perl files
set equalprg=perltidy\ -pbp\ -nse\ -nst

" function to perl tidy
function! PerlTidy()
    let ptline = line('.')
    if filereadable('/usr/bin/perltidy') || filereadable('/Users/nate/perl5/bin/perltidy')
        %! perltidy -pbp
    else
        %! lwp-request -m POST http://perlster.com/tools/perltidy/service.pl
    endif
    exe ptline
endfunction

map <F9> :call PerlTidy()<CR>
map ,pt :call PerlTidy()<CR>

" originally (aka inspired by) http://www.slideshare.net/c9s/perlhacksonvim
fun! GetCursorModName()
  let cw=substitute( expand("<cWORD>"), '.\{-}\(\(\w\+\)\(::\w\+\)*\).*$', '\1', '')
  return cw
endfunction

fun! TranslateModName(n)
  return substitute( a:n, '::', '/', 'g') . '.pm'
endfunction

fun! GetPerlIncs()
  let out = system( "perl -e 'print join \"\\n\", @INC'" )
  let paths = split( out, "\n" )
  return paths
endfunction

fun! FindMod()
  let paths = GetPerlIncs()
  let fname = TranslateModName( GetCursorModName() )

  if filereadable('lib/' . fname)
    split 'lib/' . fname
    return
  endif

  for p in paths
    let fullpath = p . '/' . fname
    if filereadable(fullpath)
      exec 'split ' . fullpath
      return
    endif
  endfor
endfunction

nmap <Leader>fm :call FindMod()<cr>

