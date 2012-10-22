#!/bin/bash

echo -e "
db   db  .d88b.  .d8888. d888888b d8b   db  .d8b.  .88b  d88. d88888b
88   88 .8P  Y8. 88'  YP `~~88~~' 888o  88 d8' `8b 88'YbdP`88 88'    
88ooo88 88    88 `8bo.      88    88V8o 88 88ooo88 88  88  88 88ooooo
88~~~88 88    88   `Y8b.    88    88 V8o88 88~~~88 88  88  88 88~~~~~
88   88 `8b  d8' db   8D    88    88  V888 88   88 88  88  88 88.    
YP   YP  `Y88P'  `8888Y'    YP    VP   V8P YP   YP YP  YP  YP Y88888P

%+++++++++++++++++++++ SYSTEM INFO +++++++++++++++++++++%
CPU: `cat /proc/cpuinfo | grep 'model name' | head -1 | cut -d':' -f2`
RAM: `free -m | head -n 2 | tail -n 1 | awk {'print $2'}`MB
OS: `uname -srmo`

%++++++++++++++++++++ SYSTEM STATUS ++++++++++++++++++++%
System load: `uptime`
Used memory: `free -m | head -n 3 | tail -n 1 | awk {'print $3'}`MB
`df -h`

%++++++++++++++++++++ SYSTEM MESSAGE +++++++++++++++++++%
`fortune`

Enjoy your hack free as in freedom!
" > /etc/motd
