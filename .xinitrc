#!/bin/sh
#---------------------------
#--       .xinitrc        --
#--      by lgaggini      --
#--      CC BY-SA 3.0     --
#---------------------------

# numlock
numlockx &

# Merge custom X resources
if [ -f $HOME/.Xresources ]; then
  xrdb -merge ~/.Xresources
fi

# volumeicon
volumeicon &

# clipboard mabager
parcellite &

# seafile client
#seafile-applet &

# custom keyboard mapping
if [ -f $HOME/.Xmodmap ]; then
  (sleep 30 && /usr/bin/xmodmap $HOME/.Xmodmap) &
fi

# single press of control to escape https://github.com/alols/xcape
#(sleep 20 && xcape) &

# xfce power manager
xfce4-power-manager &

# autolock
xautolock -locker xflock4 -time 10 &

# connection manager
wicd-client --tray &

# check monitors status and set monitor setup
if [ $(~/bin/check_dp3.sh) -eq 0 ]; then
  sh ~/.screenlayout/dp3-left.sh
fi

# redshift gamma / brightness manager
redshift-gtk &

# backlight setting
xbacklight -set 50

# davamil start
davmail &

# http://unix.stackexchange.com/a/295652/88209
source /etc/X11/xinit/xinitrc.d/50-systemd-user.sh

# hide unused mouse
unclutter &

# wm
exec /usr/bin/awesome
