" autoload/pandoc_exe.vim
"
" Defines pandoc_execute and pandoc_exec#PandocExecute, for executors
"
    if !has('python')
        finish
    endif

python<<EOF
import vim
import sys
import re, string
import shlex
from os.path import exists, relpath, basename, splitext
from subprocess import call, Popen, PIPE

pandoc_variable_substitutions = {
	# current file
	"%%": lambda r: relpath(vim.current.buffer.name),
	# current file, w/o extension
	"%:r": lambda r: splitext(relpath(vim.current.buffer.name))[0],
	# the values in b:pandoc_bibfiles, as arguments for a pandoc-compatible program
	"PANDOC#P_BIBS" : lambda r: " ".join(["--bibliography "+ i for i in vim.eval('b:pandoc_bibfiles')]),
	# the values in b:pandoc_bibfiles, as a list
	"PANDOC#BIBS" : lambda r: " ".join(vim.eval("b:pandoc_bibfiles"))
}

def pandoc_execute(command, output_type="html", open_when_done=False):
	# first, we parse the command description as a list of strings
	steps = []
	for step in command.split("|"):
		step = step.strip()
		# we substitute some variables
		for sub in pandoc_variable_substitutions:
			step = re.sub(sub, pandoc_variable_substitutions[sub], step)
		steps.append(step)

	out = splitext(vim.current.buffer.name)[0] + "." + output_type

	# now, we run the pipe
	procs = {}
	procs[0] = Popen(shlex.split(steps[0]), stdout=PIPE)
	if len(steps) > 1:
		i = 1
		for p in steps[1:]:
			procs[i] = Popen(shlex.split(p), stdin=procs[i-1].stdout, stdout=PIPE)
			procs[i-1].stdout.close()
	output = procs[len(procs) - 1].communicate()[0]

	# we create a temporary buffer where the command and its output will be shown
	
	# we always splitbelow
	splitbelow = bool(int(vim.eval("&splitbelow")))
	if not splitbelow:
		vim.command("set splitbelow")
	
	vim.command("5new")
	vim.current.buffer[0] = "# Press <Esc> to close this"
	vim.current.buffer.append("▶ " + " | ".join(steps))
	try:
		for line in output.split("\n"):
			vim.current.buffer.append(line)
	except:
		pass
	vim.command("setlocal nomodified")
	vim.command("setlocal nomodifiable")
	# pressing <esc> on the buffer will delete it
	vim.command("map <buffer> <esc> :bd<cr>")
	# we will highlight some elements in the buffer
	vim.command("syn match PandocOutputMarks /^>>/")
	vim.command("syn match PandocCommand /^▶.*$/hs=s+1")
	vim.command("syn match PandocInstructions /^#.*$/")
	vim.command("hi! link PandocOutputMarks Operator")
	vim.command("hi! link PandocCommand Statement")
	vim.command("hi! link PandocInstructions Comment")

	# we revert splitbelow to its original value
	if not splitbelow:
		vim.command("set nosplitbelow")

	# finally, we open the created file
	if exists(out) and open_when_done:
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
			
		Popen([pandoc_open_command,  out + pandoc_open_command_tail], stdout=PIPE, stderr=PIPE)
EOF

function! pandoc_exec#PandocExecute(command, type, open_when_done)
python<<EOF
pandoc_execute(vim.eval("a:command"), vim.eval("a:type"), bool(int(vim.eval("a:open_when_done"))))
EOF
endfunction
