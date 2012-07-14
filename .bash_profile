#!/bin/sh
#---------------------------
#--     .bash_profile     --
#--      by lgaggini      --
#--      CC BY-SA 3.0     --
#---------------------------

[[ -f ~/.bashrc ]] && . ~/.bashrc

if [[ -z $DISPLAY && $(tty) = /dev/tty1 ]]; then
  #xinit /usr/bin/awesome
  startx
fi
