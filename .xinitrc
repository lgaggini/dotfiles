#!/bin/sh
#---------------------------
#--       .xinitrc        --
#--      by lgaggini      --
#--      CC BY-SA 3.0     --
#---------------------------

# network manager applet
nm-applet &

# pulse audio applet
pasystray &

# bluetooth applet
blueman-applet &

# custom keyboard mapping
if [ -f $HOME/.Xmodmap ]; then
    /usr/bin/xmodmap $HOME/.Xmodmap
fi

# single press of control to escape https://github.com/alols/xcape
xcape -e 'Control_L=Escape'

# hide unused mouse
unclutter &

# gnome-keyring ssh agent proper socket
export SSH_AUTH_SOCK="${XDG_RUNTIME_DIR}"/gcr/ssh

# logitech devices applet
solaar -w hide &

# check monitors status and set monitor setup
autorandr -c

# start compositor
picom --daemon

# wm
exec /usr/bin/awesome
