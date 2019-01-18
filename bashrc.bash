# If not running interactively, don't do anything
[[ "$-" != *i* ]] && return

USE_GIT_PROMPT=comment_me_out_if_not_wanted

# Prune bash_history: remove lines starting with space, remove dulpicates
# Keep a backup before manipulating just in case (if .bash_history > 100 bytes)
prune_history ()
{
sync
if (( $(stat -c%s ~/.bash_history) > 100 )); then
    cp ~/.bash_history ~/.bash_history_backup;
# Otherwise restore bash_history if there's a backup
else
    echo "Warning, no history"
    if ! [ -s ~/.bash_history ]; then
        cp ~/.bash_history_backup ~/.bash_history
    fi
fi
# Remove lines starting with space
if [ -s ~/.bash_history ]; then
    grep "^[^ ]" ~/.bash_history > ~/.bash_historytmp
# Remove duplicate lines, keep most recent
    tac ~/.bash_historytmp | awk '!seen[$0]++' | tac  > ~/.bash_history;
    rm ~/.bash_historytmp
fi
sync
}
# Run function with flock to prevent corruption
{ flock -n 19 || echo "History locked, waiting..."; } 19>.lock
{ flock 19 || echo "Failed"; prune_history; } 19>/tmp/.lock

# Import local environment settings
[[ -f ~/.local.bash ]] && . ~/.local.bash

# Shell Options
#
# See man bash for more options...
#
# Don't wait for job termination notification
# set -o notify
#
# Don't use ^D to exit
# set -o ignoreeof
#
# Use case-insensitive filename globbing
# shopt -s nocaseglob
#
# When changing directory small typos can be ignored by bash
# for example, cd /vr/lgo/apaache would find /var/log/apache
shopt -s cdspell

# Check windows size to prevent wrapping problems
shopt -s checkwinsize

# Completion options
#
# These completion tuning parameters change the default behavior of bash_completion:
#
# Define to access remotely checked-out files over passwordless ssh for CVS
# COMP_CVS_REMOTE=1
#
# Define to avoid stripping description in --option=description of './configure --help'
# COMP_CONFIGURE_HINTS=1
#
# Define to avoid flattening internal contents of tar files
# COMP_TAR_INTERNAL_PATHS=1
#
# Uncomment to turn on programmable completion enhancements.
# Any completions you add in ~/.bash_completion are sourced last.
[[ -f  ~/homedir/bash-completion/share/bash-completion/bash_completion ]] && .  ~/homedir/bash-completion/share/bash-completion/bash_completion

# Use the git completion script provided with git
[[ -f  ~/homedir/bash-completion/git-completion.bash ]] && source ~/homedir/bash-completion/git-completion.bash

if [ -n "${USE_GIT_PROMPT}" ]; then
  # Use the git prompt script provided with git
  # Options to change how the git prompt displays things
  GIT_PS1_SHOWDIRTYSTATE=1 #show * for unstaged and + for staged changes
  GIT_PS1_SHOWSTASHSTATE=1 #show $ if stash exists
  #GIT_PS1_SHOWUNTRACKEDFILES=1 #show % is there are untracked files
  #GIT_PS1_SHOWUPSTREAM="auto" #'auto' or 'verbose' print if HEAD and origin are off
  #GIT_PS1_STATESEPARATOR=SP  #if not SP will change character between fields
  GIT_PS1_SHOWCOLORHINTS=1 #show colors on state
  #GIT_PS1_HIDE_IF_PWD_IGNORED=1 #don't show git prompt if in untracked directory
  [[ -f ~/homedir/git-prompt.sh ]] && . ~/homedir/git-prompt.sh
fi

# History Options
#
# Don't put duplicate lines in the history.
# export HISTCONTROL=$HISTCONTROL${HISTCONTROL+,}ignoredups
#
# Ignore some controlling instructions
# HISTIGNORE is a colon-delimited list of patterns which should be excluded.
# The '&' is a special pattern which suppresses duplicate entries.
# export HISTIGNORE=$'[ \t]*:&:[fb]g:exit'
# export HISTIGNORE=$'[ \t]*:&:[fb]g:exit:ls' # Ignore the ls command as well
#
# Whenever displaying the prompt, write the previous line to disk
# export PROMPT_COMMAND="history -a"

# Aliases
#
# Some people use a different file for aliases
# if [ -f "${HOME}/.bash_aliases" ]; then
#   source "${HOME}/.bash_aliases"
# fi
#
# Some example alias instructions
# If these are enabled they will be used instead of any instructions
# they may mask.  For example, alias rm='rm -i' will mask the rm
# application.  To override the alias instruction use a \ before, ie
# \rm will call the real rm not the alias.
#
# Interactive operation...
# alias rm='rm -i'
# alias cp='cp -i'
# alias mv='mv -i'
#
# Default to human readable figures
# alias df='df -h'
# alias du='du -h'
#
# Misc :)
alias whence='type -a'                        # where, of a sort

#export LANG=en_US
alias more='less'
alias copy='cp'
alias move='mv'

#Clear screen and scroll-back buffer
alias cls="echo -ne '\033c'"

# Preserve path on sudo
alias sudo='sudo env "PATH=$PATH"'

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    eval "`dircolors -b`"
    alias ls='ls --color=auto'
    alias dir='ls --color=auto --format=single-column'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
    alias xgrep='xargs grep --color=auto'
fi

# Umask
#
# /etc/profile sets 022, removing write perms to group + others.
# Set a more restrictive umask: i.e. no exec perms for others:
# umask 027
# Paranoid: neither group nor others have any perms:
# umask 077

