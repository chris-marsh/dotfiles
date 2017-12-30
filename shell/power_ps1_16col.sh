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

    local HOST_BG="Yellow"
    local HOST_FG="Black"
    local PATH_BG="Blue"
    local PATH_FG="Black"
    local PATH_RO_BG="Red"
    local PATH_RO_FG="Black"
    local JOBS_BG="Purple"
    local JOBS_FG="Black"
    local GIT_BG="Green"
    local GIT_FG="Black"
    local PROMPT_BG="IBlack"
    local PROMPT_FG="White"
    local RET_BG="Red"
    local RET_FG="Black"

    local HOST_START="${colors[$HOST_FG]}${colors[On_$HOST_BG]} \u@\h"
    local HOST_END="${colors[$HOST_BG]}${colors[On_$PATH_BG]}"

    local PATH_START="${colors[$PATH_FG]}${colors[On_$PATH_BG]} \W"
    if [ -w "$PWD" ]; then
        # Current directory is writeable
        local PATH_END="${colors[$PATH_BG]}${colors[On_$GIT_BG]}"            # next segment is git
        local PATH_END_JOBS="${colors[$PATH_BG]}${colors[On_$JOBS_BG]}"      # next segment is jobs
        local PATH_END_ALT="${colors[$PATH_BG]}${colors[On_$PROMPT_BG]}"     # next segment is prompt
        local PATH_END_RET="${colors[$PATH_BG]}${colors[On_$RET_BG]}"        # next segment is prompt with return code
    else
        # Current directory is not writable
        PATH_END="${colors[$PATH_BG]}${colors[On_$PATH_RO_BG]}"
        PATH_END+="${colors[$PATH_RO_FG]}${colors[On_$PATH_RO_BG]}  ${colors[$PATH_RO_BG]}${colors[On_$PROMPT_BG]}"

        PATH_END_JOBS="${colors[$PATH_BG]}${colors[On_$PATH_RO_BG]}"
        PATH_END_JOBS+="${colors[$PATH_RO_FG]}${colors[On_$PATH_RO_BG]}  ${colors[$PATH_RO_BG]}${colors[On_$JOBS_BG]}"

        PATH_END_ALT="${colors[$PATH_BG]}${colors[On_$PATH_RO_BG]}"
        PATH_END_ALT+="${colors[$PATH_RO_FG]}${colors[On_$PATH_RO_BG]}  ${colors[$PATH_RO_BG]}${colors[On_$PROMPT_BG]}"

        PATH_END_RET="${colors[$PATH_BG]}${colors[On_$PATH_RO_BG]}"
        PATH_END_RET+="${colors[$PATH_RO_FG]}${colors[On_$PATH_RO_BG]}  "
    fi

    local JOBS="${colors[$JOBS_FG]}${colors[On_JOBS_BG]} ⏎"
    local JOBS_END="${colors[JOBS_BG]}${colors[On_$PROMPT_BG]}"          # next segment is prompt
    local JOBS_NO_RET_END="${colors[JOBS_BG]}${colors[On_$GIT_BG]}"      # next segment is git
    local JOBS_NO_GIT_END="${colors[JOBS_BG]}${colors[On_$RET_BG]}"      # next segment is prompt with return code

    local GIT_START="${colors[$GIT_FG]}${colors[On_$GIT_BG]} "
    local GIT_END="${colors[$GIT_BG]}${colors[On_$PROMPT_BG]}"           # next segment is prompt
    local GIT_END_RET="${colors[$GIT_BG]}${colors[On_$RET_BG]}"          # next segment is prompt with return code

    local RET="${colors[$RET_FG]}${colors[On_$RET_BG]}"
    local RET_END="${colors[Color_off]}${colors[$RET_BG]}${colors[Color_Off]}"

    local PROMPT="${colors[$PROMPT_FG]}${colors[On_$PROMPT_BG]}"
    local PROMPT_END="${colors[Color_Off]}${colors[$PROMPT_BG]}${colors[Color_Off]}"

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
