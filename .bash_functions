#!/bin/sh
#---------------------------
#--    .bash_functions    --
#--      by lgaggini      --
#--      CC BY-SA 3.0     --
#---------------------------

#
# bash_functions help
#
# help_funcs - summary of custom user functions
# usage: help-funcs
functions()
{
    cat "${HOME}/.bash_functions" | grep -B 1 usage
}

#
# service management
#
# start, stop, restart, reload, status - simple systemd / system V daemon management
# usage: start/stop/restart/reload <daemon-name>
system='systemctl'

# systemd
if [ $system == "systemctl" ]; then 
    # alias
    start()
    {
        for arg in $*; do
            sudo $system start $arg
        done
    }

    stop()
    {
        for arg in $*; do
            sudo $system stop $arg
        done
    }

    restart()
    {
        for arg in $*; do
            sudo $system restart $arg
        done
    }

    reload()
    {
        for arg in $*; do
            sudo $system reload $arg 
        done
    }

    status()
    {
        for arg in $*; do
            sudo $system status $arg 
        done
    }
    # completion
    source /usr/share/bash-completion/completions/$system
    complete -F _$system start
    complete -F _$system reload
    complete -F _$system restart
    complete -F _$system stop
    complete -F _$system status
# systemV
elif [ $system == "service" ]; then 
    # alias
    start()
    {
        for arg in $*; do
            sudo $system $arg start
        done
    }

    stop()
    {
        for arg in $*; do
            sudo $system $arg stop
        done
    }

    restart()
    {
        for arg in $*; do
            sudo $system $arg restart
        done
    }

    reload()
    {
        for arg in $*; do
            sudo $system $arg reload
        done
    }

    status()
    {
        for arg in $*; do
            sudo $system $arg status
        done
    }
    # completion
    function _service()
    {
        local cur services
        cur=`_get_cword`
        services=`ls /etc/init.d`
        COMPREPLY=( $(compgen -W "${services}" -- ${cur}) )
        return 0
    }
    complete -F _service start
    complete -F _service reload
    complete -F _service restart
    complete -F _service stop
    complete -F _service status
fi

#
# navigation and basic operations
#
# mkcd - makedir and cd in it
# usage: mkcd <file>
mkcd () 
{ 
    mkdir $1 && cd $1 
}

