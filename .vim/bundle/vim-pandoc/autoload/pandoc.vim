"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Folding:
"
" Taken from
" http://stackoverflow.com/questions/3828606/vim-markdown-folding/4677454#4677454
"
function! pandoc#MarkdownLevel()
    if getline(v:lnum) =~ '^# .*$'
        return ">1"
    endif
    if getline(v:lnum) =~ '^## .*$'
        return ">2"
    endif
    if getline(v:lnum) =~ '^### .*$'
        return ">3"
    endif
    if getline(v:lnum) =~ '^#### .*$'
        return ">4"
    endif
    if getline(v:lnum) =~ '^##### .*$'
        return ">5"
    endif
    if getline(v:lnum) =~ '^###### .*$'
        return ">6"
    endif
	if getline(v:lnum) =~ '^[^-=].\+$' && getline(v:lnum+1) =~ '^=\+$'
		return ">1"
	endif
	if getline(v:lnum) =~ '^[^-=].\+$' && getline(v:lnum+1) =~ '^-\+$'
		return ">2"
	endif
    return "="
endfunction

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Completion:

function! pandoc#Pandoc_Find_Bibfile()
    
    if !has('python')
        finish
    endif
    
python<<EOF
import vim
import os
from os.path import exists, relpath, expanduser, expandvars, isdir
from glob import glob
from subprocess import Popen, PIPE

bib_extensions = ["json", "ris", "mods", "biblates", "bib"]

if vim.current.buffer.name != None:
	file_name = ".".join(relpath(vim.current.buffer.name).split(".")[:-1])

	# first, we check for files named after the current file in the current dir
	bibfiles = [f for f in glob(file_name + ".*") if f.split(".")[-1] in bib_extensions]
else:
	bibfiles = []

# we search for any bibliography in the current dir
if bibfiles == []:
	bibfiles = [f for f in glob("*.*") if f.split(".")[-1] in bib_extensions]

# we search in pandoc's local data dir
if bibfiles == []:
	b = ""
	if exists(expandvars("$HOME/.pandoc/")):
		b = expandvars("$HOME/.pandoc/")
	elif exists(expandvars("%APPDATA%/pandoc/")):
		b = expandvars("%APPDATA%/pandoc/")
	if b != "":
		bibfiles = [f for f in glob(b + "default.*") if f.split(".")[-1] in bib_extensions]

# we search for bibliographies in texmf
if bibfiles == [] and vim.eval("executable('kpsewhich')") != '0':
	texmf = Popen(["kpsewhich", "-var-value", "TEXMFHOME"], stdout=PIPE, stderr=PIPE).\
                communicate()[0].strip()
	if exists(texmf):
		bibfiles = [f for f in glob(texmf + "/*") if f.split(".")[-1] in bib_extensions]

# we append the items in g:pandoc_bibfiles, if set
if vim.eval("exists('g:pandoc_bibfiles')") != "0":
	bibfiles.extend(vim.eval("g:pandoc_bibfiles"))

# we expand file paths, and
# check if the items in bibfiles are readable and not directories
bibfiles = list(map(lambda f : expanduser(expandvars(f)), bibfiles))
bibfiles = list(filter(lambda f : os.access(f, os.R_OK) and not isdir(f), bibfiles))

vim.command("let b:pandoc_bibfiles = " + str(bibfiles))
EOF
endfunction

function! pandoc#Pandoc_Complete(findstart, base)
	if a:findstart
		" return the starting position of the word
		let line = getline('.')
		let pos = col('.') - 1
		while pos > 0 && line[pos - 1] !~ '\\\|{\|\[\|<\|\s\|@\|\^'
			let pos -= 1
		endwhile

		let line_start = line[:pos-1]
		if line_start =~ '.*@$'
			let s:completion_type = 'bib'
		else
			let s:completion_type = ''
		endif
		return pos
	else
		"return suggestions in an array
		let suggestions = []
		if s:completion_type == 'bib'
			" suggest BibTeX entries
			"let suggestions = pandoc#Pandoc_BibKey(a:base)
			let suggestions = pandoc_bib#PandocBibSuggestions(a:base)
		endif
		return suggestions
	endif
endfunction

function! pandoc#PandocContext()
    let curline = getline('.')
    if curline =~ '.*@[^ ;\],]*$'
		return "\<c-x>\<c-o>"
    endif
endfunction
