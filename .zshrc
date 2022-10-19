#path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="robbyrussell"

#standard plugins can be found in $ZSH/plugins/
#custom plugins may be added to $ZSH_CUSTOM/plugins/
plugins=(git autojump command-not-found colored-man-pages zsh-autosuggestions zsh-syntax-highlighting)

source $ZSH/oh-my-zsh.sh

#----------plugins----------
#junegunn/fzf.vim
#set fd as the default source for fzf
#usage:
#use <c-p> and <c-n> to move up and down in the popup window,and <esc> to exit
#on multi-select mode,use <tab> to mark multiple items,<s-tab> to unmark
#vim <c-t> will open fzf which is the result of fd(include soft links,hidden files but not .git)
#vim **<tab> cd **<tab>,fuzzy completion for files and directories can be triggered if the word before the cursor ends with the trigger sequence,which is by default **.
#vim $(fzf)
#search syntax:
#^keywords items that start with keywords
#keywords$ items that end with keywords
#'keywords exact match keywords
export FZF_DEFAULT_COMMAND='fd --type f --strip-cwd-prefix --follow --hidden --exclude .git'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_DEFAULT_OPTS='-m'

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

#----------custom----------

alias py="python3"

alias sozs="source ~/.zshrc"

alias ls="ls --color=auto -F"
alias ll="ls -alh"
alias lr="ls -alhR"
alias lt="ls -alht"

alias fli="file -i"

alias grep="grep -E"

alias locate="locate --regex"
alias fda="fd -H"
alias fdf="fd -t f"
alias fdd="fd -t d"
alias fdx="fd -t x"

alias tm="tmux new -A -s"
alias tmls="tmux list-sessions"
alias tmlw="tmux list-windows -a"
alias tmlp="tmux list-panes -a"
alias tmss="tmux switch -t"
alias tmks="tmux kill-session -t"

alias sdh="shutdown -h now"
alias sdr="shutdown -r now"

alias pdc="perldoc"
alias cpm="sudo cpanm"

alias cm="cmake"
alias cmb="cmake --build"

alias ct="cheat"

export PATH=~/bin:"$PATH"
export CHEAT_CONFIG_PATH="~/dots/.cheat/conf.yml"
export VISUAL=vim
export EDITOR="$VISUAL"

zmodload zsh/files
