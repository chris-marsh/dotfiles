# Path to your oh-my-zsh installation.
export ZSH=/home/chris/.oh-my-zsh

ZSH_THEME="gnzh"
DISABLE_AUTO_UPDATE="true"
DISABLE_AUTO_TITLE="true"

. ~/.oh-my-zsh/oh-my-zsh.sh
. ~/.shell/functions.sh
. ~/.shell/aliases.sh

export PATH=~/bin:$PATH
export EDITOR=vim

# Hack to fix VTE (sakura/evilvte/etc) terminal colors ...
export TERM=xterm-256color
