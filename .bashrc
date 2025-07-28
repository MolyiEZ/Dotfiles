#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias ll='ls -lh'
alias la='ls -lha'
alias gs='git status'
alias .='cd'
alias ..='cd ..'
alias ...='cd ../..'
alias c='clear'
PS1='[\u@\h \W]\$ '

# Created by `pipx` on 2025-07-08 02:46:22
export PATH="$PATH:/home/molyi/.local/bin"
export PATH="$HOME/.local/bin:$PATH"

# Rojo
export PATH="$HOME/.cargo/bin:$PATH"
