#####################################
# oh-my-zsh stuff                   #
#####################################

# Path to oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set oh my zsh theme
ZSH_THEME="lambda"

# Use case-sensitive completion.
CASE_SENSITIVE="true"

# oh-my-zsh git plugin
plugins=(git)

source $ZSH/oh-my-zsh.sh

#####################################
# Own stuff                         #
#####################################

# vi-like keybindings
bindkey -v

# No autocorrect
unsetopt correct
unsetopt correctall
DISABLE_CORRECTION="true"

alias q="exit"
alias pls="sudo"
alias ls="ls --color=always"
alias rm="rm -i"
alias mv="mv -i"

alias firefox="firefox 2>/dev/null 1>/dev/null &"

alias date="date | sed -E 's/ [0-9]{2}:.*//'"
alias datetime="/bin/date"

alias gp="git push"
alias gs="git status"

# Put box-specific config in .zshrc.local
source "$HOME/.zshrc.local"

