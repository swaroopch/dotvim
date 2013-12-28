" My Vimrc file
" Maintainer: swaroop@swaroopch.com

"" Vim, not Vi.
" This must be first, because it changes other options as a side effect.
set nocompatible
" required! by vundle
filetype off

"" Vundle
"" See :help vundle for more details
set runtimepath+=~/.vim/bundle/vundle/
call vundle#rc()

" let Vundle manage Vundle
" required! by vundle
Bundle 'gmarik/vundle'

" Git Repos by http://vim-scripts.org ( get names from https://github.com/vim-scripts/following )
"Bundle 'Conque-Shell'
"Bundle 'JSON.vim'
"Bundle 'calendar.vim--Matsumoto'
"Bundle 'django.vim'
"Bundle 'nginx.vim'
"Bundle 'python.vim--Vasiliev'
"Bundle 'utl.vim'
Bundle 'paredit.vim'

" Git Repos on GitHub
" Inspired from http://sontek.net/turning-vim-into-a-modern-python-ide
"Bundle 'AD7six/vim-independence'
"Bundle 'Lokaltog/vim-easymotion'
"Bundle 'Lokaltog/vim-powerline'
"Bundle 'altercation/vim-colors-solarized'
"Bundle 'chriskempson/vim-tomorrow-theme'
"Bundle 'davidhalter/jedi-vim'
"Bundle 'fuenor/vim-wordcount'
"Bundle 'gmarik/ide-popup.vim'
"Bundle 'godlygeek/tabular'
"Bundle 'hsitz/VimOrganizer'
"Bundle 'kien/rainbow_parentheses.vim'
"Bundle 'majutsushi/tagbar'
"Bundle 'mattn/zencoding-vim'
"Bundle 'nathanaelkane/vim-indent-guides'
"Bundle 'roman/golden-ratio'
"Bundle 'scrooloose/syntastic'
"Bundle 'sjl/gundo.vim'
"Bundle 'sjl/threesome.vim'
"Bundle 'swaroopch/vim-markdown'
"Bundle 'swaroopch/vim-markdown-preview'
"Bundle 'tpope/vim-git'
"Bundle 'tpope/vim-surround'
"Bundle 'tpope/vim-unimpaired'
Bundle 'chrisbra/NrrwRgn'
Bundle 'guns/vim-clojure-static'
Bundle 'jceb/vim-orgmode'
Bundle 'jnwhiteh/vim-golang'
Bundle 'juvenn/mustache.vim'
Bundle 'kien/ctrlp.vim'
Bundle 'mileszs/ack.vim'
Bundle 'msanders/snipmate.vim'
Bundle 'nvie/vim-flake8'
Bundle 'scrooloose/nerdcommenter'
Bundle 'scrooloose/nerdtree'
Bundle 'sukima/xmledit'
Bundle 'tpope/vim-classpath'
Bundle 'tpope/vim-fireplace'
Bundle 'tpope/vim-fugitive'
Bundle 'tpope/vim-speeddating'
Bundle 'vim-pandoc/vim-pandoc'

" Git Repos not on GitHub
"Bundle 'git://git.wincent.com/command-t.git'

"" General Settings

" Enable syntax highlighting.
syntax on

" Line endings should be Unix-style unless the file is from someone else.
set fileformat=unix
au BufNewFile * set fileformat=unix

" Automatically indent when adding a curly bracket, etc.
" required! by vundle
filetype plugin indent on
set autoindent
set smartindent

" Tabs converted to 4 spaces
set shiftwidth=4
set tabstop=4
set expandtab
set smarttab
set backspace=indent,eol,start

" Set up backup dir where the swap files are stored
"set dir=~/.vim/backup,~/tmp,/tmp
"set backupdir=~/.vim/backup,~/tmp,/tmp

" Disable the F1 help key
map <F1> <Esc>
imap <F1> <Esc>

" Show special characters
if v:version >= 700
    set list listchars=tab:>-,trail:.,extends:>,nbsp:_
else
    set list listchars=tab:>-,trail:.,extends:>
endif

" Don't break up long lines, but visually wrap them.
set textwidth=0
set wrap

" Text mode
command TextMode setlocal nolist wrap linebreak scrolloff=999

" Highlight current line
"set cursorline

" http://vim.wikia.com/wiki/Move_cursor_by_display_lines_when_wrapping
nnoremap <silent> j gj
nnoremap <silent> k gk
vnoremap <silent> j gj
vnoremap <silent> k gk

" Minimal number of screen lines to keep above and below the cursor.
" This keeps the cursor always in the vertical middle of the screen.
set scrolloff=999

