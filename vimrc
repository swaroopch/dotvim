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
Bundle 'JSON.vim'
Bundle 'VimClojure'
Bundle 'django.vim'
Bundle 'nginx.vim'
Bundle 'python.vim--Vasiliev'
"Bundle 'Conque-Shell'

" Git Repos on GitHub
" Inspired from http://sontek.net/turning-vim-into-a-modern-python-ide
Bundle 'AD7six/vim-independence'
Bundle 'Lokaltog/vim-easymotion'
Bundle 'Lokaltog/vim-powerline'
Bundle 'altercation/vim-colors-solarized'
Bundle 'gmarik/ide-popup.vim'
Bundle 'godlygeek/tabular'
Bundle 'kien/ctrlp.vim'
Bundle 'majutsushi/tagbar'
Bundle 'mattn/zencoding-vim'
Bundle 'mileszs/ack.vim'
Bundle 'msanders/snipmate.vim'
Bundle 'scrooloose/nerdcommenter'
Bundle 'scrooloose/nerdtree'
Bundle 'scrooloose/syntastic'
Bundle 'sjl/gundo.vim'
Bundle 'sukima/xmledit'
Bundle 'swaroopch/vim-markdown'
Bundle 'swaroopch/vim-markdown-preview'
Bundle 'tpope/vim-fugitive'
Bundle 'tpope/vim-speeddating'
Bundle 'tpope/vim-surround'
Bundle 'tpope/vim-unimpaired'
"Bundle 'jiangmiao/auto-pairs'
"Bundle 'nathanaelkane/vim-indent-guides'
"Bundle 'roman/golden-ratio'
"Bundle 'tpope/vim-rails'

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
set dir=~/.vim/backup,~/tmp,/tmp
set backupdir=~/.vim/backup,~/tmp,/tmp

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
set cursorline

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
if v:version >= 700

function GuiTabLabel()
    let label = ''
    let bufnrlist = tabpagebuflist(v:lnum)

    " Add '+' if one of the buffers in the tab page is modified
    for bufnr in bufnrlist
        if getbufvar(bufnr, '&modified')
            let label = '[+] '
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

endif " v:version >= 700

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

" Plain text files are Markdown
autocmd BufNewFile,BufRead *.txt setlocal ft=markdown
autocmd BufNewFile,BufRead *.text setlocal ft=markdown
autocmd FileType markdown TextMode

" Allow these file extensions to be accessed via 'gf' of only the name, for
" e.g. gf on [[AnotherPage]] should go to AnotherPage.md
set suffixesadd=.md,.txt

" Open filename in new tab, great for Gollum wiki
map <leader>t <c-w>gf

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
        vim.command('!gnome-open {}'.format(uri))

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

" http://items.sjbach.com/319/configuring-vim-right
" Marks
nnoremap ' `
nnoremap ` '

" matchit
runtime! macros/matchit.vim

" Python
let python_highlight_all=1
" For 'supertab' script
autocmd FileType python set omnifunc=pythoncomplete#Complete
let g:SuperTabDefaultCompletionType = "context"
set completeopt=menuone,longest,preview

"" Bundle-specific configurations

" Bundle 'VimClojure'
let g:vimclojure#ParenRainbow = 1

" Bundle 'Lokaltog/vim-easymotion'
let g:EasyMotion_leader_key = '<Leader>f'

" Bundle 'godlygeek/tabular'
command -range AlignFirstEqualSign :<line1>,<line2>Tabularize /^[^=]*\zs/

" Bundle 'scrooloose/nerdtree'
let NERDTreeIgnore=['\.pyc$', '\.rbc$', '\~$']
map <Leader>n :NERDTreeToggle<CR>

" Bundle 'majutsushi/tagbar'
map <Leader>l :TagbarToggle<CR>

" Bundle 'sjl/gundo.vim'
map <Leader>u :GundoToggle<CR>

" Bundle 'mileszs/ack.vim'
nmap <Leader>a <Esc>:Ack!<space>

" Sudo to write
cmap w!! w !sudo tee % >/dev/null

" Bundle 'tpope/vim-fugitive'
" http://vimcasts.org/blog/2011/05/the-fugitive-series/
autocmd BufReadPost fugitive://* set bufhidden=delete

" Bundle 'scrooloose/syntastic'
let g:syntastic_enable_signs=1

" CoffeeScript
autocmd BufNewFile,BufReadPost *.coffee setlocal shiftwidth=2 tabstop=2

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

" JSON
autocmd BufRead,BufNewFile *.json setlocal ft=json foldmethod=syntax

" Assume Bash is my shell (:help sh.vim)
let g:is_bash = 1

" Reload all windows in all tabs, useful after I do a 'git rebase -i'
command Reedit :tabdo windo edit!

" Default color scheme
" On Mac OS X, best used with iTerm2 and the solarized color scheme for iTerm2
set background=light
if isdirectory(expand("~/.vim/bundle/vim-colors-solarized", ":p"))
    colorscheme solarized
endif

" Mac
if has('gui_macvim')
    set macmeta

    let macvim_hig_shift_movement = 1
endif

" Local config
let vimrc_local = expand("~/.vimrc.local", ":p")
if filereadable(vimrc_local)
    execute 'source' vimrc_local
endif
unlet vimrc_local

" vim: filetype=vim
