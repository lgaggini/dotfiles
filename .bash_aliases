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

# toolbox aliases (ls, cp, grep, find, cd, etc.)
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
alias gp='grep -color=auto'
alias sd='sed'
alias aw='awk'
alias le='less'
alias he='head'
alias tp='htop'
alias ta='tail -f'
alias ct='cat'
alias rs='rsync --progress --partial'
alias st='sort'
alias pg='ping -c 7'
alias un='uniq'
alias ut='sudo umount'
alias wh='which'
alias lsdir='du -xmh --max-depth=1 | sort -rh'
alias path='echo -e ${PATH//:/\\n}'
alias c='clear'
alias h='history'
alias m='man'
alias sb='source ~/.bashrc'
alias e='exit'

# app aliases
alias v='vim'
alias scan='nmap -v -sT -Pn'
alias netscan='nmap -sn'
alias ssh='TERM=rxvt ssh'
alias unlock='gkeyring -k Portachiavi_predefinito --unlock'
alias wttr='curl wttr.in'
alias cal='khal'
alias mirror_update='sudo reflector --latest 100 --sort rate --save /etc/pacman.d/mirrorlist'
alias mutt='neomutt'
alias vpn='sudo openvpn --config ~/.openvpn/dada/client.conf'
alias clusters='cat /etc/ansible/hosts | grep "^\[" | sed 's/[][]//g''
alias livesets='scdl -l https://soundcloud.com/lgaggini-euphoria/sets/sets-to-listen --path ~/media/music/trance/livesets/ --no-playlist-folder --download-archive ~/media/music/trance/livesets/livesets.txt'

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
alias gct='git ctimeline'
alias gl='git log --oneline --decorate'
alias gg='git grep'
alias gm='git merge'
alias gmv='git checkout'
alias gb='git branch'

# svn aliases
alias svu='svn update'
alias svs='svn status'
alias svc='svn commit -m'
alias svd='svn diff -r HEAD'
alias svl='svn log -v'
alias sva='svn add'
alias svr='svn revert'

# python aliases
alias p2='python2'
alias p='python'

# generic folder aliases
alias .='pwd'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias ......='cd ../../../../..'
alias prev='cd -'
alias usb='cd /media/usb'
alias cdrom='cd /media/cdrom'
alias mobile='cd /media/mobile'
alias iso='cd /media/iso'
alias esterno='cd /mnt/esterno'

# home folder aliases
alias home='cd ~'
alias bin='cd ~/bin'
alias code='cd ~/code'
alias down='cd ~/down'
alias doc='cd ~/doc'
alias logs='cd ~/logs'
alias media='cd ~/media'
alias music='cd ~/media/music'
alias reading='cd ~/read'
alias tmp='cd ~/tmp'

# super user
alias s='sudo '
alias sudo='sudo '
alias mys='sudo -E'
alias res='sudo !!'
alias reboot='sudo reboot'
alias poweroff='sudo halt'
