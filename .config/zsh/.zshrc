# Enable colors and change prompt:
autoload -U colors && colors
PS1="%B%{$fg[red]%}[%{$fg[yellow]%}%n%{$fg[green]%}@%{$fg[blue]%}%M %{$fg[magenta]%}%~%{$fg[red]%}]%{$reset_color%}$%b "
setopt autocd
stty stop undef	# Disable ctrl-s to freeze terminal.
setopt interactive_comments

# Lines configured by zsh-newuser-install
HISTFILE="${XDG_STATE_HOME:-$HOME/.cache}"/zsh/hsitory
histsize=1000
SAVEHIST=1000

# Basic autocomplete
autoload -Uz compinit
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
zmodload zsh/complist
compinit -d $XDG_CACHE_HOME/zsh/zcompdump-$ZSH_VERSION
_comp_options+=(globdots)	# Include hidden files.

# Vim keys
bindkey -v
export KEYTIMEOUT=1
# Use vim keys in tab complete menu:
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -M menuselect 'left' vi-backward-char
bindkey -M menuselect 'down' vi-down-line-or-history
bindkey -M menuselect 'up' vi-up-line-or-history
bindkey -M menuselect 'right' vi-forward-char
bindkey -v '^?' backward-delete-char
bindkey -v '^W' backward-delete-word


# alias vimm='vim -u ${XDG_CONFIG_HOME:-$HOME/.config}/vim/vimrc'
alias config='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
alias vim=nvim v=nvim
alias wget=wget --hist-file="$XDG_DATA_HOME/wget-hsts"
