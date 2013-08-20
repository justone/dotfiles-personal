"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" ftplugin/pandoc.vim
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if !has('python')
    echoe "vim compiled without python support: vim-pandoc functions limited"
endif


" # Formatting options

" Soft/hard word wrapping
if exists("g:pandoc_use_hard_wraps") && g:pandoc_use_hard_wraps
	"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
	" hard wrapping at 79 chars (like in gq default)
	if &textwidth == 0
		setlocal textwidth=79
	endif
	" t: wrap on &textwidth
	" n: keep inner indent for list items.
	setlocal formatoptions=tn
	" will detect numbers, letters, *, +, and - as list headers, according to
	" pandoc syntax.
	" TODO: add support for roman numerals
	setlocal formatlistpat=^\\s*\\([*+-]\\\|\\((*\\d\\+[.)]\\+\\)\\\|\\((*\\l[.)]\\+\\)\\)\\s\\+
	
	if exists("g:pandoc_auto_format") && g:pandoc_auto_format
		" a: auto-format
		" w: lines with trailing spaces mark continuing
		" paragraphs, and lines ending on non-spaces end paragraphs.
		" we add `w` as a workaround to `a` joining compact lists.
		setlocal formatoptions+=aw
	endif
else
	"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
	" soft wrapping
	setlocal formatoptions=1
	setlocal linebreak
	setlocal breakat-=*
        setlocal wrap     " soft wrap doesn't make sense without it
        setlocal nolist   " linebreak doesn't work if list is on
	"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
	" Remappings that make j and k behave properly with
	" soft wrapping.
    "
    " Commenting these out per issue 77: not appropriate to have this stuff
    " in a ftplugin.
    "
	" nnoremap <buffer> j gj
	" nnoremap <buffer> k gk
	" vnoremap <buffer> j gj
	" vnoremap <buffer> k gk
	" 
	" " same goes for 0, ^ and $
	" nnoremap <buffer> 0 g0
	" nnoremap <buffer> ^ g^
	" nnoremap <buffer> $ g$
	" vnoremap <buffer> 0 g0
	" vnoremap <buffer> ^ g^
	" vnoremap <buffer> $ g$

	"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
	" Show partial wrapped lines
	setlocal display=lastline
endif


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" # Do not add two spaces at end of punctuation when joining lines
"
setlocal nojoinspaces

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" # Use pandoc to tidy up text
"
" If you use this on your entire file, it will wipe out title blocks.
" To preserve title blocks, use :MarkdownTidy instead. (If you use
" :MarkdownTidy on a portion of your file, it will insert unwanted title
" blocks...)
"
let &l:equalprg="pandoc -t markdown --reference-links"
if &textwidth > 0
    let &l:equalprg.=" --columns " . &textwidth
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" HTML style comments
"
setlocal commentstring=<!--%s-->
setlocal comments=s:<!--,m:\ \ \ \ ,e:-->

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" # Folding sections with ATX style headers.
"
if !exists("g:pandoc_no_folding") || !g:pandoc_no_folding
	setlocal foldexpr=pandoc#MarkdownLevel()
	setlocal foldmethod=expr
endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" # Voom support
"
if exists(":Voom")
	noremap <buffer><silent> <localleader>o :Voom markdown<cr>
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" # Use ctrl-X ctrl-K for dictionary completions.
"
" This adds citation keys from a file named citationkeys.dict in the pandoc data dir to the dictionary.
" 
if has("unix") || has("macunix")
	setlocal dictionary+=$HOME."/.pandoc/citationkeys.dict"
else
	setlocal dictionary+=%APPDATA%."/pandoc/citationkeys.dict"
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" # Autocomplete citationkeys using function
"
if has('python')
    call pandoc#Pandoc_Find_Bibfile()

    let s:completion_type = ""
    setlocal omnifunc=pandoc#Pandoc_Complete
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" # Supertab support
"
if exists("g:SuperTabDefaultCompletionType")
	let g:SuperTabDefaultCompletionType = "context"

	if exists('g:SuperTabCompletionContexts')
		let b:SuperTabCompletionContexts =
		\ ['pandoc#PandocContext'] + g:SuperTabCompletionContexts
	endif
"
" disable supertab completions after bullets and numbered list
" items (since one commonly types something like `+<tab>` to
" create a list.)
"
let b:SuperTabNoCompleteAfter = ['^', '\s', '^\s*\(-\|\*\|+\|>\|:\)', '^\s*(\=\d\+\(\.\=\|)\=\)']
endif
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" # Commands that call Pandoc
"
" ## Tidying Commands
"
" Markdown tidy with hard wraps
" (Note: this will insert an empty title block if no title block 
" is present; it will wipe out any latex macro definitions)

command! -buffer MarkdownTidyWrap %!pandoc -t markdown -s

" Markdown tidy without hard wraps
" (Note: this will insert an empty title block if no title block 
" is present; it will wipe out any latex macro definitions)

command! -buffer MarkdownTidy %!pandoc -t markdown --no-wrap -s

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" # Some executors
" 

" We create some commands and mappings from our list of executors. See
" plugin/pandoc.vim

if has('python')

python<<EOF
for opener in pandoc_executors:
	name, mapping, type, command = opener
	if command not in ("", "None", None):
		opening_executor = 'call pandoc_exec#PandocExecute("' + command + '", "' + type + '" , 1)'
		nonopening_executor = 'call pandoc_exec#PandocExecute("' + command + '", "' + type + '", 0)'
		if name not in ("", "None", None):
			vim.command("command! -buffer " + name + " exec '" + nonopening_executor + "'")
			vim.command("command! -buffer " + name + "Open" + " exec '" + opening_executor + "'")
			vim.command("menu Pandoc.Executors." + name + "   " + \
			            " :" + nonopening_executor + "<cr>")
			vim.command("menu Pandoc.Executors." + name + "Open" + "   " + \
			            " :" + opening_executor + "<cr>")
		if mapping not in ("", "None", None):
			vim.command("map <buffer><silent> " + mapping + \
						" :" + nonopening_executor + "<cr>")
			vim.command("map <buffer><silent> " + mapping + "+" + \
						" :" + opening_executor + "<cr>")
EOF

endif

" While I'm at it, here are a few more functions mappings that are useful when
" editing pandoc files.
"
" Open link under cursor in browser
"
map <buffer><silent> <LocalLeader>www :call pandoc_misc#Pandoc_Open_URI()<cr>

"" Jump forward to existing reference link (or footnote link)
map <buffer><silent> <LocalLeader>gr :call pandoc_misc#Pandoc_Goto_Ref()<cr>

"" Jump back to existing reference link (or fn link)
map <buffer><silent> <LocalLeader>br :call pandoc_misc#Pandoc_Back_From_Ref()<cr>

"" Add new reference link (or footnote link) after current paragraph. (This
"" works better than the snipmate snippet for doing this.)
map <buffer><silent> <LocalLeader>nr ya[o<CR><ESC>p$a:

