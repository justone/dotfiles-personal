set nocp
set ai to shell=/bin/bash nowarn sm ruler sw=4 ts=4
if !has('nvim')
  set redraw
else
  set inccommand=nosplit
endif
"set noremap
set hls
set bs=2
set history=100
set showmode
set incsearch
"set ignorecase
set smartcase
set expandtab smarttab
set switchbuf=usetab,split

" the famous leader character
let mapleader = ','
let maplocalleader = ","
" map backslash to comma so reversing line search is fast
nnoremap \ ,

nnoremap <C-u> <C-u>zz
nnoremap <C-d> <C-d>zz
nnoremap n nzz
nnoremap N Nzz

if filereadable(expand("~/.vimrc.local"))
    source ~/.vimrc.local
endif

" Async Lint Engine config
let g:ale_linters = {'clojure': ['clj-kondo']}
let g:ale_pattern_options = {'conjure-log.*.cljc': {'ale_enabled': 0}}
" Easy navigation between errors
map [w <Plug>(ale_previous_wrap)
map ]w <Plug>(ale_next_wrap)

" for some reason this has to go in .vimrc
let perl_fold = 1
let perl_fold_anonymous_subs = 1

set laststatus=2
let g:airline_powerline_fonts = 1

" for gitgutter
set updatetime=100

let g:vmt_fence_text = 'MarkdownTOC'
let g:vmt_fence_closing_text = '/MarkdownTOC'
let g:vmt_fence_hidden_markdown_style = 'GFM'

" Enable global session caching (for Taboo)
set sessionoptions+=globals
" add tab number to tabs
let g:taboo_renamed_tab_format = " %N [%l]%m "
let g:taboo_tab_format = " %N %f%m "

" show current function/module/etc in airline
let g:airline#extensions#tagbar#enabled = 1
let g:airline#extensions#tagbar#flags = 'f'
let g:airline_section_z = '%{airline#util#wrap(airline#extensions#obsession#get_status(),0)}%3p%% %#__accent_bold#%{g:airline_symbols.linenr}%4l%#__restore__#%#__accent_bold#/%L%{g:airline_symbols.maxlinenr}%#__restore__# :%3v [  %{&tabstop}/%{&shiftwidth}]'
" let g:airline_left_sep = ''
" let g:airline_right_sep = ''
" let g:airline_left_sep = ''
" let g:airline_right_sep = ''
" let g:airline_left_sep = ''
" let g:airline_right_sep = ''
" let g:airline_left_sep = ''
" let g:airline_right_sep = ''
" let g:airline_left_sep = ''
" let g:airline_right_sep = ''
" let g:airline_left_sep = ''
" let g:airline_right_sep = ''
let g:airline_symbols = {}
let g:airline_symbols.branch = ''

set completeopt-=preview

if filereadable(expand(".vimrc.project"))
    source .vimrc.project
endif

" conjure
au BufNewFile,BufRead,BufWinEnter conjure-log-* setlocal winfixwidth
" au BufNewFile,BufRead,BufWinEnter conjure-log-* setlocal winfixheight
au BufNewFile,BufRead,BufWinEnter conjure-log-* normal 80|
" au BufNewFile,BufRead,BufWinEnter conjure-log-* normal 18_
let g:conjure#client#clojure#nrepl#eval#auto_require = v:false
let g:conjure#log#botright = v:true
" let g:conjure#client#clojure#nrepl#eval#print_options#length = 100
" let g:conjure#highlight#enabled = v:true
" let g:conjure#log#fold#enabled = v:true
let g:conjure#filetypes = ["clojure", "fennel", "janet", "racket"]
let g:conjure#filetype#pandoc = 'conjure.client.clojure.nrepl'
let g:conjure#filetype#markdown = 'conjure.client.clojure.nrepl'
let g:sexp_filetypes = 'clojure,scheme,lisp,timl'
let g:conjure#client#clojure#nrepl#connection#auto_repl#enabled = v:false

" vim-pandoc and vim-pandoc-syntax

