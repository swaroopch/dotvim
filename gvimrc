" My GVimrc file
" Maintainer: swaroop@swaroopch.com

" Logical size of GVim window
set lines=35 columns=99

" Don't display the menu or toolbar. Just the screen.
set guioptions-=m
set guioptions-=T

" Font.
if has('mac')
    set guifont=Menlo:h16
elseif has('unix')
    let &guifont="DejaVu Sans Mono 10"
endif

" vim: filetype=vim
