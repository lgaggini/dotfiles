#!/bin/bash
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
# path
#
[[ -d ~/bin ]] && export PATH=~/bin:$PATH           # local binaries & scripts
[[ -d /snap/bin ]] && export PATH=/snap/bin:$PATH   # snapd binaries & scripts
# export PATH=$PATH:/usr/lib/surfraw                # surfraw addition

#
# app env variables
#
export EDITOR=/usr/bin/nvim
export VISUAL=$EDITOR
export PAGER=/usr/bin/bat
export GTK2_RC_FILES="$HOME/.gtkrc-2.0"
if [ -n "$DISPLAY" ]; then
    BROWSER=/usr/bin/firefox
else
    BROWSER=/usr/bin/w3m
fi
export BROWSER
export DESKTOP_SESSION=gnome

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
# bash history
#
export HISTSIZE=50000                           # increase bash history size
export HISTTIMEFORMAT="%y-%m-%d %T "            # history date and time
export HISTCONTROL=ignoreboth                   # ignore space and duplicates in history
export PROMPT_COMMAND='history -a; history -r'  # save command after it has been executed
export HISTIGNORE="&:[ ]*:ls:ls -a:cd:cd .."    # leave commands out of history log

#
# aliases and functions from external
#
ALIAS_FILE=~/.aliases
FUNCTIONS_FILE=~/.functions
[ -f "${ALIAS_FILE}" ] && source "${ALIAS_FILE}"
[ -f "${FUNCTIONS_FILE}" ] && source "${FUNCTIONS_FILE}"

#
# Prompt
#
eval "$(starship init bash)"

#
# Extensions
#

# Smarter cd command
eval "$(zoxide init --cmd cd bash)"

# Fuzzy finder
source /usr/share/fzf/shell/completion.bash
source /usr/share/fzf/shell/key-bindings.bash
export FZF_COMPLETION_TRIGGER='**'
# theme
export FZF_DEFAULT_OPTS='
  --color fg:242,hl:65,fg+:15,hl+:108
  --color info:108,prompt:109,spinner:108,pointer:168,marker:168
'
# CTRL-G - cd into the selected directory
bind '"\C-g": "\ec"'
# ssh host completion
_fzf_complete_ssh_notrigger() {
   FZF_COMPLETION_TRIGGER='' _fzf_host_completion
}
complete -o bashdefault -o default -F _fzf_complete_ssh_notrigger ssh
# kill process completion
_fzf_complete_kill_notrigger() {
    FZF_COMPLETION_TRIGGER='' _fzf_proc_completion
}
complete -o bashdefault -o default -F _fzf_complete_kill_notrigger kill

# Python dev
export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init - bash)"
eval "$(pyenv virtualenv-init -)"

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
            REMOTE="ssh"
            # remote host
            if [[ "$BASH_COMMAND" == *"$REMOTE"* ]]; then
                # get remote host for ssh
                REMOTE_HOST=${BASH_COMMAND/"${REMOTE}" *(-[a-zA-Z])/}
                # strip domain part from hostnames, leave untouched ip addresses
                ipv4='\b((25[0-5]|2[0-4][0-9]|1[0-9]{2}|[1-9][0-9]|[0-9])\.){3}(25[0-5]|2[0-4][0-9]|1[0-9]{2}|[1-9][0-9]|[0-9])\b'
                if ! [[ $REMOTE_HOST =~ $ipv4 ]]; then
                  TITLE="${REMOTE_HOST%%.*}"
                else
                  TITLE="${REMOTE_HOST}"
                fi

            # localhost proper command
            elif [[ "$BASH_COMMAND" != +(__zoxide_hook|starship_precmd|_pyenv_virtualenv_hook) ]]; then
                TITLE="${BASH_COMMAND}"

            # localhost no proper command, use the short path
            else
                MAX_PATH_DEPTH=2
                CURRENT_PATH="${PWD/$HOME/\~}"
                IFS='/' read -ra REL_PATH <<< "${CURRENT_PATH}"
                PATH_DEPTH=$(( MAX_PATH_DEPTH > ${#REL_PATH[*]}-1 ? ${#REL_PATH[*]}-1 : MAX_PATH_DEPTH ))
                SHORT_PATH=$(IFS='/'; printf '%s' "${REL_PATH[*]: -${PATH_DEPTH}}"; IFS='')
                TITLE=$SHORT_PATH
            fi

            # finally set the titlebar
            echo -ne "\033]0;${TITLE}\007"
    esac
}
trap show_command_in_title_bar DEBUG

#
# machine specific configuration
#

# local
BASHRC_LOCAL_FILE=~/.bashrc_local
ALIASES_LOCAL_FILE=~/.aliases_local
FUNCTIONS_LOCAL_FILE=~/.functions_local
[ -f "${BASHRC_LOCAL_FILE}" ] && source "${BASHRC_LOCAL_FILE}"        # local bashrc
[ -f "${ALIASES_LOCAL_FILE}" ] && source "${ALIASES_LOCAL_FILE}"      # local aliases
[ -f "${FUNCTIONS_LOCAL_FILE}" ] && source "${FUNCTIONS_LOCAL_FILE}"  # local functions
