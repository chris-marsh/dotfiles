#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

. ~/.shell/aliases.sh
. ~/.shell/functions.sh

export EDITOR=vim
export PATH=$PATH:~/.dotfiles/bin:.

[ -r /usr/share/bash-completion/bash_completion   ] && . /usr/share/bash-completion/bash_completion

RESET="\[\033[0m\]"
GREEN="\[\033[01;32m\]"
BLUE="\[\033[01;34m\]"
YELLOW="\[\033[0;33m\]"
 
function parse_git_branch {
  PS_BRANCH=''
  if [ -d .svn ]; then
    PS_BRANCH="(svn r$(svn info|awk '/Revision/{print $2}'))"
    return
  elif [ -f _FOSSIL_ -o -f .fslckout ]; then
    PS_BRANCH="(fossil $(fossil status|awk '/tags/{print $2}')) "
    return
  fi  
  ref=$(git symbolic-ref HEAD 2> /dev/null) || return
  PS_BRANCH="(git ${ref#refs/heads/}) "
}

PROMPT_COMMAND=parse_git_branch

PS_INFO="$GREEN(\u$YELLOW@$GREEN\h) $BLUE(\w)"
PS_GIT="$YELLOW\$PS_BRANCH"
PS_TIME="$YELLOW(\t) "
export PS1="\n${PS_INFO} ${PS_GIT}\n${RESET}$ "

# source ~/.shell/power_ps1_256col.sh
source ~/.shell/power_ps1_16col.sh

if [ "$TERM" = "xterm" -o "$TERM" = "rxvt-unicode-256color" ]; then
    export TERM=xterm-256color
fi

archey3
