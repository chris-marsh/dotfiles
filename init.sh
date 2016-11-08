#!/bin/bash
# Must be executed with 'dotfiles' as the working directory
here=$(pwd)
ln -s $here/Xresources ~/.Xresources
ln -s $here/inputrc ~/.inputrc
ln -s $here/xinitrc ~/.xinitrc
ln -s $here/bashrc ~/.bashrc
ln -s $here/vimrc ~/.vimrc
ln -s $here/vim ~/.vim
ln -s $here/fish ~/.config/fish
ln -s $here/i3 ~/.i3
ln -s $here/vifm ~/.vifm
