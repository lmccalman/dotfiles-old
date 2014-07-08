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
# compton -bfzcCG --backend glx --vsync opengl-swc --paint-on-overlay -D5 -r6 -l-8 -t-8
compton --config $HOME/.compton.conf -b
xrdb  $HOME/.Xresources
wmname LG3D
xsetroot -cursor_name left_ptr &
/usr/lib/xfce4/notifyd/xfce4-notifyd &
unclutter -grab -noevents -root &
urxvtd &


#$HOME/environ/rotatingwallpaper &
feh --bg-fill $HOME/images/wallpapers/vim-shortcuts.png
SpiderOak &
nm-applet &
xscreensaver -no-splash &
xflux -l 33 -g 151
exec xmonad
