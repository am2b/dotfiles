# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="robbyrussell"

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git autojump command-not-found colored-man-pages zsh-autosuggestions zsh-syntax-highlighting)

source $ZSH/oh-my-zsh.sh

#set fd as the default source for fzf
#usage:vim <c-t> will open fzf which is the result of fd(include soft links,hidden files but not .git)
export FZF_DEFAULT_COMMAND='fd --type f --strip-cwd-prefix --follow --hidden --exclude .git'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_DEFAULT_OPTS='-m'

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.

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
