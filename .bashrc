#!/bin/sh
#---------------------------
#--        .bashrc        --
#--      by lgaggini      --
#--      CC BY-SA 3.0     --
#---------------------------

#
# if not running interactively, don't do anything
#
[[ $- != *i* ]] && return

#
# prompt
#
red="\[\e[0;31m\]"          # red
green="\[\e[0;32m\]"        # green
yellow="\[\e[0;33m\]"       # yellow
blue="\[\e[0;34m\]"         # blue
magenta="\[\e[0;35m\]"      # magenta
cyan="\[\e[0;36m\]"         # cyan
white="\[\e[0;37m\]"        # white

bred="\[\e[1;31m\]"         # bold red
bgreen="\[\e[1;32m\]"       # bold green
byellow="\[\e[1;33m\]"      # bold yellow
bblue="\[\e[1;34m\]"        # bold blue
bmagenta="\[\e[1;35m\]"     # bold magenta
bcyan="\[\e[1;36m\]"        # bold cyan
bwhite="\[\e[1;37m\]"       # bold white

if [ `id -u` -eq "0" ]; then
  root="${yellow}"
else
  root="${red}"
fi

PS1="${red}[${root}\u${green}@\[\e[0;96m\]\h${red}][${green}\w${red}]\n${red}└─╼ \[\e[0m\]"

#
# path
#
[[ -d ~/bin ]] && export PATH=~/bin:$PATH   # local binaries & scripts
export PATH=$PATH:/usr/lib/surfraw          # surfraw addition

#
# app env variables
#
export LANG=it_IT.utf8
export EDITOR=/usr/bin/vim
export VISUAL=$EDITOR
export PAGER=/usr/bin/less
export GTK2_RC_FILES="$HOME/.gtkrc-2.0"
if [ -n "$DISPLAY" ]; then
    BROWSER=/usr/bin/chromium
else
    BROWSER=/usr/bin/links
fi
export BROWSER
[[ -x /usr/bin/lesspipe ]] && eval "$(SHELL=/bin/sh lesspipe)"  # less more friendly for non-text

#
# bash options
#
shopt -s checkwinsize               # updates values of LINES and COLUMNS 
shopt -s nocaseglob                 # case-insensitive pathname expansion
shopt -s autocd                     # enter directory without cd
shopt -s cdspell                    # correct minor errors in directory names with cd
shopt -s dirspell                   # attempt spelling correction on directory names in completion
shopt -s dotglob                    # includes filenames beginning with a `.' in filename expansion
shopt -s histappend                 # append to history file, instead of overwriting it
shopt -s nocaseglob                 # matches filenames in a case-insensitive fashion in filename expansion
shopt -s no_empty_cmd_completion    # not attempt to search for possible completions on an empty line.
shopt -s globstar                   # recursive globbing with **
shopt -s expand_aliases             # expand aliases    
shopt -s cmdhist                    # save all lines of a multiline command in same entry
shopt -s lithist                    # save all lines of a multiline command in same entry
stty -ixon                          # disable ^S/^Q flow control 

#
# hystory
#
export HISTSIZE=5000                            # Increase bash history size
export HISTCONTROL=ignoreboth                   # ingore space and duplicates in history
export PROMPT_COMMAND='history -a'              # save command after it has been executed
export HISTIGNORE="&:[ ]*:ls:ls -a:cd:cd .."    # leave commands out of history log

#
# colors
#
alias ls='ls --color=auto'                                  # ls colored output
[ -f ~/.dir_colors ] && eval $(dircolors -b ~/.dir_colors)  # custom file colors
export GREP_COLOR="1;36"                                    # grep colored ouput
alias grep='grep --color=auto'                              # grep colored ouput
export LESS="-R"                                            # less colored output
export LESS_TERMCAP_mb=$'\E[01;31m'                         # begin blinking
export LESS_TERMCAP_md=$'\E[01;38;5;74m'                    # begin bold
export LESS_TERMCAP_me=$'\E[0m'                             # end mode
export LESS_TERMCAP_se=$'\E[0m'                             # end standout-mode
export LESS_TERMCAP_so=$'\E[38;5;246m'                      # begin standout-mode - info box
export LESS_TERMCAP_ue=$'\E[0m'                             # end underline
export LESS_TERMCAP_us=$'\E[04;38;5;146m'                   # begin underline

#
# alias and function from external
#
[ -f ~/.bash_aliases ] && source ~/.bash_aliases          # aliases
[ -f ~/.bash_functions ] && source ~/.bash_functions      # functions
GIT_PROMPT_START="${red}[${root}\u${green}@\[\e[0;96m\]\h${red}][${green}\w${red}]"
GIT_PROMPT_END="\n${red}└─╼ \[\e[0m\]"
[ -f ~/.bash-git-prompt/gitprompt.sh ] && source ~/.bash-git-prompt/gitprompt.sh    # git prompt

#
# machine specific configuration
#
[ -f ~/.bashrc_local ] && source ~/.bashrc_local                  # local config
[ -f ~/.bash_aliases_local ] && source ~/.bash_aliases_local      # local aliases
[ -f ~/.bash_functions_local ] && source ~/.bash_functions_local  # local functions

# term title with command:
# http://mg.pov.lt/blog/bash-prompt.html
case ${TERM} in
  xterm*|rxvt*|Eterm|aterm|kterm|gnome)
    PROMPT_COMMAND=${PROMPT_COMMAND:+$PROMPT_COMMAND; }'printf "\033]0;%s@%s:%s\007" "${USER}" "${HOSTNAME%%.*}" "${PWD/#$HOME/~}"'
    # Show the currently running command in the terminal title:
    # http://www.davidpashley.com/articles/xterm-titles-with-bash.html
    show_command_in_title_bar()
    {
        case "$BASH_COMMAND" in
            *\033]0*)
                # The command is trying to set the title bar as well;
                # this is most likely the execution of $PROMPT_COMMAND.
                # In any case nested escapes confuse the terminal, so don't
                # output them.
                ;;
            *)
                echo -ne "\033]0;${USER}@${HOSTNAME}:${PWD/#$HOME/~} ${BASH_COMMAND}\007"
                ;;
        esac
    }
    trap show_command_in_title_bar DEBUG
    ;;
esac

#
# welcome messages and goodies
#
fortune -s
