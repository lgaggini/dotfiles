#!/bin/sh
#---------------------------
#--       .xinitrc        --
#--      by lgaggini     --
#--      CC BY-SA 3.0     --
#---------------------------

# numlock
numlockx &

# merge custom X resources
xrdb -merge ~/.Xresources

# volumeicon
volumeicon &

# mpd daemon user mode
mpd ~/.mpdconf &

# check monitors status, single or dual
# monitor=$(sh ~/bin/check_monitor.sh)

# set monitor(s) and start the window manager
#if [ $monitor = "dual" ]; then
#  sh ~/bin/dual-above.sh
#  exec awesome
#else
#  sh ~/bin/single.sh
#  exec awesome -c $XDG_CONFIG_HOME/awesome/rc.lua.single
#fi

exec /usr/bin/awesome
