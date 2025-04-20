#!/bin/bash

export $(dbus-launch)
/usr/libexec/pipewire-launcher
# https://www.reddit.com/r/artixlinux/comments/y75r1b/wireplumber_doesnt_start/

fcitx5 &
foot --server &
mpd &
wlsunset -l -7.98 -L 112.63 &
swaybg -m fit -i "$HOME/.config/wallpaper.jpg" &

# exec dbus-update-activation-environment DISPLAY WAYLAND_DISPLAY XDG_CURRENT_DESKTOP=sway
# https://www.reddit.com/r/swaywm/comments/uxqt8c/how_do_i_start_xdgdesktopportalwlr_properly/
# https://github.com/emersion/xdg-desktop-portal-wlr/wiki/%22It-doesn't-work%22-Troubleshooting-Checklist
