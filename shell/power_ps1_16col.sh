#!/bin/bash

# Based on https://github.com/abhijitvalluri/bash-powerline-shell

script_dir="${BASH_SOURCE%/*}"
if [[ ! -d "$script_dir" ]]; then script_dir="$PWD"; fi
source "$script_dir/colors.sh"

function ps1_powerline {
    RETCODE=$? # save return code
    NUM_JOBS=$(jobs -p | wc -l)
    ref=$(git symbolic-ref HEAD 2> /dev/null)
    if [ -z "$ref" ]; then
        GIT_BRANCH=""
    else
        GIT_BRANCH="${ref#refs/heads/}"
    fi

    local HOST_START="${colors[Black]}${colors[On_White]} \u@\h"
    local HOST_END="${colors[White]}${colors[On_Blue]}"

    local GIT_START="${colors[Black]}${colors[On_Yellow]} "
    local GIT_END="${colors[Yellow]}${colors[On_IBlack]}"
    local GIT_END_RET="${colors[Yellow]}${colors[On_Red]}"             # next segment is prompt with return code

    local JOBS="${colors[Black]}${colors[On_Purple]} ⏎"
    local JOBS_END="${colors[Purple]}${colors[On_IBlack]}"             # next segment is prompt
    local JOBS_NO_RET_END="${colors[Purple]}${colors[On_Yellow]}"      # next segment is git
    local JOBS_NO_GIT_END="${colors[Purple]}${colors[On_Red]}"         # next segment is prompt with return code

    local RET="${colors[Black]}${colors[On_Red]}"
    local RET_END="${colors[Color_off]}${colors[Red]}${colors[Color_Off]}"

    local PROMPT="${colors[White]}${colors[On_IBlack]}"
    local PROMPT_END="${colors[Color_Off]}${colors[IBlack]}${colors[Color_Off]}"

    local PATH_START="${colors[Black]}${colors[On_Blue]} \W"

    if [ -w "$PWD" ]; then
        # Current directory is writeable
        local PATH_END="${colors[Blue]}${colors[On_Yellow]}"               # next segment is git
        local PATH_END_JOBS="${colors[Blue]}${colors[On_Purple]}"          # next segment is jobs
        local PATH_END_ALT="${colors[Blue]}${colors[On_IBlack]}"           # next segment is prompt
        local PATH_END_RET="${colors[Blue]}${colors[On_Red]}"              # next segment is prompt with return code
    else
        # Current directory is not writable
        PATH_END="${colors[Blue]}${colors[On_Red]}"
        PATH_END+="${colors[White]}${colors[On_Red]}  ${colors[Red]}${colors[On_IBlack]}"

        PATH_END_JOBS="${colors[Blue]}${colors[On_Red]}"
        PATH_END_JOBS+="${colors[Black]}${colors[On_Red]}  ${colors[Red]}${colors[On_Purple]}"

        PATH_END_ALT="${colors[Blue]}${colors[On_Red]}"
        PATH_END_ALT+="${colors[Black]}${colors[On_Red]}  ${colors[Red]}${colors[On_IBlack]}"

        PATH_END_RET="${colors[Blue]}${colors[On_Red]}"
        PATH_END_RET+="${colors[Black]}${colors[On_Red]}  "
    fi

    PS1="$HOST_START $HOST_END"

    if [ -z "$GIT_BRANCH" ]; then
        # Is not a git repo
        if [ "$RETCODE" -eq 0 ]; then
            if [ "$NUM_JOBS" -eq 0 ]; then
                # No jobs or ret code
                PS1+="$PATH_START $PATH_END_ALT"
                PS1+="$PROMPT \$ $PROMPT_END"
            else
                # no ret code but jobs
                PS1+="$PATH_START $PATH_END_JOBS"
                PS1+="$JOBS$NUM_JOBS $JOBS_END"
                PS1+="$PROMPT \$ $PROMPT_END"
            fi
        else
            if [ "$NUM_JOBS" -eq 0 ]; then
                # No jobs but ret code is there
                PS1+="$PATH_START $PATH_END_RET"
                PS1+="$RET \$ ⚑ $RETCODE $RET_END"
            else
                # Both jobs and ret code
                PS1+="$PATH_START $PATH_END_JOBS"
                PS1+="$JOBS$NUM_JOBS $JOBS_NO_GIT_END"
                PS1+="$RET \$ ⚑ $RETCODE $RET_END"
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
        local GIT_STATUS="$NUM_MODIFIED$NUM_STAGED$NUM_CONFLICT "
        if [ "$RETCODE" -eq 0 ]; then
            GIT_STATUS+=$GIT_END
        else
            GIT_STATUS+=$GIT_RET_END
        fi

        if [ "$RETCODE" -eq 0 ]; then
            if [ "$NUM_JOBS" -eq 0 ]; then
                # No jobs or ret code
                PS1+="$PATH_START $PATH_END"
                PS1+="$GIT_START $GIT_BRANCH$GIT_STATUS"
                PS1+="$PROMPT \$ $PROMPT_END"
            else
                # no ret code but jobs
                PS1+="$PATH_START $PATH_END_JOBS"
                PS1+="$JOBS$NUM_JOBS $JOBS_NO_RET_END"
                PS1+="$GIT_START $GIT_BRANCH $GIT_STATUS"
                PS1+="$PROMPT \$ $PROMPT_END"
            fi
        else
            if [ "$NUM_JOBS" -eq 0 ]; then
                # No jobs but ret code is there
                PS1+="$PATH_START $PATH_END"
                PS1+="$GIT_START $GIT_BRANCH$GIT_STATUS$GIT_END_RET"
                PS1+="$RET \$ ⚑ $RETCODE $RET_END"
            else
                # Both jobs and ret code
                PS1+="$PATH_START $PATH_END_JOBS"
                PS1+="$JOBS$NUM_JOBS $JOBS_NO_RET_END"
                PS1+="$GIT_START $GIT_BRANCH$GIT_STATUS$GIT_END_RET"
                PS1+="$RET \$ ⚑ $RETCODE $RET_END"
            fi
        fi

    fi
}

if [  "$TERM" != "linux" ]; then
    PROMPT_COMMAND="ps1_powerline; $PROMPT_COMMAND"
fi
