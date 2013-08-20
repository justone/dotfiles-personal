" autoload/pandoc_misc.vim
"
" Some miscelaneous functions

    if !has('python')
        finish
    endif


python<<EOF
import vim
import sys
import re, string
from subprocess import Popen, PIPE

def pandoc_get_reflabel():
	pos = vim.current.window.cursor
	current_line = vim.current.line
	cursor_idx = pos[1] - 1
	label = None
	ref = None
	
	# we first search for explicit and non empty implicit refs
	label_regex = "\[.*\]"
	for label_found in re.finditer(label_regex, current_line):
		if label_found.start() -1 <= cursor_idx and label_found.end() - 2 >= cursor_idx:
			label = label_found.group()
			if re.match("\[.*?\]\[.*?]", label):
				if ref == '':
					ref = label.split("][")[0][1:]
				else:
					ref = label.split("][")[1][:-1]
				label = "[" + ref  + "]"
				break
	
	# we now search for empty implicit refs or footnotes
	if not ref:
		label_regex = "\[.*?\]"
		for label_found in re.finditer(label_regex, current_line):
			if label_found.start() - 1 <= cursor_idx and label_found.end() - 2 >= cursor_idx:
				label = label_found.group()
				break

	return label
EOF

function! pandoc_misc#Pandoc_Open_URI()
python<<EOL
line = vim.current.line
pos = vim.current.window.cursor[1] - 1
url = ""

# graciously taken from
# http://stackoverflow.com/questions/1986059/grubers-url-regular-expression-in-python/1986151#1986151
pat = r'\b(([\w-]+://?|www[.])[^\s()<>]+(?:\([\w\d]+\)|([^%s\s]|/)))'
pat = pat % re.escape(string.punctuation)
for match in re.finditer(pat, line):
	if match.start() - 1 <= pos and match.end() - 2 >= pos:
		url = match.group()
		break
if url != '':
	if sys.platform == "darwin":
		pandoc_open_command = "open" #OSX
	elif sys.platform.startswith("linux"):
		pandoc_open_command = "xdg-open" # freedesktop/linux
	elif sys.platform.startswith("win"):
		pandoc_open_command = 'cmd /x \"start' # Windows
	# On windows, we pass commands as an argument to `start`,
	# which is a cmd.exe builtin, so we have to quote it
	if sys.platform.startswith("win"):
		pandoc_open_command_tail = '"'
	else:
		pandoc_open_command_tail = ''
	Popen([pandoc_open_command, url + pandoc_open_command_tail], stdout=PIPE, stderr=PIPE)
	print url
else:
	print "No URI found."
EOL
endfunction

function! pandoc_misc#Pandoc_Goto_Ref()
python<<EOL
ref_label = pandoc_get_reflabel()
if ref_label:
	ref = ref_label[1:-1]
	# we build a list of the labels and their position in the file
	labels = {}
	lineno = 0
	for line in vim.current.buffer:
		match = re.match("^\s*\[.*(?=]:)", line)
		lineno += 1
		if match:
			labels[match.group().strip()[1:]] = lineno

	if labels.has_key(ref):
		vim.command(str(labels[ref]))
EOL
endfunction

function! pandoc_misc#Pandoc_Back_From_Ref()
python<<EOL
label_regex = ''

match = re.match("^\s?\[.*](?=:)", vim.current.line)
if match:
	label_regex = match.group().replace("[", "\[").replace("]", "\]").replace("^", "\^")
else:
	label = pandoc_get_reflabel()
	if label:
		label_regex = label.replace("[", "\[").replace("]", "\]").replace("^", "\^")

if label_regex != '':
	found = False
	lineno = vim.current.window.cursor[0]
	for line in reversed(vim.current.buffer[:lineno-1]):
		lineno = lineno - 1
		matches_in_this_line = list(re.finditer(label_regex, line))
		for ref in reversed(matches_in_this_line):
			vim.command(str(lineno) + " normal!" + str(ref.start()) + "l")
			found = True
			break
		if found:
			break
EOL
endfunction
