#
# Executes commands at the start of an interactive session.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# Customize to your needs...
source ~/.dotfiles/shell/aliases.sh

export PATH=$PATH:~/.dotfiles/bin:.
export EDITOR=vim

if [ "$TERM" = "linux" ]; then
  prompt agnoster
  /bin/echo -e "
  \e]P0151515
  \e]P1ac4142
  \e]P290a959
  \e]P3f4bf75
  \e]P46a9fb5
  \e]P5aa759f
  \e]P675b5aa
  \e]P7d0d0d0
  \e]P8505050
  \e]P9ac4142
  \e]PA90a959
  \e]PBf4bf75
  \e]PC6a9fb5
  \e]PDaa759f
  \e]PE75b5aa
  \e]PFf5f5f5
  "
  # get rid of artifacts
  clear
fi

if [ "$TERM" = "xterm" ]; then
    TERM=xterm-256color
fi

archey3;
