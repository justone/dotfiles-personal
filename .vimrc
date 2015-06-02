set nocp
set ai to shell=/bin/bash terse nowarn sm ruler redraw sw=4 ts=4
"set noremap
set hls
set bs=2
set history=100
set showmode
set incsearch
"set ignorecase
set smartcase
set expandtab smarttab

" the famous leader character
let mapleader = ','
let maplocalleader = ","
" map backslash to comma so reversing line search is fast
nnoremap \ ,

" for some reason this has to go in .vimrc
let perl_fold = 1
let perl_fold_anonymous_subs = 1

set laststatus=2
let g:airline_powerline_fonts = 1

" configure syntastic
let g:syntastic_enable_signs = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_mode_map = { 'mode': 'active',
            \ 'passive_filetypes': ['puppet'] }
nmap <leader>st :SyntasticToggleMode<CR>

let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"

" detect if we're on redhat/centos < 6 and skip ultisnips
" older versions don't have a new enough version of python
if filereadable("/etc/redhat-release")
    let line = readfile("/etc/redhat-release")[0]
    let s:majorver = matchlist(line, '\(\d\)\(.\d*\)\? *(\(.*\))')[1]
    if s:majorver < 6
        let did_UltiSnips_vim=1
        let did_UltiSnips_vim_after=1
    endif
endif

" Easy searching within a range:
" step 1: Visual highlight the lines to search
" step 2: Type ,/
" step 3: Type the pattern you wish to find and hit enter
" bonus: Visual highlight a new area and just hit 'n' to search again
vmap <leader>/ <Esc>/\%V
" TODO: this one conflicts with mark.vim
"map <leader>/ /\%V

" from http://github.com/adamhjk/adam-vim
" nicer status line
"set laststatus=2
"set statusline=
"set statusline+=%-3.3n\ " buffer number
"set statusline+=%f\ " filename
"set statusline+=%h%m%r%w " status flags
"set statusline+=\[%{strlen(&ft)?&ft:'none'}] " file type
"set statusline+=%= " right align remainder
"set statusline+=0x%-8B " character value
"set statusline+=%-14(%l,%c%V%) " line, character
"set statusline+=%<%P " file position

" http://stackoverflow.com/questions/54255/in-vim-is-there-a-way-to-delete-without-putting-text-in-the-register
" replaces whatever is visually highlighted with what's in the paste buffer
"vmap r "_dP

" custom surroundings for confluence editing
" 'l' for literal
let g:surround_108 = "{{\r}}"
" 'n' for noformat
let g:surround_110 = "{noformat}\r{noformat}"

" Navigate wrapped lines
nnoremap j gj
nnoremap k gk
vnoremap j gj
vnoremap k gk

" always show 5 lines of context
set scrolloff=5

set wildmenu

" scroll up and down the page a little faster
nnoremap <C-e> 3<C-e>
nnoremap <C-y> 3<C-y>

" alias for quit all
map <leader>d :qa<CR>

" for editing files next to the open one
" http://vimcasts.org/episodes/the-edit-command/
noremap <leader>ew :e <C-R>=expand("%:p:h") . "/" <CR>
noremap <leader>es :sp <C-R>=expand("%:p:h") . "/" <CR>
noremap <leader>ev :vsp <C-R>=expand("%:p:h") . "/" <CR>
noremap <leader>et :tabe <C-R>=expand("%:p:h") . "/" <CR>

" use the octopress syntax for markdown files
au BufNewFile,BufRead *.markdown setfiletype octopress

" no default input
let g:ctrlp_default_input = 0
" set working dir starting at vim's working dir
let g:ctrlp_working_path_mode = 0
let g:ctrlp_mruf_relative = 1
let g:ctrlp_match_window = 'top,order:ttb,min:1,max:10,results:100'
let g:ctrlp_prompt_mappings = {
  \ 'ToggleMRURelative()': ['<c-w>'],
  \ 'PrtDeleteWord()':     ['<F2>']
  \ }
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/](local|blib)$'
  \ }
let g:ctrlp_map = '<leader>ff'
noremap <leader>fg :CtrlPRoot<CR>
noremap <leader>fr :CtrlPMRU<CR>
noremap <leader>fl :CtrlPMRU<CR>
noremap <leader>ft :CtrlPTag<CR>
noremap <leader>fb :CtrlPBuffer<CR>
noremap <leader>fc :CtrlPClearCache<CR>

