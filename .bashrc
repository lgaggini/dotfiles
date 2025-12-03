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

# default fallback PS1 before git bash prompt
PS1="${magenta}[\t] ${bred}\w\n${bcyan}> \[\e[0m\]"

#
# path
#
[[ -d ~/bin ]] && export PATH=~/bin:$PATH   # local binaries & scripts
export PATH=$PATH:/usr/lib/surfraw          # surfraw addition

#
# app env variables
#
export MAIL=~/mail/INBOX
export LANG=it_IT.utf8
export EDITOR=/usr/bin/nvim
export VISUAL=$EDITOR
export PAGER=/usr/bin/less
export GTK2_RC_FILES="$HOME/.gtkrc-2.0"
if [ -n "$DISPLAY" ]; then
    BROWSER=/usr/bin/firefox
else
    BROWSER=/usr/bin/w3m
fi
export BROWSER
[[ -x /usr/bin/lesspipe ]] && eval "$(SHELL=/bin/sh lesspipe)"  # less more friendly for non-text
export DESKTOP_SESSION=gnome
export WORKON_HOME=~/.virtualenvs
source /usr/bin/virtualenvwrapper_lazy.sh
export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
export PYENV_VIRTUALENVWRAPPER_PREFER_PYVENV="true"
pyenv virtualenvwrapper_lazy

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
# history
#
export HISTSIZE=50000                           # Increase bash history size
export HISTTIMEFORMAT="%y-%m-%d %T "            # History date and time
export HISTCONTROL=ignoreboth                   # ingore space and duplicates in history
export PROMPT_COMMAND='history -a; history -r'  # save command after it has been executed
export HISTIGNORE="&:[ ]*:ls:ls -a:cd:cd .."    # leave commands out of history log

#
# colors
#
[ -f ~/.dir_colors ] && eval $(dircolors -b ~/.dir_colors)  # custom file colors

#
# alias and function from external
#
[ -f ~/.bash_aliases ] && source ~/.bash_aliases          # aliases
[ -f ~/.bash_functions ] && source ~/.bash_functions      # functions


# K8S
source <(kubectl completion bash)
[ -f /usr/bin/switch.sh ] && source /usr/bin/switch.sh
[ -f /opt/kube-ps1/kube-ps1.sh ] && source /opt/kube-ps1/kube-ps1.sh
KUBE_PS1_SYMBOL_COLOR=green
KUBE_PS1_CTX_COLOR=yellow
KUBE_PS1_NS_COLOR=green
KUBE_PS1_BG_COLOR=black

#https://github.com/magicmonty/bash-git-prompt/issues/467
function prompt_callback() {
  echo -n " $(kube_ps1) ${bred}\w"
}

# GIT prompt
GIT_PROMPT_START_USER="[_LAST_COMMAND_INDICATOR_] ${magenta}[\t]"
GIT_PROMPT_END_USER="\n${bcyan}> \[\e[0m\]"
[ -f ~/.bash-git-prompt/gitprompt.sh ] && source ~/.bash-git-prompt/gitprompt.sh    # git prompt

# Smarter cd command
[ -f ~/.zoxide ] && source ~/.zoxide  # local functions

# Fuzzy finder completion and key bindings
source /usr/share/fzf/completion.bash
source /usr/share/fzf/key-bindings.bash
# CTRL-G - cd into the selected directory
bind '"\C-g": " \C-e\C-u`__fzf_cd__`\e\C-e\er\C-m"'
# custom colors
export FZF_DEFAULT_OPTS="
--preview '([[ -f {} ]] && (bat --theme=base16-256 --style=numbers --color=always {} || cat {})) || ([[ -d {} ]] && (tree -C {} | less)) || echo {} 2> /dev/null | head -200'
--color fg:-1,bg:-1,hl:230,fg+:3,bg+:233,hl+:229
--color info:150,prompt:110,spinner:150,pointer:167,marker:174
--height=20"
# custom fzf behaviour
export FZF_COMPLETION_TRIGGER='**'
_fzf_complete_ssh_notrigger() {
    FZF_COMPLETION_TRIGGER='' _fzf_host_completion
}
complete -o bashdefault -o default -F _fzf_complete_ssh_notrigger ssh
_fzf_complete_kill_notrigger() {
    FZF_COMPLETION_TRIGGER='' _fzf_proc_completion
}
complete -o bashdefault -o default -F _fzf_complete_kill_notrigger kill

#
# machine specific configuration
#
[ -f ~/.bashrc_local ] && source ~/.bashrc_local                  # local config
[ -f ~/.bash_aliases_desktop ] && source ~/.bash_aliases_desktop  # desktop/gui aliases
[ -f ~/.bash_aliases_local ] && source ~/.bash_aliases_local      # local aliases
[ -f ~/.bash_functions_desktop ] && source ~/.bash_functions_desktop  # local functions
[ -f ~/.bash_functions_local ] && source ~/.bash_functions_local  # local functions

# term title with command:
# http://mg.pov.lt/blog/bash-prompt.html
case ${TERM} in
  xterm*|rxvt*|Eterm|aterm|kterm|gnome|screen-256color-bce|screen-256color)
    # PROMPT_COMMAND=${PROMPT_COMMAND:+$PROMPT_COMMAND; }'printf "\033]0;%s@%s:%s\007" "${USER}" "${HOSTNAME%%.*}" "${PWD/$HOME/\~}"'
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
                SANITIZED_COMMAND=${BASH_COMMAND/TERM=rxvt ssh /}
                # titlebar
                echo -ne "\033]0;${USER}@${HOSTNAME}:${PWD/$HOME/\~} ${SANITIZED_COMMAND}\007"
                # screen / tmux tab
                if [ "$TERM" == 'screen-256color-bce' ] || [ "$TERM" == 'screen-256color' ]; then
                    printf $'\ek%s\e\\' "${SANITIZED_COMMAND/setGitPrompt/bash}";
                fi
                ;;
        esac
    }
    trap show_command_in_title_bar DEBUG
    ;;
esac

#
# welcome messages and goodies
#
fortune -as

#
# check if the ssh keys is unlocked
#
ssh-add -l > /dev/null || ssh-add
