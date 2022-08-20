"********** Vundle **********

"vundle requires filetype off
filetype off

"set the runtime path to include vundle
set rtp+=~/.vim/bundle/Vundle.vim

call vundle#begin()

"let vundle manage vundle,required
Plugin 'VundleVim/Vundle.vim'

"easymotion/vim-easymotion
Plugin 'easymotion/vim-easymotion'

"file system explore
Plugin 'preservim/nerdtree'

"comment stuff out
Plugin 'preservim/nerdcommenter'

"an efficient fuzzy files finder
"Plugin 'Yggdroot/LeaderF'

"enhances Netrw
Plugin 'tpope/vim-vinegar'

"color scheme
Plugin 'morhetz/gruvbox'

"automatically clear search highlights after you move your cursor
Plugin 'haya14busa/is.vim'

"undo tree
Plugin 'mbbill/undotree'

"run your favorite search tool from vim
Plugin 'mileszs/ack.vim'

"make the yanked region apparent
Plugin 'machakann/vim-highlightedyank'

"repeat
Plugin 'tpope/vim-repeat'

"a number of useful motions
"Plugin 'tpope/vim-unimpaired'

"all about surroundings
"Plugin 'tpope/vim-surround'

"a status line
Plugin 'vim-airline/vim-airline'

"airline themes
Plugin 'vim-airline/vim-airline-themes'

"shows a git diff in the sign column
Plugin 'airblade/vim-gitgutter'

"fugitive
Plugin 'tpope/vim-fugitive'

"super tab
Plugin 'ervandew/supertab'

"python autocompletion
Plugin 'davidhalter/jedi-vim'

"syntax checking
Plugin 'vim-syntastic/syntastic'

"tagbar
Plugin 'preservim/tagbar'

"ruby
Plugin 'vim-ruby/vim-ruby'

"vim tmux navigator
Plugin 'christoomey/vim-tmux-navigator'

"chinese input method
Plugin 'rlue/vim-barbaric'

call vundle#end()

"turn on three useful option
filetype plugin indent on

"close vim or a tab automatically when nerdtree is the last window
"exit vim if nerdtree is the only window remaining in the only tab
autocmd bufenter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif
"close the tab if NERDTree is the only window remaining in it
autocmd bufenter * if winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif
"do not replace Netrw
let NERDTreeHijackNetrw = 0

"align delimiters left instead of following code indentation
let g:NERDDefaultAlign = 'left'
"empty lines
let g:NERDCommentEmptyLines = 1
"white spaces
let g:NERDTrimTrailingWhitespace = 1
"check
let g:NERDToggleCheckAllLines = 1

"chang the default mapping of searching files command
let g:Lf_ShortcutF = '<c-p>'

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

"ack
if executable('ag')
    let g:ackprg = 'ag --vimgrep'
endif

"highlight yank
let g:highlightedyank_highlight_duration = 2000

"get a list of counts of git diffs from the status line
function! GitStatus()
    let [a,m,r] = GitGutterGetHunkSummary()
    return printf('+%d ~%d -%d',a,m,r)
endfunction
set statusline+=%{GitStatus()}

"airline theme
let g:airline_theme = 'dark'

"fugitive
set statusline+=%{FugitiveStatusline()}

"syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

"********** END VUNDLE **********

"********** SETTINGS **********

"use vim,not vi
set nocompatible

"utf-8
set encoding=utf-8

"coding method used by the terminal
set termencoding=utf-8

"Enable 24-bit true colors if your terminal supports it.
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

"show the relative line number
"set relativenumber

"set the number of spaces indented when the Tab key is pressed
set tabstop=4

"the Tab key will be replaced with the spaces
set expandtab

"the number of spaces used for automatic indentation
set shiftwidth=4

"smart indent
set smartindent

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
"cursor shape in normal mode
let &t_EI = "\e[3 q"
"cursor shape in insert mode
let &t_SI = "\e[5 q"

"auto read file,if the current file is modified outside vim
set autoread

"set the title of vim window
set title

"do not use swap file
set noswapfile

"in multiple windows,close the buffer without closing the window
command! Bd :bp | :sp | :bn | :bd

