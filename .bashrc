set editing-mode vi
set -o vi
bind -x '"\C-l": clear;'

bind 'TAB:menu-complete'

if [ $(id -u) == 0 ]; then
    PS1="\[\e[1;34m\][\[\e[1;91m\]\u\[\e[35m\]@\[\e[1;35m\]\h \[\e[1;33m\]\W\[\e[1;34m\]]#\[\e[0;m\] "
else
    PS1="\[\e[1;34m\][\[\e[1;33m\]\u\[\e[35m\]@\[\e[1;35m\]\h \[\e[1;33m\]\W\[\e[1;34m\]]$\[\e[0;m\] "
fi

alias cp="cp -i"
alias mv="mv -i"
alias rm="rm -i"
alias rsync="rsync -vrPlu"
alias mkdir="mkdir -p"
alias df="df -h"
alias trp="trash-put"
alias trl="trash-list"
alias trr="trash-restore"

alias ls="ls -h --color=always --group-directories-first"
alias grep="grep --color=auto"
alias diff="diff --color=auto"
alias ip="ip -color=auto"

alias ka="killall"
alias e="$EDITOR"
alias v="$EDITOR"
alias z="zathura"
alias g="git"
alias xdg-qf="xdg-mime query filetype"
alias xdg-qd="xdg-mime query default"
alias xdg-def="xdg-mime default"
alias adb='HOME="$XDG_DATA_HOME"/android adb'
alias lofi="setsid -f mpv --no-video --no-resume-playback 'https://www.youtube.com/watch?v=jfKfPfyJRdk'"

. "$HOME/.config/shell/fzf_functions"

mkcd() { mkdir -pv "$1" && cd "$1" || exit; }
mvcd() { mv -vi "$1" "$2" && cd "$2" || exit; }

fd() {
    local dir
    dir=$(find ${1:-.} -type d -maxdepth 4 2> /dev/null | fzf +m) && cd "$dir"
}

fcd() {
    [ -z "$1" ] && return 1
    my_cmd="$(qf "$1" "d")"
    [ -z "$my_cmd" ] && return 1
    cd "$(eval "$my_cmd")" || exit
}

gdp() {
    [ -z "$1" ] && return 1
    my_cmd="$(qf "$1" "d" "$2")"
    [ -z "$my_cmd" ] && return 1
    eval "$my_cmd --multi --bind ctrl-a:select-all,ctrl-d:deselect-all,ctrl-t:toggle-all | sed 's/^/\"/;s/$/\"/' | tr '\n' ' ' | wl-copy"
}

gfp() {
    [ -z "$1" ] && return 1
    my_cmd="$(qf "$1" "f" "$2")"
    [ -z "$my_cmd" ] && return 1
    eval "$my_cmd --multi --bind ctrl-a:select-all,ctrl-d:deselect-all,ctrl-t:toggle-all | sed 's/^/\"/;s/$/\"/' | tr '\n' ' ' | wl-copy"
}

