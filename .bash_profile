#!/bin/sh
#---------------------------
#--     .bash_profile     --
#--      by lgaggini      --
#--      CC BY-SA 3.0     --
#---------------------------

[[ -f ~/.bashrc ]] && . ~/.bashrc

export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"

if [[ -z $DISPLAY && $(tty) = /dev/tty1 ]]; then
  startx
fi
