#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

. ~/.shell/aliases.sh
. ~/.shell/functions.sh

export EDITOR=vim
export GOPATH=/home/chris/go
export PATH=$PATH:${GOPATH//://bin:}/bin
export PATH=$PATH:~/.dotfiles/bin:.
export PATH="$HOME/.cargo/bin:$PATH"

[ -r /usr/share/bash-completion/bash_completion ] && . /usr/share/bash-completion/bash_completion

if [ "$TERM" = "linux" ]; then
    source ~/.shell/pureline/pureline ~/.config/pureline_tty_full.conf
else
    source ~/.shell/pureline/pureline ~/.config/pureline.conf
fi

if [ "$TERM" = "xterm" -o "$TERM" = "rxvt-unicode-256color" ]; then
    export TERM=xterm-256color
fi

neofetch
