set lines=50 columns=160
colorscheme ir_black
set guifont=Monaco\ for\ Powerline:h10
set vb

if filereadable(expand("~/.gvimrc.local"))
    source ~/.gvimrc.local
endif
