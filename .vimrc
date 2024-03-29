"do not source .vimrc in shell,must do this in vim command mode just:source $MYVIMRC
"sometimes,you reload the .vimrc and think everything is ok,and then found that the result is not what you expected.at this time,it is best to exit vim and reopen vim.

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

"set the number of spaces indented when the tab key is pressed
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

"incsearch:to preview the first match based on the text that has been entered.every time we enter a new character,vim will update the preview immediately.
"ignorecase:if you use at least one uppercase letter in the mode,the search becomes case-sensitive
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
"open vim and then open term,cursor shape now is correct in term,but continue to open another vim in term,in normal mode,the cursor shape is still correct,then enter insert mode,now the cursor shape is still as same as in normal mode
let &t_SH = "\e[3 q"

"auto read file,if the current file is modified outside vim
set autoread

"set the title of vim window
set title

"do not use swap file
set noswapfile

"allow buffer to be hidden
set hidden

"default is 20
set history=200

"in command mode,when the 'wildmenu' option is enabled,vim provides a complete navigation list.we can iterate through the list items in the forward direction by <tab>, <c-n>,or <right>,or backward with <s-tab >, <c-p>,or <left>.
set wildmenu
set wildmode=full

"copy to system register(*,+)
set clipboard=unnamed,unnamedplus

"auto save when switch buffer
set autowrite

"turn on three useful option
filetype plugin indent on

"make files available with <tab> completion
":set path+=$PWD/**
"maybe need:let $PWD=getcwd()

"********** END SETTINGS **********

"********** PLUGINS SETTINGS **********

"vim startup parameters:
"-u NONE -N,do not load any plugins at startup

"load all plugins in the start directory
packloadall
"load help documentation for all plugins
silent! helptags ALL

"first of all git clone junegunn/fzf to ~/,then:git clone junegunn/fzf.vim to .vim/pack/plugins/start,and set rtp(runtime path)
set rtp+=~/.fzf
"usage:
"Finding files:
":FZF or :Files or :GFiles to open the popup window(if you like fullscreen popup window,add ! after commands),then
"<c-t> to open in a new tab
"<c-v> to open in a vertical window(pane)
"Finding in files:
":Ag
":Buffers
":Marks
":Lines find keyword in all the loaded buffers
":BLines find keyword in the current buffer
":Windows

"undo tree
if has("persistent_undo")
    let target_path = expand('~/.undodir')
    "create the directory and any parent directories,if the location does not exist
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
"perl
let g:syntastic_perl_checkers = ['perl']
let g:syntastic_enable_perl_checker = 1
"python
let g:syntastic_python_checkers = ['pylint']

"airblade/vim-gitgutter.git:Get a list of counts of git diffs from the status line.
"You can jump between hunks with [c and ]c.
"a hunk text object is provided which works in visual and operator-pending modes.
"ic operates on all lines in the current hunk.
"ac operates on all lines in the current hunk and any trailing empty lines.
function! GitStatus()
  let [a,m,r] = GitGutterGetHunkSummary()
  return printf('+%d ~%d -%d', a, m, r)
endfunction
set statusline+=%{GitStatus()}

"kshenoy/vim-signature,ref :h Signature

"ack
if executable('ag')
    let g:ackprg = 'ag --vimgrep'
endif

"zaikunzhang/vim-commentary
"without space after comment
autocmd FileType python setlocal commentstring=#%s

"Yggdroot/indentLine
let g:indentLine_char_list = ['|', '¦', '┆', '┊']

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
"map Alt to Meta,and Caps Lock to Ctrl
"linux mint:Keyboard->Layouts->Options->Alt/Win key behavior->Alt and Meta are on Alt
"linux mint:Keyboard->Layouts->Options->Caps Lock behavior->Caps Lock is also a Ctrl

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

"map p to add a space before the cursor in normal mode
nnoremap p i<space><esc>

"moving lines
nnoremap <down> :m .+1<cr>==
nnoremap <up> :m .-2<cr>==
"inoremap <down> <esc>:m .+1<cr>==gi
"inoremap <up> <esc>:m .-2<cr>==gi
"xnoremap <down> :m '>+1<cr>gv==gv
"xnoremap <up> :m '<-2<cr>gv==gv

"join lines with space:J
"join lines without space:gJ
"break line:gj
nnoremap gj ylr<cr>i<c-r>"<esc>

"display current to the top of the screen
nnoremap H z<cr>
"display current to the bottom of the screen
nnoremap L zb<cr>

"next buffer,in normale mode
"nnoremap <tab> :bn<cr>

"Alt is weird
nnoremap <M-;> <esc>

