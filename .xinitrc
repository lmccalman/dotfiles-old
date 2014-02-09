#!/bin/sh
#
# ~/.xinitrc
#
# Executed by startx (run your window manager from here)

#Increase 2D pixmap performance for firefox
nvidia-settings -a InitialPixmapPlacement=2
xrdb  $HOME/.Xresources
wmname LG3D
xsetroot -cursor_name left_ptr &
/usr/lib/xfce4/notifyd/xfce4-notifyd &
unclutter -grab -noevents -root &
urxvtd &

# Start GNOME Keyring
eval $(/usr/bin/gnome-keyring-daemon --start --components=gpg,pkcs11,secrets,ssh)
export SSH_AUTH_SOCK
export GPG_AGENT_INFO
export GNOME_KEYRING_CONTROL
export GNOME_KEYRING_PID

$HOME/docs/dotfiles/rotatingwallpaper &
SpiderOak --headless &
nm-applet &
xscreensaver -no-splash &
sxhkd &
exec bspwm