"copy to system register(*,+)
set clipboard=unnamed,unnamedplus

"********** END SETTINGS **********

"********** KEY MAPPING **********

"map the <leader> key to ',',set it up at the beginning of key mapping
let mapleader = ","
noremap \ ,
"time out on mapping after three seconds
"time out on key codes after ten milliseconds
set timeout timeoutlen=2000 ttimeoutlen=10

"navigate around windows(panes)
nnoremap <c-h> <c-w><c-h>
nnoremap <c-j> <c-w><c-j>
nnoremap <c-k> <c-w><c-k>
nnoremap <c-l> <c-w><c-l>

"map space bar to page down,and backspace to page up
nnoremap <space> <c-f>
nnoremap <bs> <c-b>

"map [<space> and ]<space> to add a newline after and before the cursor line
nnoremap [<space> o<esc>
nnoremap ]<space> O<esc>

"open nerdtree
nnoremap <c-i> :NERDTreeToggle<cr>

"moving lines
nnoremap <down> :m .+1<cr>==
nnoremap <up> :m .-2<cr>==
inoremap <down> <esc>:m .+1<cr>==gi
inoremap <up> <esc>:m .-2<cr>==gi
xnoremap <down> :m '>+1<cr>gv==gv
xnoremap <up> :m '<-2<cr>gv==gv

"In insert mode,when you press enter to change the line,automatically switch to normal mode and enter insert mode again
inoremap <cr> <c-o>o

"Plug:easymotion key mapping:
"all motions will be triggered with just one <leader>
nmap <leader> <Plug>(easymotion-prefix)
"default:g:EasyMotion_do_mapping is on,and defines the following mappings in normal,visual and operator-pending mode
"<leader>f,F,t,T,w,W,b,B,e,E,ge,gE,j,k,n,N,s(find(search) {char} forward and backward)
let g:EasyMotion_do_mapping = 0

nmap <leader>s <Plug>(easymotion-bd-fl)
nmap <leader>f <Plug>(easymotion-bd-f)
nmap <leader>F <Plug>(easymotion-bd-f2)
nmap <leader>t <Plug>(easymotion-bd-t)
nmap <leader>w <Plug>(easymotion-bd-w)
nmap <leader>e <Plug>(easymotion-bd-e)
nmap <leader>j <Plug>(easymotion-j)
nmap <leader>k <Plug>(easymotion-k)
nmap <leader>. <Plug>(easymotion-repeat)

"double <leader>
"nnoremap <leader><leader>w :w<cr>
"nnoremap <leader><leader>q :q<cr>
"nnoremap <leader><leader>wq :wq<cr>

"command mode
"source ~/.vimrc
"nnoremap <leader><leader>so :so $MYVIMRC<cr>
"show buffers
"nnoremap <leader><leader>ls :ls<cr>
"switch between buffers
"nnoremap <leader><leader>bn :!w\| :bn<cr>
"nnoremap <leader><leader>bp :bp<cr>
":bd,sp,vs,on,wqa,tabnew,tabclose,term

"vim-tmux-navigator
let g:tmux_navigator_no_mappings = 1
nnoremap <silent> <c-h> :TmuxNavigateLeft<cr>
nnoremap <silent> <c-l> :TmuxNavigateRight<cr>
nnoremap <silent> <c-k> :TmuxNavigateUp<cr>
nnoremap <silent> <c-j> :TmuxNavigateDown<cr>
nnoremap <silent> <leader> :TmuxNavigatePrevious<cr>
"write the current buffer before navigating from vim to tmux pane
let g:tmux_navigator_save_on_switch = 1

"undo tree
nnoremap <leader>u :UndotreeToggle<cr>

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
        call setline(3,"use utf8;")
        call setline(4,"use warnings;")
        call setline(5,"use autodie;")
    elseif &filetype == 'ruby'
        call setline(1,"#!/usr/bin/ruby")
    elseif &filetype == 'lua'
        call setline(1,"#!/usr/bin/lua")
    endif
endfunc
autocmd BufNewFile * normal G

"********** AUTO HEADER **********

"********** PYTHON **********

"run python code in vim
"map <F5> :w<cr>:!clear;python3 %<cr>

"********** END PYTHON **********