" enable pathogen
filetype off
call pathogen#runtime_append_all_bundles()
call pathogen#helptags()

set bg=dark
"let g:solarized_termtrans = 1
"let g:solarized_termcolors = &t_Co
"colorscheme solarized
colorscheme ir_black
syntax enable

" turn filetype goodness back on
filetype on
filetype plugin on
filetype indent on

" settings for go
" fold go files with syntax
au FileType go setlocal foldmethod=syntax
au FileType go autocmd BufWritePre <buffer> Fmt
if executable("goimports")
    let g:gofmt_command = 'goimports'
endif

map <F2> :map<CR>
map <F7> :call ToggleSyntax()<CR>
map <F8> :set paste!<CR>
map <F10> :diffu<CR>
map <F11> :echo 'Current change: ' . changenr()<CR>
map <F12> :noh<CR>

map <leader>nt :NERDTreeToggle<CR>
map <leader>nf :NERDTreeFind<CR>

" Testing aliases
map ,tv :!./Build test --verbose 1 --test-files %<CR>

function! ToggleSyntax()
   if exists("g:syntax_on")
      syntax off
   else
      syntax enable
   endif
endfunction

runtime macros/matchit.vim

set foldmethod=marker

" printing options
set popt=paper:letter
set printdevice=dev_np24

" ruby settings
au BufNewFile,BufRead *.rhtml set sw=2 ts=2 bs=2 et smarttab
au BufNewFile,BufRead *.rb set sw=2 ts=2 bs=2 et smarttab

" .t files are perl
au BufNewFile,BufRead *.t set filetype=perl

" tt and mt files are tt2html
au BufNewFile,BufRead *.tt set filetype=tt2html
au BufNewFile,BufRead *.mt set filetype=tt2html

map ,cp :%w ! pbcopy<CR>

" older versions of this file contain helpers for HTML, JSP and Java

" sessionman.vim mappings
noremap <leader>sa :SessionSaveAs<CR>
noremap <leader>ss :SessionSave<CR>
noremap <leader>so :SessionOpen
noremap <leader>sl :SessionList<CR>
noremap <leader>sc :SessionClose<CR>

" don't be magical about the _ character in vimR
let vimrplugin_underscore = 0

" use system clipboard for everything
if has("gui_running")
    set cb=unnamed
    set guioptions-=T
endif

" Always do vimdiff in vertical splits
set diffopt+=vertical
" and ignore whitespace
"set diffopt+=iwhite

" look for tags
set tags=./tags;

" configure taglist.vim
let Tlist_GainFocus_On_ToggleOpen = 1
let Tlist_Close_On_Select = 1
noremap <leader>tl :TlistToggle<CR>

" use brew's ctags instead of the system one
if filereadable('/usr/local/bin/ctags')
    let Tlist_Ctags_Cmd = '/usr/local/bin/ctags'
    let g:autotagCtagsCmd = '/usr/local/bin/ctags'
endif

" tabular mappings (http://vimcasts.org/episodes/aligning-text-with-tabular-vim/)
nmap <Leader>a= :Tabularize /=<CR>
vmap <Leader>a= :Tabularize /=<CR>
nmap <Leader>a: :Tabularize /:\zs<CR>
vmap <Leader>a: :Tabularize /:\zs<CR>
nmap <Leader>a> :Tabularize /=><CR>
vmap <Leader>a> :Tabularize /=><CR>

" enable persistent undo
if v:version >= 703

    " ensure undo directory exists
    if !isdirectory("~/.vimundo")
        call system("mkdir ~/.vimundo")
    endif

    set undodir=~/.vimundo
    set undofile
    set undolevels=1000
    set undoreload=10000
endif

" make searches the most magical
"nnoremap / /\v
"vnoremap / /\v
"noremap :s :s/\v

if &diff
    " silence syntastic
    let g:loaded_syntastic_plugin = 1
else
    " nothing yet
endif

" allow writing files as root
command! W silent w !sudo tee % > /dev/null

if filereadable(expand("~/.vimrc.local"))
    source ~/.vimrc.local
endif

