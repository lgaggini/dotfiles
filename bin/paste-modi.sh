#!/usr/bin/env bash

if [ -z "$@" ]; then
  greenclip print
else
  greenclip print "$1"
  coproc (xdotool key --clearmodifiers Shift+Insert &)
  exit 0
fi
