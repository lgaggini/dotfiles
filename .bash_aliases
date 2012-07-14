#!/bin/sh
#---------------------------
#--     .bash_aliases     --
#--      by lgaggini      --
#--      CC BY-SA 3.0     --
#---------------------------

# alias list
alias aliases='cat ~/.bash_aliases'

# script
alias onbak='sh ~/bin/onsitebak.sh'
alias dsync='sh ~/bin/datasync.sh'
alias offbak='sh ~/bin/offsitebak.sh'
alias pdftomobi='sh ~/bin/pdftomobi.sh'
alias mmusic='sh ~/bin/mobilemusic.sh'

# remote machine aliases
#lghub ="ssh@"

# yaourt aliases
alias ysyu='yaourt -Syu'
alias ys='yaourt -S'
alias yrs='yaourt -Rs'
alias yss='yaourt -Ss'
alias ysc='yaourt -Sc'
alias yscc='yaourt -Scc'
alias yqs="yaourt -Qs"
alias yql="yaourt -Ql"
alias yqi="yaourt -Qi"   

# toolbox aliases (ls, cp, grep, find, cd)
alias la='ls -a --color=auto'
alias ll='ls -alh --color=auto'
alias lr='ls -aR --color=auto'
alias lt='ls -lahrt --color=auto'
alias ln='ln -si'
alias mv='mv -iv'
alias cp='cp -ripv'
alias rm='rm -rv'
alias df='df -h'
alias cl='column'
alias du='du -h'
alias diff='colordiff'
alias md='mkdir -p'
alias rd='rmdir'
alias ps='ps auxf'
alias kl='kill'
alias pk='pkill'
alias ff='find / -name'
alias fl='file'
alias sf='sudo find / -name'
alias gr='grep -color=auto'
alias sd='sed'
alias aw='awk'
alias le='less'
alias he='head'
alias tp='htop'
alias ta='tail -f'
alias ct='cat'
alias rs='rsync --progress --partial'
alias sr='sort'
alias pg='ping -c 7'
alias un='uniq'
alias ut='sudo umount'
alias lsdir='du -xmh --max-depth=1 | sort -rh'
alias path='echo -e ${PATH//:/\\n}'

# shortcuts
alias s='sudo'
alias c='clear'
alias h='history'
alias e='exit'
alias v='vim'
alias sv='sudo vim'
alias t='urxvt &' 
alias b='chromium &'
alias mus='urxvt -name mocp -e mocp'
alias mov='smplayer &' 
alias f='xfe &'
alias sf='mysudo xfe &'
alias ge='geany &'
alias sge='mysudo xfe &'
alias news='urxvt -name newsbeuter -e newsbeuter &'
alias mail='urxvt -name alpine -e alpine &'
alias tasks='lxtask &'
alias im='gajim &'
alias irc='urxvt -name irssi -e screen irssi'
alias girc='xchat &'
alias office='libreoffice &'
alias theme='lxappearance &'
alias burn='wodim'
alias cdrw='wodim dev=/dev/sr0 blank=fast'

# folder aliases
alias home='cd ~'
alias .='pwd'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias ......='cd ../../../../..'
alias prev='cd -'
alias bin='cd ~/bin'
alias film='cd ~/code'
alias tv='cd ~/video/serietv'
alias book='cd ~/letteratura/libri'
alias comics='cd ~/letteratura/fumetti'
alias down='cd ~/download'
alias doc='cd ~/doc'
alias code='cd ~/code'
alias album='cd ~/musica/album'
alias usb='cd /media/usb'
alias cdrom='cd /media/cdrom'
alias mobile='cd /media/mobile'
alias iso='cd /media/iso'
alias esterno='cd /mnt/esterno'

# music (mpd control + volume)
alias v-='amixer -q set Master 5- unmute'
alias v+='amixer -q set Master 5+ unmute'
alias mute='amixer -q set Master toggle'
alias mi='mpc playlist'
alias mp='mpc play'
alias ms='mpc stop'
alias mpp='mpc toggle'
alias mprev='mpc prev'
alias mnext='mpc next'

# super user
alias sudo='sudo '
alias mysudo='sudo HOME=$HOME'
alias resudo='sudo !!'
alias reboot='sudo reboot'
alias poweroff='sudo halt'
