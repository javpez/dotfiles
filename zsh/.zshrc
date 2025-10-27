
# The following lines were added by compinstall

zstyle ':completion:*' completer _complete _ignored
zstyle :compinstall filename '$HOME/.zshrc'

autoload -Uz compinit
compinit

# End of lines added by compinstall

# Lines configured by zsh-newuser-install

HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt appendhistory
setopt extendedglob

bindkey -v

# End of lines configured by zsh-newuser-install

# Aliases
alias ls='lsd -1'
alias cat='bat'

# Better history search
autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search

# Use Up/Down arrows in insert mode to navigate the history
bindkey "^[[A" up-line-or-beginning-search
bindkey "^[[B" down-line-or-beginning-search

# Use k/j keys in normal mode to navigate the history
bindkey -a "k" up-line-or-beginning-search
bindkey -a "j" down-line-or-beginning-search


# Prompt configuration
eval "$(oh-my-posh init zsh --config $HOME/.config/oh-my-posh/config.json)"
