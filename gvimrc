" My GVimrc file
" Maintainer: swaroop@swaroopch.com

" Logical size of GVim window
set lines=35 columns=99

" Don't display the menu or toolbar. Just the screen.
set guioptions-=m
set guioptions-=T

" Font and Color
set background=dark
if has('mac')
    set guifont=Menlo:h12
elseif has('unix')
    let &guifont="Ubuntu Mono 14"
    colorscheme desert
endif

" vim: filetype=vim