"auto completion
"inoremap ( ()<esc>i
inoremap [ []<esc>i
inoremap { {}<esc>i<cr><cr><esc>kA<tab>
inoremap } {}<esc>i
"inoremap ' ''<esc>i
"inoremap " ""<esc>i
"inoremap < <><esc>i
"inoremap \| \|\|<esc>i

"in insert mode,pressing <c-g> u generates a breakpoint
inoremap <c-u> <c-g>u<c-u>
inoremap <c-w> <c-g>u<c-w>

"In insert mode
"when you press enter to change the line,automatically switch to normal mode and enter insert mode again
"<up> and <down>:control the undo unit,can be undo line by line
inoremap <cr> <esc>o<up><down>

"map <c-o> in insert mode
inoremap FF <c-o>

"map symbols
inoremap Fhg !
inoremap Fha @
inoremap Fhj #
inoremap Fhm $
inoremap Fhb %
inoremap Fht ^
inoremap Fhq &
inoremap Fhs *
inoremap Fhh -
inoremap Fhx _
inoremap Fhd =
inoremap Fhp +
inoremap Fhk (
inoremap Fho )
inoremap Fhe ):
inoremap Fhr ->
"map numbers
inoremap Fgz 0
inoremap Fgy 1
inoremap Fge 2
inoremap Fgs 3
inoremap Fgf 4
inoremap Fgw 5
inoremap Fgl 6
inoremap Fgq 7
inoremap Fgb 8
inoremap Fgj 9
"map ==,!=,->,=>,<=,>=,=~
inoremap Fte ==
inoremap Ftb !=
inoremap Fts ->
inoremap Ftp =>
inoremap Ftx <=
inoremap Ftd >=
inoremap Ftr =~

"open terminal at bottom right
nnoremap <silent> <F12> :vert bo term ++kill=term<cr>

"in command mode,to filter when going back to history commands
cnoremap <c-p> <up>
cnoremap <c-n> <down>

"when you type%% at the command line prompt,it is automatically expanded to the path of the directory where the active buffer is located, just as you typed%:h <tab>.this mapping term not only works well with the :edit command,but also makes other ex commands,such as :write,:saveas and :read,etc.
cnoremap <expr> %% getcmdtype( ) == ':' ? expand('%:h').'/' : '%%'

"redefine the * command in visual mode so that it can find the currently selected text instead of the word under the cursor.
xnoremap * :<c-u>call <SID>VSetSearch()<cr>/<c-r>=@/<cr><cr>
xnoremap # :<c-u>call <SID>VSetSearch()<cr>?<c-r>=@/<cr><cr>
function! s:VSetSearch()
    let temp = @s
    norm! gv"sy
    let @/ = '\V' . substitute(escape(@s, '/\'), '\n', '\\n', 'g')
    let @s = temp
endfunction

"********** LEADER **********
let mapleader = "s"
"time out on mapping after two seconds
"time out on key codes after ten milliseconds
set timeout timeoutlen=2000 ttimeoutlen=10

nnoremap <leader>h ^
nnoremap <leader>l $

nnoremap <leader>p p

"move the cursor to last edit position but do not enter insert mode if want to enter insert mode,use gi
nnoremap <leader>i `.

"more convenient to end command mode
nnoremap <leader>; :

"a buffer is the in-memory text of a file
"a window is a viewport on a buffer
"a tab page is a collection of windows

":clo
"just close the window(pane),do not delete buffer.
"can not close the last window(pane),if that you should use :q

":on
"all other windows(panes) are closed,but the current window(pane) is only one on the screen.
"when the 'hidden' option is set,all buffers in closed windows(panes) become hidden

":q close window(pane),do not delete buffer.quit vim if all the buffers are saved

":tabc close current tab and will close all the windows(panes) inside this tab.
"when you close a tab in vim,you are not closing a file.you just closed the window layout.
"the data of the files are still stored in buffers in memory.
"if this tab is the last tab,then you should use :q to close the tab

":bd delete buffer and close any windows(panes) for this buffer
"close tab too if the tab has only one window(pane) for the buffer.

nnoremap <leader>d :bd<cr>
nnoremap <leader>c :tabc<cr>
nnoremap <leader>q :q<cr>

":Bd in multiple windows(panes),close the buffer without closing the (splited)window(pane)
command! Bd :bp | :sp | :bn | :bd

"$MYVIMRC:~/.vimrc,%:~/dots/.vimrc,so can not :so %
nnoremap <leader>r :source $MYVIMRC<cr>

"easymotion
"default:g:EasyMotion_do_mapping is on,and defines the following mappings in normal,visual and operator-pending mode
"<leader>f,F,t,T,w,W,b,B,e,E,ge,gE,j,k,n,N,s(find(search) {char} forward and backward)
let g:EasyMotion_do_mapping = 0
let g:EasyMotion_smartcase = 1
"all motions will be triggered with just one <leader>
nmap <leader> <Plug>(easymotion-prefix)
"targets:one character and enter,or two characters without enter
nmap <leader>s <Plug>(easymotion-s2)
"targets:no,just jump in current line
nmap <leader>w <Plug>(easymotion-bd-wl)
nmap <leader>e <Plug>(easymotion-bd-el)
nmap <leader>j <Plug>(easymotion-bd-jk)

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

"airblade/vim-gitgutter
"You can preview,stage,and undo hunks with ghp,ghs,and ghu respectively.You cannot unstage a staged hunk.
nmap ghs <Plug>(GitGutterStageHunk)
nmap ghu <Plug>(GitGutterUndoHunk)
nmap ghp <Plug>(GitGutterPreviewHunk)

"jeetsukumaran/vim-buffergator
"EasyMotion_do_mapping = 0 does not work,so <leader>b is still \b
"use gb and gB to flip through the most-recently used buffer stack without opening the buffer listing drawer
"when the drawer is opened:
"<cr> to edit the selected buffer in the previous window
"<c-v> to edit the selected buffer in a new vertical split
"<c-s> to edit the selected buffer in a new horizontal split
"<c-t> to edit the selected buffer in a new tab page
nnoremap <leader>b :BuffergatorOpen<cr>
nnoremap <leader>B :BuffergatorToggle<cr>

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
        call setline(2,"if __name__ == '__main__':")
        call setline(3,"    main()")
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
