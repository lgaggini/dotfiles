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
clipit &

# seafile client
seafile-applet &

# custom keyboard mapping
if [ -f $HOME/.Xmodmap ]; then
  (sleep 20 && /usr/bin/xmodmap $HOME/.Xmodmap) &
fi

# single press of control to escape https://github.com/alols/xcape
(sleep 20 && xcape) &

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
