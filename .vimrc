"do not source .vimrc in shell,must do this in vim command mode
"just:source $MYVIMRC

"********** SETTINGS **********

"no need to be compatible with vi
set nocompatible

"utf-8
set encoding=utf-8

"coding method used by the terminal
set termencoding=utf-8

"enable 24-bit true colors if your terminal supports it.
if (has("termguicolors"))
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
  set termguicolors
endif

"must come before setting color scheme
let g:gruvbox_contrast_dark='hard'
"must come before setting colorscheme,and before turning syntax on
set background=dark
"vim color scheme
colorscheme gruvbox

"syntax highlighting
syntax on

"show line number
set number

"set the number of spaces indented when the Tab key is pressed
set tabstop=4

"the tab key will be replaced with the spaces
set expandtab

"the number of spaces used for automatic indentation
set shiftwidth=4

"smart indent
set smartindent

"indent:backspace over indentation from smartindent
"eol:backspace over an end of line
"start:delete last character you input sine enter insert mode
set backspace=indent,eol,start

"show partial command
set showcmd

"displays the null characters at the end of line
set list listchars=trail:.

"highlight search results
set hlsearch

"if you use at least one uppercase letter in the mode,the search becomes case-sensitive
set incsearch ignorecase

"no ignorecase,if uppercase char present
set smartcase

"highlight the cursor line
set cursorline

"cursor shape:
"reference chart of values:
"Ps = 0 -> blinking block
"Ps = 1 -> blinking block(default)
"Ps = 2 -> steady block
"Ps = 3 -> blinking underline
"Ps = 4 -> steady underline
"Ps = 5 -> blinking bar(xterm)
"Ps = 6 -> steady bar(xterm)
"t_EI:cursor shape in normal mode
"t_SI:cursor shape in insert mode
if exists('$TMUX')
    let &t_EI = "\<Esc>Ptmux;\<Esc>\e[3 q\<Esc>\\"
    let &t_SI = "\<Esc>Ptmux;\<Esc>\e[5 q\<Esc>\\"
else
    let &t_EI = "\e[3 q"
    let &t_SI = "\e[5 q"
endif
"try to set cursor shape in vim terminal
let &t_SH = "\e[3 q"

"auto read file,if the current file is modified outside vim
set autoread

"set the title of vim window
set title

"do not use swap file
set noswapfile

"copy to system register(*,+)
set clipboard=unnamed,unnamedplus
"in multiple windows,close the buffer without closing the window
command! Bd :bp | :sp | :bn | :bd

"turn on three useful option
filetype plugin indent on

"
"********** END SETTINGS **********

"********** PLUGINS SETTINGS **********

"load all plugins in the start directory
packloadall
"load help documentation for all plugins
silent! helptags ALL

"undo tree
if has("persistent_undo")
    let target_path = expand('~/.undodir')
    "create the directory and any parent directories,if the location does not
    "exist
    if !isdirectory(target_path)
        call mkdir(target_path,"p",0700)
    endif
    let &undodir = target_path
    set undofile
endif
if !exists('g:undotree_WindowLayout')
    let g:undotree_WindowLayout = 3
endif

"highlight yanked
let g:highlightedyank_highlight_duration = 2000

"airline theme
let g:airline_theme = 'dark'
"enable the tab lists of buffers
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#formatter = 'default'
if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif
"sodo apt install fonts-powerline
":h airline-customization
let g:airline_symbols.colnr = 'cl:'
let g:airline_symbols.maxlinenr = '⚡'

"syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
"syntastic supports perl
let g:syntastic_perl_checkers = ['perl']
let g:syntastic_enable_perl_checker = 1

"ack
if executable('ag')
    let g:ackprg = 'ag --vimgrep'
endif

"get a list of counts of git diffs from the status line
"function! GitStatus()
"    let [a,m,r] = GitGutterGetHunkSummary()
"    return printf('+%d ~%d -%d',a,m,r)
"endfunction
"set statusline+=%{GitStatus()}

"fugitive
"set statusline+=%{FugitiveStatusline()}

"nerdtree
"exit vim if nerdtree is the only window remaining in the only tab
"autocmd bufenter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif
"close the tab if NERDTree is the only window remaining in it
"autocmd bufenter * if winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif
"do not replace Netrw
"let NERDTreeHijackNetrw = 0

"chang the default mapping of searching files command
"let g:Lf_ShortcutF = '<c-p>'

"********** END PLUGINS SETTINGS **********

"********** KEY MAPPING **********

"navigate around windows(panes)
nnoremap <c-h> <c-w><c-h>
nnoremap <c-j> <c-w><c-j>
nnoremap <c-k> <c-w><c-k>
nnoremap <c-l> <c-w><c-l>
"term mode
tnoremap <c-h> <c-w><c-h>
tnoremap <c-j> <c-w><c-j>
tnoremap <c-k> <c-w><c-k>
tnoremap <c-l> <c-w><c-l>

"map space bar to page down,and backspace to page up
nnoremap <space> <c-f>
nnoremap <bs> <c-b>

"map [<space> and ]<space> to add a newline after and before the cursor line
nnoremap [<space> o<esc>
nnoremap ]<space> O<esc>

"moving lines
nnoremap <down> :m .+1<cr>==
nnoremap <up> :m .-2<cr>==
inoremap <down> <esc>:m .+1<cr>==gi
inoremap <up> <esc>:m .-2<cr>==gi
xnoremap <down> :m '>+1<cr>gv==gv
xnoremap <up> :m '<-2<cr>gv==gv

"join lines with space:J,join lines without space:gJ,break line:gj
nnoremap gj ylr<cr>i<c-r>"<esc>

