if has("python") == 1
python<<EOF
# We register openers with PandocRegisterExecutor. 
# We take its first argument as the name of a vim ex command, the second
# argument as a mapping, and the rest as the description of a command,
# which we'll pass to pandoc_open.

# pandoc_register_executor(...) adds a tuple of those elements to a list of
#executors. This list will be # read from by ftplugin/pandoc.vim and commands
#and mappings will be created from it.
pandoc_executors = []

def pandoc_register_executor(com_ref):
	args = com_ref.split()
	name = args[0]
	mapping = args[1]
	type = args[2]
	command = args[3:]
	pandoc_executors.append((name, mapping, type, " ".join(command)))
EOF

command! -nargs=? PandocRegisterExecutor exec 'py pandoc_register_executor("<args>")'

" We register here some default executors. The user can define other custom
" commands in his .vimrc.
"
" Generate html and open in default html viewer
PandocRegisterExecutor PandocHtml <LocalLeader>html html pandoc -t html -Ss -o %:r.html %%
" Generate pdf w/ citeproc and open in default pdf viewer
PandocRegisterExecutor PandocPdf <LocalLeader>pdf pdf pandoc --latex-engine xelatex PANDOC#P_BIBS -o %:r.pdf %%
" Generate odt w/ citeproc and open in default odt viewer
PandocRegisterExecutor PandocOdt <LocalLeader>odt odt pandoc -t odt PANDOC#P_BIBS -o %:r.odt %%
endif