" http://stackoverflow.com/questions/7400743/create-a-mapping-for-vims-command-line-that-escapes-the-contents-of-a-register-b
cnoremap <c-x> <c-r>=<SID>PasteEscaped()<cr>
function! s:PasteEscaped()
  echo "\\".getcmdline()."\""
  let char = getchar()
  if char == "\<esc>"
    return ''
  else
    let register_content = getreg(nr2char(char))
    let escaped_register = escape(register_content, '\'.getcmdtype())
    return substitute(escaped_register, '\n', '\\n', 'g')
  endif
endfunction

" use space bar to open/close folds
nnoremap <space> za

" http://vim.wikia.com/wiki/Search_for_visually_selected_text
vnoremap <silent> * :<C-U>
  \let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
  \gvy/<C-R><C-R>=substitute(
  \escape(@", '/\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
  \gV:call setreg('"', old_reg, old_regtype)<CR>
vnoremap <silent> # :<C-U>
  \let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
  \gvy?<C-R><C-R>=substitute(
  \escape(@", '?\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
  \gV:call setreg('"', old_reg, old_regtype)<CR>

" clear highlight quick
nnoremap <leader><Space> :nohls<CR>

" easy tab navigation
nnoremap <silent> <C-N> :tabnext<CR>
nnoremap <silent> <C-P> :tabprev<CR>

" vimux config
if strlen($TMUX)
    let tmuxver = system("tmux -V")
    if matchstr(tmuxver, '1.8') || matchstr(tmuxver, '1.9')
        function! InterruptRunnerAndRunLastCommand()
            :VimuxInterruptRunner
            :VimuxRunLastCommand
        endfunction

        let g:VimuxRunnerType = 'pane'
        let g:VimuxUseNearest = 1

        function! ToggleVimuxType()
            if g:VimuxRunnerType == 'window'
                let g:VimuxRunnerType = 'pane'
                let g:VimuxUseNearest = 1
                echo "VimuxType -> pane"
            else
                call VimuxCloseRunner()
                let g:VimuxRunnerType = 'window'
                let g:VimuxUseNearest = 0
                echo "VimuxType -> window"
            end
        endfunction
        command! ToggleVimuxType call ToggleVimuxType()

        noremap <Leader>tp :VimuxPromptCommand<CR>
        noremap <Leader>tr :VimuxRunLastCommand<CR>
        noremap <Leader>tt :call InterruptRunnerAndRunLastCommand()<CR>
        noremap <Leader>ti :VimuxInspectRunner<CR>
        noremap <Leader>tx :VimuxCloseRunner<CR>
        noremap <Leader>tc :VimuxInterruptRunner<CR>
        noremap <Leader>tz :VimuxZoomRunner<CR>
    else
        noremap <Leader>tp :echo "Upgrade tmux to 1.8"<CR>
    endif
endif

" sideways.vim
nnoremap <leader>h :SidewaysLeft<cr>
nnoremap <leader>l :SidewaysRight<cr>

" pandoc
nmap <leader>vv :!pandoc -t html -T 'Pandoc Generated - "%"' --smart --standalone --self-contained --data-dir %:p:h -c ~/.dotfiles/css/pandoc.css "%" \|bcat<cr><cr>
nmap <leader>vp :!pandoc -t html -T 'Pandoc Generated - "%"' --smart --standalone --self-contained --data-dir %:p:h -c ~/.dotfiles/css/buttondown.css "%" \|bcat<cr><cr>

" clojure rainbow parens
au BufEnter *.clj RainbowParenthesesActivate
au BufEnter *.cljs RainbowParenthesesActivate
au Syntax clojure RainbowParenthesesLoadRound
au Syntax clojure RainbowParenthesesLoadSquare
au Syntax clojure RainbowParenthesesLoadBraces

" support mapping from old version of vim-surround
xmap s <Plug>VSurround

" configure vim-pipe
let g:vimpipe_invoke_map="<leader>w"
let g:vimpipe_close_map="<leader>W"

" configure clojure folding
let g:clojure_foldwords = "defn,defmacro,defmethod"

let g:pymode_options = 0
let g:pymode_lint_options_mccabe = { 'complexity': 20 }

let g:vim_json_syntax_conceal = 0
au FileType json setlocal foldmethod=syntax

function! OpenURL(url)
  if has("unix")
    let s:uname = system("uname")
    if s:uname == "Darwin\n"
      call system("open ".a:url)
    else
      call pmb#openurl(a:url)
    endif
  endif
endfunction

" open web browser, mostly for vim-fugitive
command! -nargs=1 Browse call OpenURL(<f-args>)
