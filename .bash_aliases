#!/bin/sh
#---------------------------
#--     .bash_aliases     --
#--      by lgaggini      --
#--      CC BY-SA 3.0     --
#---------------------------

# alias list
alias aliases='cat ~/.bash_aliases'

# script
alias onbak='sh ~/bin/onbak.sh'
alias offbak='sh ~/bin/offbak.sh'

# remote machine aliases
alias lghub='ssh lg@lghub'

# yaourt aliases
alias ysyu='yaourt -Syu'
alias ys='yaourt -S'
alias ysy='yaourt -Sy'
alias yrs='yaourt -Rs'
alias yr='yaourt -R'
alias yss='yaourt -Ss'
alias ysc='yaourt -Sc'
alias yscc='yaourt -Scc'
alias yqs="yaourt -Qs"
alias yql="yaourt -Ql"
alias yqi="yaourt -Qi"

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

# git aliases
alias gs='git status'
alias gd='git diff'
alias gc='git commit'
alias ga='git add'
alias gp='git push'
alias gpo='git push origin'
alias gpom='git push origin master'
alias gt='git timeline'

# python aliases
alias p2='python2'
alias p='python'

# shortcuts
alias s='sudo '
alias c='clear'
alias h='history'
alias m='man'
alias sb='source ~/.bashrc'
alias e='exit'
alias v='vim'
alias sv='sudo vim'
alias t='urxvt &' 
alias b='chromium &'
alias mus='urxvt -name ncmpcpp -e ncmpcpp'
alias mov='smplayer &' 
alias f='xfe &'
alias sf='mysudo xfe &'
alias ge='geany &'
alias sge='mysudo geany &'
alias news='urxvt -name newsbeuter -e newsbeuter &'
alias mail='urxvt -name mutt -e mutt &'
alias tasks='lxtask &'
alias im='gajim &'
alias irc='urxvt -name irssi -e screen irssi'
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
alias live='cd ~/musica/bootlegs/'
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

# super user
alias sudo='sudo '
alias mys='sudo -E'
alias res='sudo !!'
alias reboot='sudo reboot'
alias poweroff='sudo halt'