# cpcd - cp and cd to destination
# usage: cpcd <cp-arguments>
cpcd ()
{
    cp $@ && cd ${!#}
}

# mvcd - mv and cd to destination
# usage: mvcd <mv-arguments>
mvcd ()
{
    mv $@ && cd ${!#}
}

# cdls - cd and ls
# usage: cdls <path>
cdls()
{
    cd $@;
    ls -a --color=auto
}

# up - cd up by n directories
# usage: up <level-numbers>
up()
{
    dir=""
    if [ -z "$1" ]; then
        dir=..
    elif [[ $1 =~ ^[0-9]+$ ]]; then
        x=0
        while [ $x -lt ${1:-1} ]; do
            dir=${dir}../
            x=$(($x+1))
        done
    else
        dir=${PWD%/$1/*}/$1
    fi
    cd "$dir";
}

# uprm - move up by 1 and remove directory
# usage: uprm
uprm()
{
    dir=$(pwd)
    cd ..
    rm -r $dir
}

# swap - switch 2 filenames around
# usage: swap <file1> <file2>
swap()
{
    local TMPFILE=tmp.$$
    mv "$1" $TMPFILE
    mv "$2" "$1"
    mv $TMPFILE "$2"
}

# bak - backup selected file
# usage: bak <filename>
bak()
{
    cp $1{,.bak}
}

#
# ownership and fixes
#
# default - set file/directory owner and permissions to normal values (644/755)
# usage: default <file>
default()
{
    sudo chmod -R u=rwX,go=rX "$@"
    sudo chown -R ${USER}:users "$@"
}

# grab - grab the ownership of a file
# usage: grab <file>
grab() 
{ 
    sudo chown -R ${USER}:${GROUP} ${1:-.} 
}

# own - change ownership
# usage: own <file> <user>
own() 
{ 
    chown -R "$2":"$2" ${1:-.}
}

# cpmod - copy permission from file1 to file2
# usage: cpmod <file1> <file2>
cpmod()
{
    chmod --reference $1 $2
}

# lowercase - rename file names to lowercase and replace space with underscore from pwd
# usage: lowercase
lowercase()
{
    # Process each directory’s contents before the directory  itself
    find * -depth -type d | while read x
    do
        # Translate Caps to Small letters
        y=$(echo "$x" | tr '[A-Z ]' '[a-z_]');
        # create directory if it does not exit
        if [ ! -d "$y" ]; then
                mkdir -p "$y"
        fi
        # check if the source and destination is the same
        if [ "$x" != "$y" ]; then
                # move directory files before deleting
                ls -A "$x" | while read i
                do
                  mv "$x"/"$i" "$y"
                done
                rmdir "$x"
        fi
    done
    # Rename all files
    find * -type f | while read x
    do
        # Translate Caps to Small letters
        y=$(echo "$x" | tr '[A-Z ]' '[a-z_]')
        if [ "$x" != "$y" ]; then
                mv "$x" "$y"
        fi
    done
}

# fix-tabs - replace tabs with space
# usage: fix-tabs <file>
fix-tabs() 
{ 
    expand -t 4 "$1" > "$1.expanded"
    mv -f "$1.expanded" "$1"
}


#
# find and grep
#
# fp - find a file by name in pwd
# usage: fp <name>
fp()
{
    sudo find . -iname '*'$*'*' -ls
}

# fr - find a file by name globally
# usage: fr <name>
fr()
{
    sudo find / -iname '*'$*'*' -ls
}

# fcd - find a file by name in selected path
# usage: fcd <name> <path>
fcd()
{
    sudo find $2 -iname '*'$1'*' -ls
}

# fpg - find a file by grepping in pwd
# usage: fpg <word>
fpg()
{
    sudo grep --color=auto -HIrFo -- $* .
}

# frg - find a file by grepping in root
# usage: frg <word>
frg()
{
    sudo grep --color=auto -HIrFo -- $* /
}

# fcdg - find a file by grepping in selected path
# usage: fcdg <word> <path>
fcdg()
{
    sudo grep --color=auto -HIrFo -- $1 $2
}

# mang - search in man page
# usage: mang <manpage> <word>
mang()
{
    man $1 | grep --color=auto $2 -C 5
}

# hig - search in history
# usage: hig <word>
hig()
{
    history | grep --color=auto $* -C 5
}

# psg - check if a process is running by name and return PID(s)
# usage: psg <process-name>
psg()
{
    if ps ax | grep -v grep | grep $1 > /dev/null
    then
        ps ax | grep --color=auto $1
    else
        echo "$1 is not running"
    fi
}


#
# cli utility
#
# dict - dictionary
# usage: dict <keyword>
dict()
{
    sdcv $* | less
}

# calc - basic calculator
# usage: calc <expression>
calc()
{
    echo "scale=4; $1" | bc
}

# sm - send email from console
# usage: sm <to> <subject> <body> 
sm()
{
    $ echo $3 | mailx -s $2 $1
}

# sr - grab info from web, default google by duckduckgo
# usage: sr <keyword>
sr()
{
    if [[ -z "$2" ]]; then
        surfraw S \!gitl $1
        return 1
    fi
    surfraw $@
}

# srg - grab info from web, default google by duckduckgo, gui version
# usage: srg <keyword>
srg()
{
    if [[ -z "$2" ]]; then
        surfraw -g S \!gitl $1
        return 1
    fi
    surfraw $@
}


# web - web pager
# usage: web <url>
web()
{
    w3m $1
}

# publicip - get the current public ip address
# usage: publicip
myip()
{ 
    curl ifconfig.me/ip
}

# extract - extract compressed files
# usage: extract <files>
extract() 
{
    local e=0 i c
    for i; do
    if [ -f $i && -r $i ]; then
        c=
        case $i in
            *.tar.bz2) c='tar xjf'    ;;
            *.tar.gz)  c='tar xzf'    ;;
            *.bz2)     c='bunzip2'    ;;
            *.gz)      c='gunzip'     ;;
            *.tar)     c='tar xf'     ;;
            *.tbz2)    c='tar xjf'    ;;
            *.tgz)     c='tar xzf'    ;;
            *.7z)      c='7z x'       ;;
            *.Z)       c='uncompress' ;;
            *.exe)     c='cabextract' ;;
            *.rar)     c='unrar x'    ;;
            *.xz)      c='unxz'       ;;
            *.zip)     c='unzip'      ;;
            *)     echo "$0: cannot extract \`$i': Unrecognized file extension" >&2; e=1 ;;
        esac
        [ $c ] && command $c "$i"
    else
        echo "$0: cannot extract \`$i': File is unreadable" >&2; e=2
    fi
    done
    return $e
}

# compress - archive wrapper
# usage: compress <foo.tar.gz> ./foo ./bar
compress()
{
  FILE=$1
  case $FILE in
    *.tar.bz2) shift && tar cjf $FILE $* ;;
    *.tar.gz) shift && tar czf $FILE $* ;;
    *.tgz) shift && tar czf $FILE $* ;;
    *.zip) shift && zip $FILE $* ;;
    *.rar) shift && rar $FILE $* ;;
    *.7z)  shift && 7za a $FILE $* ;;
  esac
}

# colors - test console colors
# usage: colors
colors()
{
    T='gYw'   # The test text
    
    echo -e "\n                 40m     41m     42m     43m\
     44m     45m     46m     47m";

    for FGs in '    m' '   1m' '  30m' '1;30m' '  31m' '1;31m' '  32m' \
               '1;32m' '  33m' '1;33m' '  34m' '1;34m' '  35m' '1;35m' \
               '  36m' '1;36m' '  37m' '1;37m';
      do FG=${FGs// /}
      echo -en " $FGs \033[$FG  $T  "
      for BG in 40m 41m 42m 43m 44m 45m 46m 47m;
        do echo -en "$EINS \033[$FG\033[$BG  $T  \033[0m"
      done
      echo
    done
    echo
}

# mkiso - make iso from folder
# usage: mkiso <folder> <volume-name>
mkiso() 
{ 
    mkisofs -V $2 -J -r $1 -o isoimage.iso
}

# log - view live and color logs
# usage: log <logname>
log()
{
    sudo tail -f -n 50 $1 | ccze
}


#
# automations
#
# dotfiles - sync dotfiles for git sync
# usage: dotfiles
dots()
{
    rsync -a -v --existing /home/lg/ /home/lg/code/lgaggini/dotfiles/
}

# cf - wrapper for configuration files
# usage: cf <alias-or-filename>
cf()
{
    if [[ -z "$1" ]]; then
        echo "Missing arguments. Syntax: {FILE|ALIAS}"
        return 1
    fi
    case "$1" in
        'alias')
            $EDITOR "${HOME}/.bash_aliases"
            source "${HOME}/.bash_aliases"
            ;;
        'function')
            $EDITOR "${HOME}/.bash_functions"
            source "${HOME}/.bash_functions"
            ;;
        'inputrc')
            $EDITOR "${HOME}/.inputrc"
            ;;
        'bash')
            $EDITOR "${HOME}/.bashrc"
            source "${HOME}/.bashrc"
            ;;
        'Xresources')
            $EDITOR "${HOME}/.Xresources"
            ;;
        'vim')
            $EDITOR "${HOME}/.vimrc"
            ;;
        'mutt')
            $EDITOR "${HOME}/.muttrc"
            ;;
        'awesome')
            $EDITOR "${HOME}/.config/awesome/rc.lua"
            ;;
        'fstab')
            sudo -E $EDITOR '/etc/fstab'
            ;;
        *)
            if [[ "$(readlink -f "$1")" != ${HOME}/* ]]; then
                sudo -E $EDITOR "$1"
            else
                $EDITOR "$1"
            fi
            ;;
    esac
}

# pw - generate a random password
# usage: pw <password-length> - defaults to 12
pw() 
{
    echo $(cat /dev/urandom | tr -cd '[:graph:]' | head -c ${1:-12})
}

# um - mount selected device ad usb stick or disk
# usage: um <dev>
um()
{
    sudo mount $1 /media/usb && cd /media/usb
}

# mm - mount selected device as mobile
# usage: mm <dev>
mm()
{
    sudo mount $1 /media/mobile && cd /media/mobile
}

# isom - mount selected iso to selected mount point 
# usage: isom <iso>
isom()
{
    sudo mount $1 /media/iso -oloop && cd /media/iso
}

# cheat autocompletion
function _cheat_autocomplete {
    sheets=$(cheat -l | cut -d' ' -f1)
    COMPREPLY=()
    if [ $COMP_CWORD = 1 ]; then
        COMPREPLY=(`compgen -W "$sheets" -- $2`)
    fi
}

complete -F _cheat_autocomplete cheat

# check aur packages update
yqu()
{
  yaourt -Qs | grep "^local" | cut -d '/' -f2 | cut -d' ' -f1 | while read package; do yaourt -Ss $package; done | grep 'installed:' | cut -d'/' -f2 | cut -d' ' -f1
}

#
# note manager
#

# note folder
note_path_lgaggini=~/note/
note_path="$note_path_lgaggini"

# note - quick note view and edit/create
# usage: note <name>
note()
{
    case "$1" in
        'lgaggini')
            note_path="$note_path_lgaggini"
            ;;
    esac

    if [[ -z "$1" ]]; then
        ls -lh "$note_path"
    else
        vim "$note_path"$1.txt
        #git --git-dir=$note_path.git --work-tree=$note_path add $note_path$2.txt
        #git --git-dir=$note_path.git --work-tree=$note_path commit -m 'cli note change'
    fi
}
# _note - note name completion
_note() 
{
    local cur names IFS
 
    cur="${COMP_WORDS[COMP_CWORD]}"
    names=`ls "$note_path" | sed 's/\.[^.]*$//'`
    IFS=$'\t\n'
 
    COMPREPLY=( $(compgen -W "${names}" -- ${cur}) )
    return 0
}
complete -o nospace -F _note note
# noteg - search in notes
noteg()
{
    case "$1" in
        'lgaggini')
            note_path=$note_path_lgaggini
            ;;
    esac
    grep --color=auto -HInrFoi ${*:2} -C 5 "$note_path"
}

# cluster_info - get groups/hosts info by ansible and ansible-cmdb
cluster_info()
{
    ~/bin/cluster_info.sh $1
}

# _cluster_info - group name completion for cluster_info from ansible inventory
_cluster_info()
{
    local cur groups IFS

    groups=`clusters`
    COMPREPLY=(`compgen -W "${groups}" -- $2`)
    return 0
}
complete -o nospace -F _cluster_info cluster_info
