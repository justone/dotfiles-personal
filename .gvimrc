set lines=50 columns=160
colorscheme ir_black
set guifont=Monaco\ for\ Powerline\ Nerd\ Font\ Plus\ Font\ Awesome\ Plus\ Octicons\ Plus\ Pomicons:h16
set vb

if filereadable(expand("~/.gvimrc.local"))
    source ~/.gvimrc.local
endif
