#!/bin/sh
#---------------------------
#--     .bash_aliases     --
#--      by lgaggini      --
#--      CC BY-SA 3.0     --
#---------------------------

# alias list
alias aliases='cat ~/.bash_aliases'

# script
alias onbak='sh ~/backup/onbak.sh'
alias offbak='sh ~/backup/offbak.sh'

# remote machine aliases
alias agharti='ssh lg@agharti'
alias nibiru='ssh lg@nibiru'

# yaourt aliases
alias ysyu='yaourt -Syu'
alias ysyua='yaourt -Syua'
alias ys='yaourt -S'
alias ysy='yaourt -Sy'
alias yrs='yaourt -Rs'
alias yr='yaourt -R'
alias yss='yaourt -Ss'
alias ysc='yaourt -Sc'
alias yscc='yaourt -Scc'
alias yqe='yaourt -Qe'
alias yqs="yaourt -Qs"
alias yql="yaourt -Ql"
alias yqi="yaourt -Qi"
alias yqqtd="yaourt -Qqtd"

# completion for yaourt / pacman aliases
function _pacalias
{
    local cur
    source /usr/share/bash-completion/completions/pacman
    cur="${COMP_WORDS[COMP_CWORD]}"
    case $COMP_WORDS in
        yr*)
            _pacman_pkg Qq;;
        yq*)
            { _arch_incomp 'g groups' && _pacman_pkg Qg sort; }    ||
            { _arch_incomp 'p file'   && _pacman_file; }           ||
            _arch_incomp 'o owns'   || _arch_incomp 'u upgrades' ||
            _pacman_pkg Qq;;
        ys*)
            { _arch_incomp 'g groups' && _pacman_pkg Sg; }      ||
            { _arch_incomp 'l list'   && _pacman_pkg Sl sort; } ||
            _pacman_pkg Slq;;
        yu*)
            _pacman_file;;
    esac
    return 0;
}
complete -F _pacalias ysyu
complete -F _pacalias ys
complete -F _pacalias yss
complete -F _pacalias ysc
complete -F _pacalias yscc
complete -F _pacalias yqs
complete -F _pacalias yql
complete -F _pacalias yqi
complete -F _pacalias yrs
complete -F _pacalias yr

# aptitude/apt-get alias
manager='aptitude'
alias apu='sudo $manager update'
alias apuu='sudo $manager upgrade'
alias api='sudo $manager install'
alias apr='sudo $manager remove'
alias app='sudo $manager purge'
alias aps='sudo $manager search'
alias apss='sudo $manager show'
alias apc='sudo $manager clean'
alias apcc='sudo $manager autoclean'
alias apd='sudo $manager download'

# completion for aptitude / apt-get aliases
function _apalias()
{
    local cur
    cur=`_get_cword`
    case $COMP_WORDS in
        api|apss|apd)
            COMPREPLY=( $( apt-cache pkgnames $cur 2> /dev/null ) )
            return 0;;
        apr|app)
            source /usr/share/bash-completion/completions/dpkg
            COMPREPLY=( $( _comp_dpkg_installed_packages "$cur" ) )
            return 0;;
    esac
    return 0
}
complete -F _apalias api
complete -F _apalias apss
complete -F _apalias apd
complete -F _apalias apr
complete -F _apalias app

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
alias wh='which'
alias lsdir='du -xmh --max-depth=1 | sort -rh'
alias path='echo -e ${PATH//:/\\n}'
alias ssh='TERM=rxvt ssh'

# git aliases
alias gs='git status'
alias gv='git show'
alias gd='git diff --word-diff'
alias gc='git commit'
alias ga='git add'
alias gpl='git pull'
alias gps='git push'
alias gr='git rm'
alias gt='git timeline'
alias gl='git log --oneline --decorate'
alias gg='git grep'
alias gm='git merge'
alias gmv='git checkout'
alias gb='git branch'

# python aliases
alias p2='python2'
alias p='python'

# shortcuts
alias s='sudo '
alias open='xdg-open'
alias c='clear'
alias h='history'
alias m='man'
alias sb='source ~/.bashrc'
alias e='exit'
alias v='vim'
alias sv='sudo vim'
alias t='urxvt &' 
alias b='chromium &'
alias f='thunar &'
alias sf='sudo thunar &'
alias e='gvim &'
alias se='mys gvim &'
alias news='urxvt -name newsbeuter -e newsbeuter &'
alias mail='urxvt -name mutt -e mutt &'
alias gnote='zim &'
alias pad='leafpad &'
alias tasks='lxtask &'
alias im='gajim &'
alias irc='hexchat &'
alias office='libreoffice &'
alias theme='lxappearance &'
alias mus='sonata &'
alias mov='smplayer &' 
alias burn='wodim'
alias cdrw='wodim dev=/dev/sr0 blank=fast'
alias scan='nmap -v -sT -Pn'
alias netscan='nmap -sn'

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
alias film='cd ~/media/video/film/'
alias tv='cd ~/media/video/serie'
alias book='cd ~/book/book/'
alias comics='cd ~/book/comics/'
alias down='cd ~/download'
alias doc='cd ~/doc'
alias code='cd ~/code'
alias album='cd ~/media/music/album'
alias live='cd ~/media/music/bootlegs'
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
alias flac2ogg='for i in *.flac; do sox -S $i -C5 $(basename $i .flac).ogg; done'
alias wav2ogg='for i in *.wav; do sox -S $i -C5 $(basename $i .wav).ogg; done'
alias mp32ogg='for i in *.mp3; do sox -S $i -C5 $(basename $i .mp3).ogg; done'
alias apetomp3='for i in *.ape; do ffmpeg -i $i -id3v2_version 3 -codec:a libmp3lame -ab 192K $(basename $i .ape).mp3; done'

# super user
alias sudo='sudo '
alias mys='sudo -E'
alias res='sudo !!'
alias reboot='sudo reboot'
alias poweroff='sudo halt'
