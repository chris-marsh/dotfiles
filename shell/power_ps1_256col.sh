#!/bin/bash

# Based on https://github.com/abhijitvalluri/bash-powerline-shell

function ps1_powerline {
  RETCODE=$? # save return code
  NUM_JOBS=$(jobs -p | wc -l)
  ref=$(git symbolic-ref HEAD 2> /dev/null)
  if [ -z "$ref" ]; then
    GIT_BRANCH=""
  else
    GIT_BRANCH="${ref#refs/heads/}"
  fi

  local GREY="\[\e[48;5;240m\]\[\e[38;5;250m\]"
  local GREY_END="\[\e[48;5;27m\]\[\e[38;5;240m\]"

  local ORANGE="\[\e[48;5;208m\]\[\e[38;5;255m\]"
  local ORANGE_END="\[\e[48;5;236m\]\[\e[38;5;208m\]"
  local ORANGE_RET_END="\[\e[48;5;160m\]\[\e[38;5;208m\]" # when next segment is prompt with return code

  local BLUE="\[\e[48;5;27m\]\[\e[38;5;255m\]"
  local BLUE_END="\[\e[48;5;208m\]\[\e[38;5;27m\]"           # when next segment is git
  local BLUE_END_JOBS="\[\e[48;5;93m\]\[\e[38;5;27m\]"       # when next segment is jobs
  local BLUE_END_ALT="\[\e[48;5;236m\]\[\e[38;5;27m\]"       # when next segment is prompt
  local BLUE_END_RET="\[\e[48;5;160m\]\[\e[38;5;27m\]"       # when next segment is prompt with return code

  local JOBS="\[\e[48;5;93m\]\[\e[38;5;255m\] ⏎"
  local JOBS_END="\[\e[48;5;236m\]\[\e[38;5;93m\]"           # when next segment is prompt
  local JOBS_NO_RET_END="\[\e[48;5;208m\]\[\e[38;5;93m\]"    # when next segment is git
  local JOBS_NO_GIT_END="\[\e[48;5;160m\]\[\e[38;5;93m\]"    # when next segment is prompt with return code

  local RET="\[\e[48;5;160m\]\[\e[38;5;255m\]"
  local RET_END="\[\e[0m\]\[\e[38;5;160m\]\[\e[0m\] "

  local PROMPT="\[\e[48;5;236m\]\[\e[38;5;255m\]"
  local PROMPT_END="\[\e[0m\]\[\e[38;5;236m\]\[\e[0m\] "

  if [ ! -w "$PWD" ]; then
    # Current directory is not writable
    BLUE_END="\[\e[48;5;160m\]\[\e[38;5;27m\]\[\e[38;5;255m\]  \[\e[48;5;208m\]\[\e[38;5;160m\]"
    BLUE_END_JOBS="\[\e[48;5;160m\]\[\e[38;5;27m\]\[\e[38;5;255m\]  \[\e[48;5;93m\]\[\e[38;5;160m\]"
    BLUE_END_ALT="\[\e[48;5;160m\]\[\e[38;5;27m\]\[\e[38;5;255m\]  \[\e[48;5;236m\]\[\e[38;5;160m\]"
    BLUE_END_RET="\[\e[48;5;160m\]\[\e[38;5;27m\]\[\e[38;5;255m\]  "
  fi

  if [ -z "$GIT_BRANCH" ]; then
    # Is not a git repo
    if [ "$RETCODE" -eq 0 ]; then
      if [ "$NUM_JOBS" -eq 0 ]; then
        # No jobs or ret code
        PS1="$GREY \u@\h $GREY_END$BLUE \W $BLUE_END_ALT$PROMPT \$ $PROMPT_END"
      else
        # no ret code but jobs
        PS1="$GREY \u@\h $GREY_END$BLUE \W $BLUE_END_JOBS$JOBS$NUM_JOBS $JOBS_END$PROMPT \$ $PROMPT_END"
      fi
    else
      if [ "$NUM_JOBS" -eq 0 ]; then
        # No jobs but ret code is there
        PS1="$GREY \u@\h $GREY_END$BLUE \W $BLUE_END_RET$RET \$ ⚑ $RETCODE $RET_END"
      else
        # Both jobs and ret code
        PS1="$GREY \u@\h $GREY_END$BLUE \W $BLUE_END_JOBS$JOBS$NUM_JOBS $JOBS_NO_GIT_END$RET \$ ⚑ $RETCODE $RET_END"
      fi
    fi
  else
    # Is a git repo
    local NUM_MODIFIED=$(git diff --name-only --diff-filter=M | wc -l)
    if [ ! "$NUM_MODIFIED" -eq "0" ]; then
        NUM_MODIFIED=" ✚$NUM_MODIFIED"
    else
        NUM_MODIFIED=""
    fi
    local NUM_STAGED=$(git diff --staged --name-only --diff-filter=AM | wc -l)
    if [ ! "$NUM_STAGED" -eq "0" ]; then
        NUM_STAGED=" ✔$NUM_STAGED"
    else
        NUM_STAGED=""
    fi
    local NUM_CONFLICT=$(git diff --name-only --diff-filter=U | wc -l)
    if [ ! "$NUM_CONFLICT" -eq "0" ]; then
        NUM_CONFLICT=" ✘$NUM_CONFLICT"
    else
        NUM_CONFLICT=""
    fi
    local GIT_STATUS="\[\e[38;5;27m\]$NUM_MODIFIED$NUM_STAGED$NUM_CONFLICT "
    if [ "$RETCODE" -eq 0 ]; then
      GIT_STATUS+="\[\e[38;5;208m\]\[\e[48;5;236m\]"
    else
      GIT_STATUS+="\[\e[38;5;208m\]\[\e[48;5;160m\]"
    fi

    if [ "$RETCODE" -eq 0 ]; then
      if [ "$NUM_JOBS" -eq 0 ]; then
        # No jobs or ret code
        PS1="$GREY \u@\h $GREY_END$BLUE \W $BLUE_END$ORANGE  $GIT_BRANCH$GIT_STATUS$PROMPT \$ $PROMPT_END"
      else
        # no ret code but jobs
        PS1="$GREY \u@\h $GREY_END$BLUE \W $BLUE_END_JOBS$JOBS$NUM_JOBS $JOBS_NO_RET_END$ORANGE  $GIT_BRANCH $GIT_STATUS$PROMPT \$ $PROMPT_END"
      fi
    else
      if [ "$NUM_JOBS" -eq 0 ]; then
        # No jobs but ret code is there
        PS1="$GREY \u@\h $GREY_END$BLUE \W $BLUE_END$ORANGE  $GIT_BRANCH$GIT_STATUS$RET \$ ⚑ $RETCODE $RET_END"
      else
        # Both jobs and ret code
        PS1="$GREY \u@\h $GREY_END$BLUE \W $BLUE_END_JOBS$JOBS$NUM_JOBS $JOBS_NO_RET_END$ORANGE  $GIT_BRANCH$GIT_STATUS$RET \$ ⚑ $RETCODE $RET_END"
      fi
    fi

  fi
}

if [  "$TERM" != "linux" ]; then
   PROMPT_COMMAND="ps1_powerline; $PROMPT_COMMAND"
fi
