#!/bin/sh

export $(dbus-launch)
/usr/libexec/pipewire-launcher
# https://www.reddit.com/r/artixlinux/comments/y75r1b/wireplumber_doesnt_start/

foot --server &
swaybg -m fit -i "/home/kuss/.config/wallpaper.jpg" &
swayidle -w &
fcitx5 &
mpd & # mpd-mpris is started with service

# exec dbus-update-activation-environment DISPLAY WAYLAND_DISPLAY XDG_CURRENT_DESKTOP=sway
# https://www.reddit.com/r/swaywm/comments/uxqt8c/how_do_i_start_xdgdesktopportalwlr_properly/
# https://github.com/emersion/xdg-desktop-portal-wlr/wiki/%22It-doesn't-work%22-Troubleshooting-Checklist