"auto completion
inoremap ( ()<esc>i
inoremap [ []<esc>i
inoremap { {}<esc>i<cr><cr><esc>kA<tab>
inoremap } {}<esc>i
inoremap ' ''<esc>i
inoremap " ""<esc>i
inoremap < <><esc>i

"move cursor in insert mode
inoremap <c-h> <left>
inoremap <c-j> <down>
inoremap <c-k> <up>
inoremap <c-l> <right>

inoremap <c-u> <esc>ddO
"search in current line,better than f and ;
"in normal move the cursor to some line,and type < then input character or
"characters and press enter
"nnoremap < V<esc>^/\%V

"In insert mode
"when you press enter to change the line,automatically switch to normal mode and enter insert mode again
inoremap <cr> <c-o>o

"open terminal at bottom right
nnoremap <F12> :vert bo term ++kill=term<cr>

"map alt:in insert mode,if you want to map alt+key,then first press
"ctrl+v,second press alt+key,then you got it.do not use <>

"map the <leader> key to ',',set it up at the beginning of key mapping
let mapleader = "s"
"time out on mapping after three seconds
"time out on key codes after ten milliseconds
set timeout timeoutlen=2000 ttimeoutlen=10

"undo tree
nnoremap <leader>u :UndotreeToggle<cr>

"airline switch between tablines
let g:airline#extensions#tabline#buffer_idx_mode = 1
nmap <leader>1 <Plug>AirlineSelectTab1
nmap <leader>2 <Plug>AirlineSelectTab2
nmap <leader>3 <Plug>AirlineSelectTab3
nmap <leader>4 <Plug>AirlineSelectTab4
nmap <leader>5 <Plug>AirlineSelectTab5
nmap <leader>6 <Plug>AirlineSelectTab6
nmap <leader>7 <Plug>AirlineSelectTab7
nmap <leader>8 <Plug>AirlineSelectTab8
nmap <leader>9 <Plug>AirlineSelectTab9
nmap <leader>0 <Plug>AirlineSelectTab0
nmap <leader>- <Plug>AirlineSelectPrevTab
nmap <leader>= <Plug>AirlineSelectNextTab

"easymotion
"all motions will be triggered with just one <leader>
nmap <leader> <Plug>(easymotion-prefix)
"default:g:EasyMotion_do_mapping is on,and defines the following mappings in normal,visual and operator-pending mode
"<leader>f,F,t,T,w,W,b,B,e,E,ge,gE,j,k,n,N,s(find(search) {char} forward and backward)
let g:EasyMotion_do_mapping = 0
"targets:one character and enter,or two characters without enter
nmap <leader>s <Plug>(easymotion-s2)
"targets:no,just jump in current line,same as my shortcut:<
nmap <leader>f <Plug>(easymotion-bd-wl)
nmap <leader>j <Plug>(easymotion-bd-jk)
nmap <leader>. <Plug>(easymotion-repeat)

nnoremap <leader>w :w<cr>
nnoremap <leader>q :q<cr>
nnoremap <leader>r :source $MYVIMRC<cr>

nnoremap <leader>h ^
nnoremap <leader>l $

"move the cursor to last edit position but do not enter insert mode
"if want to enter insert mode,use gi
nnoremap <leader>i `.

"comment
nnoremap <leader>] 0i"<esc>
nnoremap <leader>[ 0i#<esc>

"open nerdtree
"nnoremap <c-i> :NERDTreeToggle<cr>

"disable mouse wheel
set mouse=a
nmap <ScrollWheelUp> <nop>
nmap <S-ScrollWheelUp> <nop>
nmap <C-ScrollWheelUp> <nop>
nmap <ScrollWheelDown> <nop>
nmap <S-ScrollWheelDown> <nop>
nmap <C-ScrollWheelDown> <nop>
imap <ScrollWheelUp> <nop>
imap <S-ScrollWheelUp> <nop>
imap <C-ScrollWheelUp> <nop>
imap <ScrollWheelDown> <nop>
imap <S-ScrollWheelDown> <nop>
imap <C-ScrollWheelDown> <nop>
vmap <ScrollWheelUp> <nop>
vmap <S-ScrollWheelUp> <nop>
vmap <C-ScrollWheelUp> <nop>
vmap <ScrollWheelDown> <nop>
vmap <S-ScrollWheelDown> <nop>
vmap <C-ScrollWheelDown> <nop>

"********** END KEY MAPPING **********

"********** AUTO HEADER **********

autocmd BufNewFile *.sh,*.py,*.pl,*.rb,*.lua exec ":call AutoHeader()"
func AutoHeader()
    if &filetype == 'sh'
        call setline(1,"#!/bin/bash")
    elseif &filetype == 'python'
        call setline(1,"#!/usr/bin/python3")
        call setline(5,"if __name__ == '__main__':")
        call setline(6,"main()")
    elseif &filetype == 'perl'
        call setline(1,"#!/usr/bin/perl")
        call setline(2,"use v5.30;")
        call setline(3,"use warnings;")
        call setline(4,"use autodie;")
        call setline(5,"use utf8;")
        call setline(6,"binmode STDIN,':encoding(UTF-8)';")
        call setline(7,"binmode STDOUT,':encoding(UTF-8)';")
        call setline(8,"binmode STDERR,':encoding(UTF-8)';")
        call setline(9,"use feature qw(signatures);")
        call setline(10,"no warnings qw(experimental::signatures);")
    elseif &filetype == 'ruby'
        call setline(1,"#!/usr/bin/ruby")
    elseif &filetype == 'lua'
        call setline(1,"#!/usr/bin/lua")
    endif
endfunc

"the cursor is on the last line,when you open a new script
autocmd BufNewFile * normal G

"********** AUTO HEADER **********

"********** PYTHON **********

"run python code in vim
"map <F5> :w<cr>:!clear;python3 %<cr>

"********** END PYTHON **********
