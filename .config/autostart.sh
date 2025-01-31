#!/bin/bash

export $(dbus-launch)
/usr/libexec/pipewire-launcher
# https://www.reddit.com/r/artixlinux/comments/y75r1b/wireplumber_doesnt_start/

fcitx5 &
foot --server &
swww-daemon &
"$XDG_CONFIG_HOME/swww_randomize_multi.sh" "$XDG_CONFIG_HOME/propaganda_posters/"
mpd &

# exec dbus-update-activation-environment DISPLAY WAYLAND_DISPLAY XDG_CURRENT_DESKTOP=sway
# https://www.reddit.com/r/swaywm/comments/uxqt8c/how_do_i_start_xdgdesktopportalwlr_properly/
# https://github.com/emersion/xdg-desktop-portal-wlr/wiki/%22It-doesn't-work%22-Troubleshooting-Checklist
