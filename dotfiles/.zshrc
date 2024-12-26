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
# prompt
if [ -z $SSH_CONNECTION ];
then
    lambda_default_color=white
else
    lambda_default_color=magenta
fi
prompt_lambda='%(?.%F{'$lambda_default_color'}.%F{red})%Bλ%b%f'
PROMPT=$prompt_lambda' %2~/ $(git_prompt_info)%{$reset_color%}'

# vi-like keybindings
bindkey -v

# No autocorrect
unsetopt correct
unsetopt correctall
DISABLE_CORRECTION="true"

alias q="exit"
alias ls="ls --color=always"
alias ll="ls -l"
alias rm="rm -i"
alias rmdir="rm -ri"
alias mv="mv -i"
alias mkdir="mkdir -p"
alias grep="grep --exclude-dir='.*' --color=always"

alias jupyter="jupyter notebook --NotebookApp.token='' --NotebookApp.password='' 2>/dev/null 1>/dev/null &"

alias date="date | sed -E 's/ [0-9]{2}:.*//'"
alias datetime="/bin/date"

alias gp="git push"
alias gs="git status"

# Put box-specific config in .zshrc.local
source "$HOME/.zshrc.local"
