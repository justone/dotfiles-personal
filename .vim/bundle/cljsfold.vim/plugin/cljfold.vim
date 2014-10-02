if !exists('g:clojure_foldwords')
  let g:clojure_foldwords = "def,ns"
endif

function! CompareLispword(line)
  let fwc = split(g:clojure_foldwords,",")

  for fw in fwc
    if a:line =~ '^\s*('.fw.'.*'
      return 1
    elseif a:line =~ '^\s*(\w*/'.fw.'.*'
      return 1
    endif
  endfor
endfunction

function! GetClojureFold()
      if CompareLispword(getline(v:lnum))
        return ">1"
      elseif getline(v:lnum) =~ '^\s*$'
            let my_cljnum = v:lnum
            let my_cljmax = line("$")

            while (1)
                  let my_cljnum = my_cljnum + 1
                  if my_cljnum > my_cljmax
                        return "<1"
                  endif

                  let my_cljdata = getline(my_cljnum)

                  if my_cljdata =~ '^$'
                        return "<1"
                  else
                        return "="
                  endif
            endwhile
      else
            return "="
      endif
endfunction

function! StartClojureFolding()
  setlocal foldexpr=GetClojureFold()
  setlocal foldmethod=expr
endfunction

augroup ft_clojure
    au!
    au BufNewFile,BufRead *.clj set filetype=clojure
    au FileType clojure silent! call StartClojureFolding()
    au FileType clojure setlocal report=100000
augroup END
