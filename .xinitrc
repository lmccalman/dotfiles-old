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

#Increase 2D pixmap performance for firefox
# compton -bfzcCG --backend glx --vsync opengl-swc --paint-on-overlay -D5 -r6 -l-8 -t-8
compton --config $HOME/.compton.conf -b
xrdb  $HOME/.Xresources
wmname LG3D
xsetroot -cursor_name left_ptr &
/usr/lib/xfce4/notifyd/xfce4-notifyd &
unclutter -grab -noevents -root &
$HOME/environ/rotatingwallpaper &
SpiderOak &
dropboxd &
nm-applet &
xscreensaver -no-splash &
xflux -l 33 -g 151 -k 2700
offlineimap > $HOME/mail/offlineimap.log 2>&1 &
## i3
#exec i3

# bspwm
sxhkd &
exec bspwm
