[[ $- != *i* ]] && return

# Aliases
alias ls='eza --icons'
alias grep='grep --color=auto'
alias ll='ls -lh'
alias la='ls -lha'
alias gs='git status'
alias .='cd'
alias ..='cd ..'
alias ...='cd ../..'
alias c='clear'
alias y='yazi'

bindkey -v

unsetopt PROMPT_SP
setopt PROMPT_CR
export PROMPT_EOL_MARK=""

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
source /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme

# Automatically start tmux if not already inside
if [[ -z "$TMUX" && -n "$PS1" ]]; then
  exec tmux
fi
