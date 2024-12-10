#!/bin/zsh

# fastfetch
# Enable colors and change prompt:
autoload -U colors && colors
# PS1 Prompt
source "${XDG_CONFIG_HOME:-$HOME/.config}/zsh/custom-prompt"

setopt autocd
stty stop undef	# Disable ctrl-s to freeze terminal.
setopt interactive_comments

# Lines configured by zsh-newuser-install
histsize=1000
SAVEHIST=1000

[ -f "${XDG_CONFIG_HOME:-$HOME/.config}/shell/aliasrc" ] && source "${XDG_CONFIG_HOME:-$HOME/.config}/shell/aliasrc"

# Basic autocomplete
autoload -Uz compinit
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
# more info abt zsh color completion
# https://stackoverflow.com/questions/23152157/how-does-the-zsh-list-colors-syntax-work/23568183#23568183
# eval $(dircolors)           # so $LS_COLORS is exported
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' cache-path $XDG_CACHE_HOME/zsh/zcompcache
zmodload zsh/complist
compinit -d $XDG_CACHE_HOME/zsh/zcompdump-$ZSH_VERSION
_comp_options+=(globdots)	# Include hidden files.

autoload -U select-word-style
select-word-style bash
WORDCHARS='*?_-.[]~=&;!#$%^(){}<>'

# Vim keys
bindkey -v
export KEYTIMEOUT=1
# Use vim keys in tab complete menu:
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -M menuselect 'left' vi-backward-char
bindkey -M menuselect 'down' vi-down-line-or-history
bindkey -M menuselect 'up' vi-up-line-or-history
bindkey -M menuselect 'right' vi-forward-char
bindkey -v '^?' backward-delete-char


# alias vimm='vim -u ${XDG_CONFIG_HOME:-$HOME/.config}/vim/vimrc'
alias dotf='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
# cat "${XDG_CONFIG_HOME:-$HOME/.config}/cool_ascii_arts/cows_fucking.txt"
source "${XDG_CONFIG_HOME:-$HOME/.config}/user-dirs.dirs"

# plugins
source /usr/share/zsh/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh  # should be last
