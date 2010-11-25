" My Vimrc file
" Maintainer: swaroop@swaroopch.com

"" Vim, not Vi.
" This must be first, because it changes other options as a side effect.
set nocompatible

"" Vim Addon Manager

function ActivateAddons()
  set runtimepath+=~/code/dotvim/vim-addon-manager
  try
    call scriptmanager#Activate(['snipMate', 'ack', 'Command-T', 'Conque_Shell', 'Align294', 'xmledit', 'The_NERD_tree', 'The_NERD_Commenter', 'Jinja', 'Markdown_syntax', 'python790', 'rails', 'VOoM_-_Vim_Outliner_of_Markers'])
  catch /.*/
    echoerr v:exception
  endtry
endfunction
call ActivateAddons()

"" General Settings

" Enable syntax highlighting.
syntax on

" Line endings should be Unix-style unless the file is from someone else.
set fileformat=unix
au BufNewFile * set fileformat=unix

" Automatically indent when adding a curly bracket, etc.
filetype plugin indent on
set autoindent
set smartindent

" Tabs converted to 4 spaces
set shiftwidth=4
set tabstop=4
set expandtab
set smarttab

" Put swap files in a specific location, to avoid Dropbox from spinning incessantly.
set directory=~/.vim/swapfiles/

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
command TextMode set nolist wrap linebreak scrolloff=999

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

" Use UTF-8.
set encoding=utf-8

" Status line
set laststatus=2
set statusline=
set statusline+=%-3.3n\                         " buffer number
set statusline+=%f\                             " filename
set statusline+=%h%m%r%w                        " status flags
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

" Ignore case when searching
set ignorecase

" Show autocomplete menus
set wildmenu

" Show editing mode
set showmode

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
    normal ggVGd"+p1Gdd
    call Say("Pasted.")
endfunction
command B call PasteFromClipboard()

" Plain text files are Markdown
autocmd BufNewFile,BufRead *.txt set ft=mkd

" ReStructuredText mode
function! ReStructuredTextMode()
    " Make bullet points follow to next line
    " http://stackoverflow.com/questions/1047400/
    " setlocal comments+=n:-,n:#.

    " Don't visually break words when line wrapping
    set nolist
    set linebreak
    set scrolloff=999

    " Override the default indentation which I don't like
    " $VIMRUNTIME/indent/rst.vim
    setlocal indentexpr=
    setlocal indentkeys=
    setlocal smartindent
endfunction

autocmd FileType rst call ReStructuredTextMode()

if has('python') " Assumes Python >= 2.6

    " Make it easy to add heading markers in ReStructuredText
    function! Heading(char)
python <<EOF
import vim

marker_line = vim.eval('a:char') * len(vim.current.line)
current_line_number = vim.current.window.cursor[0] # (row, col)
vim.current.buffer.append(marker_line, current_line_number)
vim.command('normal j')
vim.command('normal o')
EOF
    endfunction

    command H1 call Heading('=')
    command H2 call Heading('-')
    command H3 call Heading('~')
    command H4 call Heading('^')

    " Quick way to open a filename under the cursor in a new tab
    " (or URL in a browser)
    function! Open()
python <<EOF
import re
import platform
import vim

def launch(uri):
    if platform.system() == 'Darwin':
        vim.command('!open {0}'.format(uri))
    elif platform.system() == 'Linux':
        vim.command('!gnome-open {0}'.format(uri))

def is_word(text):
    return re.match(r'^[\w./?%:#&=-]+$', text) is not None

filename_start = filename_end = vim.current.window.cursor[1] # (row, col)

while filename_start >= 0 and is_word(vim.current.line[filename_start:filename_start+1]):
    filename_start -= 1
filename_start += 1

while filename_end <= len(vim.current.line) and is_word(vim.current.line[filename_end:filename_end+1]):
    filename_end += 1

filename = vim.current.line[filename_start:filename_end]

if filename.endswith('.rst') or filename.endswith('.txt'):
    vim.command('tabedit {0}'.format(filename))

elif filename.lower().startswith('http') or filename.lower().startswith('www.'):
    if filename.lower().startswith('www.'):
        filename = 'http://{0}'.format(filename)
    filename = filename.replace('#', r'\#').replace('%', r'\%')
    launch(filename)

else:
    launch(filename)
EOF

    endfunction

    command O call Open()
    map <Leader>o :call Open()<CR>

endif " python

" Remove the Windows ^M (copied from http://amix.dk/vim/vimrc.html)
map <Leader>m mmHmt:%s/<C-V><cr>//ge<cr>'tzt'm

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
runtime macros/matchit.vim

" Python
let python_highlight_all=1

" Conque Shell
" http://www.vim.org/scripts/script.php?script_id=2771
map <Leader>e :<C-u>call conque_term#send_selected(visualmode())<CR><CR>
command Shell :set nolist | ConqueTermSplit bash
command PythonShell :set nolist | ConqueTermSplit python

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
autocmd FileType php   call TagExpander()
autocmd FileType htmljinja call TagExpander()

" Local config
if filereadable(".vimrc.local")
    source .vimrc.local
endif

" vim: filetype=vim
