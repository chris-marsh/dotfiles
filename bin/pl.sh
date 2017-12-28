#!/bin/bash

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
  echo $PS_BRANCH
}

# Bash provides an environment variable called PROMPT_COMMAND.
# The contents of this variable are executed as a regular Bash
# command just before Bash displays a prompt. 
PROMPT_COMMAND=parse_git_branch
echo $PROMPT_COMMAND

PS_INFO="$GREEN(\u$YELLOW@$GREEN\h) $BLUE(\w)"
PS_GIT="$YELLOW\$PS_BRANCH"
PS_TIME="$YELLOW(\t) "

echo -e "\e[47m\e[30m chris@cruachan \e[0m\e[32m\e[44m\e0\e[30m ~ \e[0m\e[34m\e[0m"
