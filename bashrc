#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

. ~/.shell/aliases.sh
. ~/.shell/functions.sh

export PATH=$PATH:~/.dotfiles/bin:.
export EDITOR=vim

# Custom prompt
PS1="\[$(tput setaf 3)\]\u \[$(tput setaf 6)\][\W] \[$(tput sgr0)\]$ "

# Root prompt in Red
# PS1="\[$(tput setaf 1)\]\u [\w] $ \[$(tput sgr0)\]"

archey3