" Uncomment to use vim-markdown for formatting
" let g:pandoc#filetypes#handled = ["pandoc", "markdown"]
" let g:pandoc#filetypes#pandoc_markdown = 0

let g:pandoc#folding#fdc=0
" let g:pandoc#syntax#conceal#urls=1

let g:pandoc#folding#mode='stacked'
let g:pandoc#modules#enabled=['yaml', 'bibliographies', 'completion', 'command', 'folding', 'formatting', 'indent', 'menu', 'metadata', 'keyboard', 'toc', 'spell', 'hypertext']


" This doesn't seem to work
let g:markdown_fenced_languages = ['clojure', 'python', 'ruby']

" coc.vim
let g:coc_global_extensions = ['coc-conjure']

" disable syntastic, trying out ALE
let g:loaded_syntastic_plugin = 1

" configure syntastic
let g:syntastic_enable_signs = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_rst_checkers = ['sphinx']
let g:syntastic_clojure_checkers = ['joker', 'clj_kondo']
let g:syntastic_mode_map = { 'mode': 'active',
            \ 'passive_filetypes': ['python', 'puppet', 'rst'] }
nmap <leader>st :SyntasticToggleMode<CR>

au BufNewFile,BufRead */fiddle/* let b:syntastic_mode="passive"

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

" settings for vim-mark.vim
let g:mwDefaultHighlightingPalette = 'maximum'
nmap <Leader>M <Plug>MarkToggle
nmap <Leader>N <Plug>MarkAllClear

" settings for gist-vim
let g:gist_browser_command = 'pmb openurl %URL%'
let g:gist_clip_command = 'pmb openurl'
let g:gist_open_browser_after_post = 0

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
noremap <leader>ew :e <C-R>=expand("%:.:h") . "/" <CR>
noremap <leader>es :sp <C-R>=expand("%:.:h") . "/" <CR>
noremap <leader>ev :vsp <C-R>=expand("%:.:h") . "/" <CR>
noremap <leader>et :tabe <C-R>=expand("%:.:h") . "/" <CR>

" use the octopress syntax for markdown files
au BufNewFile,BufRead *.markdown setfiletype octopress

" no default input
let g:ctrlp_default_input = 0
" set working dir starting at vim's working dir
let g:ctrlp_working_path_mode = 0
let g:ctrlp_follow_symlinks = 1
let g:ctrlp_mruf_relative = 1
let g:ctrlp_match_window = 'top,order:ttb,min:1,max:10,results:100'
let g:ctrlp_prompt_mappings = {
  \ 'ToggleMRURelative()': ['<c-w>'],
  \ 'PrtDeleteWord()':     ['<F2>']
  \ }
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/](local|blib|target|node_modules)$'
  \ }
let g:ctrlp_map = '<leader>ff'
noremap <leader>fg :CtrlPRoot<CR>
noremap <leader>fr :CtrlPMRU<CR>
noremap <leader>fl :CtrlPMRU<CR>
noremap <leader>ft :CtrlPTag<CR>
noremap <leader>fb :CtrlPBuffer<CR>
noremap <leader>fc :CtrlPClearCache<CR>

let g:pymode_options = 0
let g:pymode_run = 0
let g:pymode_lint_checkers = ['pyflakes', 'pep8', 'pylint']
let g:pymode_rope_complete_on_dot = 0

" configure vim-table-mode
let g:table_mode_realign_map = '<Leader>tR'
au FileType rst let g:table_mode_header_fillchar='='
au FileType rst let g:table_mode_corner_corner='+'
au FileType markdown let g:table_mode_corner='|'
au FileType pandoc let g:table_mode_corner='|'

let g:sexp_enable_insert_mode_mappings = 0

" Vim REST Console
 let g:vrc_curl_opts={
	\'--include': '',
	\'--show-error': '',
	\'--silent': ''
	\}

let g:vrc_auto_format_response_patterns = {
	\'json': 'jq "."'
	\}

" enable pathogen
filetype off
" let g:pathogen_blacklist = ['tagbar']
call pathogen#infect()
call pathogen#helptags()

if has('nvim')
  set termguicolors
endif

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

" settings for javascript/jsx
au FileType javascript.jsx setlocal foldmethod=syntax
au FileType javascript.jsx setlocal foldnestmax=1

" settings for ruby
au FileType ruby setlocal foldmethod=syntax
let ruby_foldable_groups = 'def'

" settings for go
" fold go files with syntax
au FileType go setlocal foldmethod=syntax
au FileType go setlocal foldnestmax=1
" use goimports for formatting
let g:go_fmt_command = "goimports"
let g:go_fmt_experimental=1
let g:go_doc_keywordprg_enabled = 1
let g:go_play_browser_command = 'pmb openurl %URL%'

map <F2> :map<CR>
map <F7> :call ToggleSyntax()<CR>
map <F8> :set paste!<CR>
map <F10> :diffu<CR>
map <F11> :echo 'Current change: ' . changenr()<CR>
map <F12> :noh<CR>

" remove trailing whitespace when writing
autocmd BufWritePre * :%s/\s\+$//e

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

" ack.vim --- {{{
"
" From: https://www.freecodecamp.org/news/how-to-search-project-wide-vim-ripgrep-ack/

" Use ripgrep for searching ⚡️
" Options include:
" --vimgrep -> Needed to parse the rg response properly for ack.vim
" --smart-case -> Search case insensitive if all lowercase pattern, Search case sensitively otherwise
let g:ackprg = 'rg --vimgrep --smart-case'

" Auto close the Quickfix list after pressing '<enter>' on a list item
" let g:ack_autoclose = 1

" Any empty ack search will search for the work the cursor is on
let g:ack_use_cword_for_empty_search = 1

" Don't jump to first match
cnoreabbrev Ack Ack!

" Maps <leader>/ so we're ready to type the search keyword
nnoremap <leader>A :Ack!<CR>
nnoremap <leader>S :Ack!<space>
" }}}

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
    let tmuxver = str2float(matchstr(system("tmux -V"), '\d\d*\.\d\d*'))
    if tmuxver >= 1.8
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
        noremap <Leader>ty :call InterruptRunnerAndRunLastCommand()<CR>
        noremap <Leader>ti :VimuxInspectRunner<CR>
        noremap <Leader>tx :VimuxCloseRunner<CR>
        noremap <Leader>tc :VimuxInterruptRunner<CR>
        noremap <Leader>tz :VimuxZoomRunner<CR>
    else
        noremap <Leader>tp :echo "Upgrade tmux to at least 1.8"<CR>
    endif
endif

" vim-test config
if strlen($TMUX)
  let test#strategy = "vimux"
elseif has('nvim')
  let test#strategy = "neovim"
endif
let g:test#python#pytest#options = '--verbose'
noremap <leader>tn :TestNearest<CR>
noremap <leader>tf :TestFile<CR>
noremap <leader>ta :TestSuite<CR>
noremap <leader>tl :TestLast<CR>

" sideways.vim
nnoremap <leader>h :SidewaysLeft<cr>
nnoremap <leader>l :SidewaysRight<cr>

" pandoc
nmap <leader>vv :!pandoc -t html+smart -M title:'Pandoc Generated - "%"' --standalone --self-contained --data-dir %:p:h -c ~/.dotfiles/css/pandoc.css "%" \|bcat<cr><cr>
nmap <leader>vtv :!pandoc -t html+smart -M title:'Pandoc Generated - "%"' --toc --standalone --self-contained --data-dir %:p:h -c ~/.dotfiles/css/pandoc.css "%" \|bcat<cr><cr>
nmap <leader>vp :!pandoc -t html+smart -M title:'Pandoc Generated - "%"' --standalone --self-contained --data-dir %:p:h -c ~/.dotfiles/css/buttondown.css "%" \|bcat<cr><cr>
nmap <leader>vtp :!pandoc -t html+smart -M title:'Pandoc Generated - "%"' --toc --standalone --self-contained --data-dir %:p:h -c ~/.dotfiles/css/buttondown.css "%" \|bcat<cr><cr>

" clojure rainbow parens
let g:rainbow_active = 1
let g:rainbow_conf = {
      \  'guifgs': ['royalblue3', 'darkorange3', 'seagreen3', 'firebrick'],
      \  'ctermfgs': ['lightblue', 'lightyellow', 'lightcyan', 'lightmagenta'],
      \  'parentheses': ['start=/(/ end=/)/ fold', 'start=/\[/ end=/\]/ fold', 'start=/{/ end=/}/ fold'],
      \  'separately': {
      \      '*': 0,
      \      'clojure': {},
      \  }
      \}

" support mapping from old version of vim-surround
xmap s <Plug>VSurround

" configure vim-pipe
let g:vimpipe_invoke_map="<leader>w"
let g:vimpipe_close_map="<leader>W"

" configure clojure folding
let g:clojure_foldwords = "def,defn,defmacro,defmethod,defschema,defprotocol,defrecord,use-fixtures"

" allow formatting longer clojure forms
let g:clojure_maxlines = 0

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

" CoC.nvim config
nmap <silent> <C-J>                 <Plug>(coc-diagnostic-next)
nmap <silent> <C-K>                 <Plug>(coc-diagnostic-prev)
nmap <silent> <Leader>c             <Plug>(coc-codeaction-cursor)
nmap <silent> <Leader>K             :call CocAction('doHover')<CR>
nmap <silent> <Leader>ci            :call CocAction('showIncomingCalls')<CR>
nmap <silent> <Leader>cl            <Plug>(coc-codeaction-line)
nmap <silent> <Leader>co            :call CocAction('showOutgoingCalls')<CR>
nmap <silent> <Leader>cr            <Plug>(coc-rename)
nmap <silent> <Leader>cs            <Plug>(coc-references)
nmap <silent> gI                    :call CocAction('jumpImplementation')<CR>
nmap <silent> gd                    :call CocAction('jumpDefinition')<CR>
nmap <silent> gD                    :call CocAction('jumpDefinition', 'split')<CR>

function! Expand(exp) abort
    let l:result = expand(a:exp)
    return l:result ==# '' ? '' : "file://" . l:result
endfunction

" Highlight symbol under cursor on CursorHold
" autocmd CursorHold * silent call CocActionAsync('highlight')
" vmap <leader>f <Plug>(coc-format-selected)
" nmap <leader>f <Plug>(coc-format-selected)

nnoremap <silent> <p :call CocRequest('clojure-lsp', 'workspace/executeCommand', {'command': 'drag-backward', 'arguments': [Expand('%:p'), line('.') - 1, col('.') - 1]})<CR>
nnoremap <silent> >p :call CocRequest('clojure-lsp', 'workspace/executeCommand', {'command': 'drag-forward', 'arguments': [Expand('%:p'), line('.') - 1, col('.') - 1]})<CR>
nnoremap <silent> crcc :call CocRequest('clojure-lsp', 'workspace/executeCommand', {'command': 'cycle-coll', 'arguments': [Expand('%:p'), line('.') - 1, col('.') - 1]})<CR>
nnoremap <silent> crsm :call CocRequest('clojure-lsp', 'workspace/executeCommand', {'command': 'sort-map', 'arguments': [Expand('%:p'), line('.') - 1, col('.') - 1]})<CR>
nnoremap <silent> crth :call CocRequest('clojure-lsp', 'workspace/executeCommand', {'command': 'thread-first', 'arguments': [Expand('%:p'), line('.') - 1, col('.') - 1]})<CR>
nnoremap <silent> crtt :call CocRequest('clojure-lsp', 'workspace/executeCommand', {'command': 'thread-last', 'arguments': [Expand('%:p'), line('.') - 1, col('.') - 1]})<CR>
nnoremap <silent> crtf :call CocRequest('clojure-lsp', 'workspace/executeCommand', {'command': 'thread-first-all', 'arguments': [Expand('%:p'), line('.') - 1, col('.') - 1]})<CR>
nnoremap <silent> crtl :call CocRequest('clojure-lsp', 'workspace/executeCommand', {'command': 'thread-last-all', 'arguments': [Expand('%:p'), line('.') - 1, col('.') - 1]})<CR>
nnoremap <silent> cruw :call CocRequest('clojure-lsp', 'workspace/executeCommand', {'command': 'unwind-thread', 'arguments': [Expand('%:p'), line('.') - 1, col('.') - 1]})<CR>
nnoremap <silent> crua :call CocRequest('clojure-lsp', 'workspace/executeCommand', {'command': 'unwind-all', 'arguments': [Expand('%:p'), line('.') - 1, col('.') - 1]})<CR>
nnoremap <silent> crml :call CocRequest('clojure-lsp', 'workspace/executeCommand', {'command': 'move-to-let', 'arguments': [Expand('%:p'), line('.') - 1, col('.') - 1, input('Binding name: ')]})<CR>
nnoremap <silent> cril :call CocRequest('clojure-lsp', 'workspace/executeCommand', {'command': 'introduce-let', 'arguments': [Expand('%:p'), line('.') - 1, col('.') - 1, input('Binding name: ')]})<CR>
nnoremap <silent> crel :call CocRequest('clojure-lsp', 'workspace/executeCommand', {'command': 'expand-let', 'arguments': [Expand('%:p'), line('.') - 1, col('.') - 1]})<CR>
nnoremap <silent> cram :call CocRequest('clojure-lsp', 'workspace/executeCommand', {'command': 'add-missing-libspec', 'arguments': [Expand('%:p'), line('.') - 1, col('.') - 1]})<CR>
nnoremap <silent> crcn :call CocRequest('clojure-lsp', 'workspace/executeCommand', {'command': 'clean-ns', 'arguments': [Expand('%:p'), line('.') - 1, col('.') - 1]})<CR>
nnoremap <silent> crcp :call CocRequest('clojure-lsp', 'workspace/executeCommand', {'command': 'cycle-privacy', 'arguments': [Expand('%:p'), line('.') - 1, col('.') - 1]})<CR>
nnoremap <silent> cris :call CocRequest('clojure-lsp', 'workspace/executeCommand', {'command': 'inline-symbol', 'arguments': [Expand('%:p'), line('.') - 1, col('.') - 1]})<CR>
nnoremap <silent> cref :call CocRequest('clojure-lsp', 'workspace/executeCommand', {'command': 'extract-function', 'arguments': [Expand('%:p'), line('.') - 1, col('.') - 1, input('Function name: ')]})<CR>
nnoremap <silent> cred :call CocRequest('clojure-lsp', 'workspace/executeCommand', {'command': 'extract-to-def', 'arguments': [Expand('%:p'), line('.') - 1, col('.') - 1, input('Def name: ')]})<CR>
nnoremap <silent> crdk :call CocRequest('clojure-lsp', 'workspace/executeCommand', {'command': 'destructure-keys', 'arguments': [Expand('%:p'), line('.') - 1, col('.') - 1]})<CR>
nnoremap <silent> crrk :call CocRequest('clojure-lsp', 'workspace/executeCommand', {'command': 'restructure-keys', 'arguments': [Expand('%:p'), line('.') - 1, col('.') - 1]})<CR>
nnoremap <silent> crcf :call CocRequest('clojure-lsp', 'workspace/executeCommand', {'command': 'create-function', 'arguments': [Expand('%:p'), line('.') - 1, col('.') - 1]})<CR>



if filereadable(expand("~/.vimrc.local.after"))
    source ~/.vimrc.local.after
endif

" Possible things to put in ~/.vimrc.local.after

" Enable kaocha in test runner
" let g:conjure#client#clojure#nrepl#test#call_suffix = '{:kaocha/reporter [kaocha.report/documentation]}'
" let g:conjure#log#strip_ansi_escape_sequences_line_limit = 0
" let g:conjure#client#clojure#nrepl#test#runner = 'kaocha'
" if has('nvim')
"   let s:baleia = luaeval("require('baleia').setup { line_starts_at = 3 }")
"   autocmd BufWinEnter conjure-log-* call s:baleia.automatically(bufnr('%'))
" endif

" augroup disableCocInDiff
"   autocmd!
"   autocmd DiffUpdated * let b:coc_enabled=0
" augroup END
