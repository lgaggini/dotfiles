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

# xfce power manager
xfce4-power-manager &

# autolock
xautolock -locker i3lock-fancy -time 10 &

# backlight setting
xbacklight -set 50

# http://unix.stackexchange.com/a/295652/88209
source /etc/X11/xinit/xinitrc.d/50-systemd-user.sh

# set xxkbmap before to apply custom keyboard mapping
setxkbmap it

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

# qt5ct theming
export QT_QPA_PLATFORMTHEME=qt5ct

# workrave
workrave &

# check monitors status and set monitor setup
autorandr -c

# wm
exec /usr/bin/awesome