" Use UTF-8
set encoding=utf-8

" Status line
set laststatus=2
set statusline=
set statusline+=%-3.3n\                         " buffer number
set statusline+=%f\                             " filename
set statusline+=%h%m%r%w                        " status flags
if isdirectory(expand("~/.vim/bundle/vim-fugitive", ":p"))
    set statusline+=%{fugitive#statusline()}        " git status
endif
if isdirectory(expand("~/.vim/bundle/syntastic", ":p"))
    set statusline+=%{SyntasticStatuslineFlag()}    " syntastic status - makes sense with :Errors
endif
set statusline+=\[%{strlen(&ft)?&ft:'none'}]    " file type
set statusline+=%=                              " right align remainder
set statusline+=0x%-8B                          " character value
set statusline+=%-14(%l,%c%V%)                  " line, character
set statusline+=%<%P                            " file position

" Tab line
" Refer ':help setting-guitablabel'
function GuiTabLabel()
    let label = ''
    let bufnrlist = tabpagebuflist(v:lnum)

    " Add '+' if one of the buffers in the tab page is modified
    for bufnr in bufnrlist
        if getbufvar(bufnr, '&modified')
            let label = '[+] '
            break
            break
        endif
    endfor

    " Append the number of windows in the tab page if more than one
    let wincount = tabpagewinnr(v:lnum, '$')
    if wincount > 1
        let label .= wincount
    endif
    if label != ''
        let label .= ' '
    endif

    return label

endfunction

set guitablabel=%{GuiTabLabel()}\ %t

" Show line number, cursor position.
set ruler

" Display incomplete commands.
set showcmd

" Search as you type.
set incsearch

" Ignore case while searching
set ignorecase

" Make /g flag default when doing :s
set gdefault

" Show autocomplete menus
set wildmenu

" Show editing mode
set showmode

" Ignore certain filetypes when doing filename completion
set wildignore=*.sw*,*.pyc,*.bak

" Show matching brackets
set showmatch

" Bracket blinking
set matchtime=2

" Split new window below current one
set splitbelow

" Error bells are displayed visually.
set visualbell

" Automatically read files which have been changed outside of Vim, if we
" haven't changed it already.
set autoread

" Disable highlighting after search. Too distracting.
set nohlsearch

" To save, ctrl-s.
nmap <c-s> :w<CR>
imap <c-s> <Esc>:w<CR>a

" Reformatting options. See `:help fo-table`
set formatoptions+=lnor1

" Disable spellcheck by default
set nospell
autocmd BufRead,BufNewFile * setlocal nospell
" To enable again, use:
" setlocal spell spelllang=en_us

" Say a message
function! Say(msg)
    echohl IncSearch
    echo a:msg
    echohl None
endfunction

" Copy full buffer to OS clipboard.
function! CopyAll()
    normal mzggVG"+y'z
    call Say("Copied.")
endfunction
command A call CopyAll()

" Delete buffer contents and Paste from OS clipboard.
function! PasteFromClipboard()
    normal ggVGd"+p1G
    call Say("Pasted.")
endfunction
command B call PasteFromClipboard()

" Markdown files are plain text files
autocmd FileType markdown TextMode
autocmd FileType pandoc TextMode
let g:pandoc_no_folding = 1
" Allow these file extensions to be accessed via 'gf' of only the name, for
" e.g. gf on [[AnotherPage]] should go to AnotherPage.pd
set suffixesadd=.pd,.txt

if has('python') " Assumes Python >= 2.6

    " Quick way to open a filename under the cursor in a new tab
    " (or URL in a browser)
    function! Open()
python <<EOF
import re
import platform
import vim

def launch(uri):
    if platform.system() == 'Darwin':
        vim.command('!open {}'.format(uri))
    elif platform.system() == 'Linux':
        vim.command('!firefox -new-tab {}'.format(uri))

def is_word(text):
    return re.match(r'^[\w./?%:#&=~+-]+$', text) is not None

filename_start = filename_end = vim.current.window.cursor[1] # (row, col)

while filename_start >= 0 and is_word(vim.current.line[filename_start:filename_start+1]):
    filename_start -= 1
filename_start += 1

while filename_end <= len(vim.current.line) and is_word(vim.current.line[filename_end:filename_end+1]):
    filename_end += 1

filename = vim.current.line[filename_start:filename_end]

if filename.endswith('.md') or filename.endswith('.txt'):
    vim.command('tabedit {0}'.format(filename))

elif filename.lower().startswith('http') or filename.lower().startswith('www.'):
    if filename.lower().startswith('www.'):
        filename = 'http://{0}'.format(filename)
    filename = filename.replace('#', r'\#').replace('%', r'\%').replace('~', r'\~')
    launch(filename)

else:
    launch(filename)
EOF

    endfunction

    command O call Open()
    map <Leader>o :call Open()<CR>

" Add the virtualenv's site-packages to vim path
python << EOF
import os.path
import sys
import vim
if 'VIRTUAL_ENV' in os.environ:
    project_base_dir = os.environ['VIRTUAL_ENV']
    sys.path.insert(0, project_base_dir)
    activate_this = os.path.join(project_base_dir, 'bin/activate_this.py')
    execfile(activate_this, dict(__file__=activate_this))
EOF

endif " python

" Remove the Windows ^M (copied from http://amix.dk/vim/vimrc.html)
map <Leader>d mmHmt:%s/<C-V><cr>//ge<cr>'tzt'm

" See `:help key-notation`
" Shortcuts for moving between tabs
" Alt-j to move to the tab to the left
noremap <A-j> :tabN<CR>
noremap <D-j> :tabN<CR>
" Alt-k to move to the tab to the right
noremap <A-k> :tabn<CR>
noremap <D-k> :tabn<CR>

" Shortcut for moving between windows
nnoremap <c-j> :wincmd w<CR>

" Shortcut to insert date
inoremap <F5> <C-R>=strftime("%a, %d %b %Y")<CR>

" http://items.sjbach.com/319/configuring-vim-right
" Marks
nnoremap ' `
nnoremap ` '

" matchit
runtime! macros/matchit.vim

" Python
let python_highlight_all=1
" PEP8 compliance - http://www.python.org/dev/peps/pep-0008/
autocmd FileType python set colorcolumn=100

"" Bundle-specific configurations

" Bundle 'VimClojure'
let g:vimclojure#ParenRainbow = 1

" Bundle 'godlygeek/tabular'
"command -range AlignFirstEquals :<line1>,<line2>Tabularize /^[^=]*\zs/
"command -range AlignFirstColon  :<line1>,<line2>Tabularize /^[^:]*\zs/

" Bundle 'scrooloose/nerdtree'
let NERDTreeIgnore=['\.pyc$', '\.rbc$', '\~$']
map <Leader>n :NERDTreeToggle<CR>

" Bundle 'mileszs/ack.vim'
nmap <Leader>a <Esc>:Ack!<space>

" Bundle 'tpope/vim-fugitive'
" http://vimcasts.org/blog/2011/05/the-fugitive-series/
autocmd BufReadPost fugitive://* set bufhidden=delete

" Bundle 'scrooloose/syntastic'
let g:syntastic_enable_signs=1

" XML, HTML
function TagExpander()
    if exists("b:did_ftplugin")
      unlet b:did_ftplugin
    endif
    runtime! ftplugin/xml.vim ftplugin/xml_*.vim ftplugin/xml/*.vim
endfunction

autocmd FileType xml   call TagExpander()
autocmd FileType html  call TagExpander()
autocmd FileType eruby call TagExpander()
autocmd FileType htmljinja call TagExpander()
autocmd FileType htmldjango call TagExpander()

" Ruby
autocmd BufRead,BufNewFile {Gemfile,Rakefile,config.ru} setlocal ft=ruby
autocmd FileType ruby setlocal tabstop=2 shiftwidth=2

" YAML
autocmd FileType yaml setlocal tabstop=2 shiftwidth=2

" Web
autocmd FileType json setlocal tabstop=2 shiftwidth=2
autocmd FileType javascript setlocal tabstop=2 shiftwidth=2
autocmd FileType html setlocal tabstop=2 shiftwidth=2
autocmd FileType css setlocal tabstop=2 shiftwidth=2

" Clojure
autocmd FileType clojure setlocal tabstop=2 shiftwidth=2

" Sudo to write
cmap w!! w !sudo tee % >/dev/null

" Assume Bash is my shell (:help sh.vim)
let g:is_bash = 1

" Reload all windows in all tabs, useful after I do a 'git rebase -i'
command Reedit :tabdo windo edit!

" Default color scheme
set background=dark

" NOTE: On Mac OS X, best used with [iTerm 2](http://www.iterm2.com)
colorscheme desert

" Mac
if has('mac')
    set macmeta
endif

" Local config
let vimrc_local = expand("~/.vimrc.local", ":p")
if filereadable(vimrc_local)
    execute 'source' vimrc_local
endif
unlet vimrc_local

" vim: filetype=vim