# Functions
#
# Some people use a different file for functions
# if [ -f "${HOME}/.bash_functions" ]; then
#   source "${HOME}/.bash_functions"
# fi
#
# Some example functions:
#
# a) function settitle
# settitle ()
# {
#   echo -ne "\e]2;$@\a\e]1;$@\a";
# }
#
# b) function cd_func
# This function defines a 'cd' replacement function capable of keeping,
# displaying and accessing history of visited directories, up to 10 entries.
# To use it, uncomment it, source this file and try 'cd --'.
# acd_func 1.0.5, 10-nov-2004
# Petar Marinov, http:/geocities.com/h2428, this is public domain
cd_func ()
{
  local x2 the_new_dir adir index
  local -i cnt

  if [[ $1 ==  "--" ]]; then
    dirs -v
    return 0
  fi

  the_new_dir=$1
  [[ -z $1 ]] && the_new_dir=$HOME

  if [[ ${the_new_dir:0:1} == '-' ]]; then
    #
    # Extract dir N from dirs
    index=${the_new_dir:1}
    [[ -z $index ]] && index=1
    adir=$(dirs +$index)
    [[ -z $adir ]] && return 1
    the_new_dir=$adir
  fi

  #
  # '~' has to be substituted by ${HOME}
  [[ ${the_new_dir:0:1} == '~' ]] && the_new_dir="${HOME}${the_new_dir:1}"

  #
  # Now change to the new dir and add to the top of the stack
  pushd "${the_new_dir}" > /dev/null
  [[ $? -ne 0 ]] && return 1
  the_new_dir=$(pwd)

  #
  # Trim down everything beyond 11th entry
  popd -n +11 2>/dev/null 1>/dev/null

  #
  # Remove any other occurence of this dir, skipping the top of the stack
  for ((cnt=1; cnt <= 10; cnt++)); do
    x2=$(dirs +${cnt} 2>/dev/null)
    [[ $? -ne 0 ]] && return 0
    [[ ${x2:0:1} == '~' ]] && x2="${HOME}${x2:1}"
    if [[ "${x2}" == "${the_new_dir}" ]]; then
      popd -n +$cnt 2>/dev/null 1>/dev/null
      cnt=cnt-1
    fi
  done

  return 0
}

alias cd=cd_func
alias d='dirs -v'

# make autocomplete case insensitive
#if [[ $- =~ "i" ]] checks for interactive session. Don't echo if scp
bind "set completion-ignore-case on"


# set history preferences
# append to the history file, don't overwrite it
shopt -s histappend
PROMPT_COMMAND=`history -a`
# don't put duplicate lines in the history. See bash(1) for more options
# don't overwrite GNU Midnight Commander's setting of `ignorespace'.
export HISTCONTROL=$HISTCONTROL${HISTCONTROL+:}ignoredups:erasedups
# ... or force ignoredups and ignorespace
#export HISTCONTROL=ignoreboth
export HISTIGNORE=$'&: [fb]g:[fb]g:exit'
export HISTSIZE=false
#export GREP_OPTIONS=--color=auto

# Set prompt format
function proml {
local       BLUE="\[\033[0;34m\]"
local      GREEN="\[\033[0;32m\]"
local        RED="\[\033[0;31m\]"
local       CYAN="\[\033[1;36m\]"
local     YELLOW="\[\033[0;33m\]"
local  LIGHT_RED="\[\033[1;31m\]"
local      WHITE="\[\033[1;37m\]"
local      BLACK="\[\033[37;0;30m\]"
local LIGHT_GRAY_BLUE="\[\033[1;47;1;34m\]"
local GREY_ON_BLACK="\[\033[1;40;0;37m\]"
local WHITE_ON_BLACK="\[\033[1;40;1;37m\]"
local       CYAN_ON_BLACK="\[\033[1;40;1;36m\]"
local     YELLOW_ON_BLACK="\[\033[1;40;1;33m\]"
local NO_COLOR="\[\033[0m\]"
case $TERM in
    xterm*)
        TITLEBAR='\[\033]0;\u@\h:\w\007\]'
        ;;
    *)
        TITLEBAR=""
        ;;
esac

PS1="${TITLEBAR}\
$LIGHT_GRAY_BLUE\D{%b%d %H:%M}$NO_COLOR\
$CYAN_ON_BLACK \h $YELLOW_ON_BLACK\w$NO_COLOR\
\n$WHITE_ON_BLACK: "
PS2='> '
PS4='+ '
# Now append a reset color when pushing 'Enter'
trap 'printf "\e[0m" "$_"' DEBUG

if [ -n "${USE_GIT_PROMPT}" ]; then
PROMPT_COMMAND='__git_ps1  "${TITLEBAR}\
$LIGHT_GRAY_BLUE\D{%b%d %H:%M}$NO_COLOR\
$CYAN_ON_BLACK \h $YELLOW_ON_BLACK\w$NO_COLOR" "\
\n$WHITE_ON_BLACK: "'
# The variables don't survive to the shell, so put in the non-readable ones
PROMPT_COMMAND='__git_ps1  "${TITLEBAR}\
\[\033[1;47;1;34m\]\D{%b%d %H:%M}\[\033[0m\]\
\[\033[1;40;1;36m\] \h \[\033[1;40;1;33m\]\w\[\033[0m\]" "\
\n\[\033[1;40;1;37m\]: "'
fi

}
proml

export PATH=$PATH:/sbin:/usr/sbin
export PATH=~/homedir/scripts:$PATH

# Python startup script to load useful things
export PYTHONSTARTUP=~/homedir/scripts/pystart.py
