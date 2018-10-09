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

# xfce power manager
xfce4-power-manager &

# autolock
xautolock -locker xflock4 -time 10 &

# connection manager
wicd-client --tray &

# check monitors status and set monitor setup
if [ $(~/bin/check_dual_monitor.sh) -eq 0 ]; then
  sh ~/.screenlayout/dp3-left-vga1-right.sh-left.sh
elif [ $(~/bin/check_dp3.sh) -eq 0]; then
  sh ~/.screenlayout/dp3-left.sh
fi

# backlight setting
xbacklight -set 50

# http://unix.stackexchange.com/a/295652/88209
source /etc/X11/xinit/xinitrc.d/50-systemd-user.sh

# custom keyboard mapping
if [ -f $HOME/.Xmodmap ]; then
    /usr/bin/xmodmap $HOME/.Xmodmap
fi

# single press of control to escape https://github.com/alols/xcape
xcape -e 'Control_L=Escape'

# hide unused mouse
unclutter &

# gnome-keyring
eval $(/usr/bin/gnome-keyring-daemon --start --components=pkcs11,secrets,ssh)
export SSH_AUTH_SOCK

# geoclue agent
/usr/lib/geoclue-2.0/demos/agent &

# wm
exec /usr/bin/awesome
