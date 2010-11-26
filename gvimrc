" Theme
colorscheme railscasts

" Logical size of GVim window
set lines=35 columns=99

" Don't display the menu or toolbar. Just the screen.
set guioptions-=m
set guioptions-=T

" Font.
if has('mac')
    set guifont=Monaco:h13
elseif has('unix')
    let &guifont="Monospace 10"
endif

" vim: filetype=vim
