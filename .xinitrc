#!/bin/sh

#D-Bus
if [ -d /etc/X11/xinit/xinitrc.d ]; then
  for f in /etc/X11/xinit/xinitrc.d/*; do
    [ -x "$f" ] && . "$f"
  done
  unset f
fi

#GPG
eval $(gpg-agent --daemon) &

# # Start GNOME Keyring
# eval $(/usr/bin/gnome-keyring-daemon --start --components=gpg,pkcs11,secrets,ssh)
# export SSH_AUTH_SOCK
# export GPG_AGENT_INFO
# export GNOME_KEYRING_CONTROL
# export GNOME_KEYRING_PID

#Increase 2D pixmap performance for firefox
nvidia-settings -a InitialPixmapPlacement=2
xrdb  $HOME/.Xresources
wmname LG3D
xsetroot -cursor_name left_ptr &
/usr/lib/xfce4/notifyd/xfce4-notifyd &
unclutter -grab -noevents -root &
urxvtd &


$HOME/environ/rotatingwallpaper &
SpiderOak &
nm-applet &
xscreensaver -no-splash &
exec xmonad
