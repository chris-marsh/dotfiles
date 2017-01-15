#!/bin/bash
# Must be executed with 'dotfiles' as the working directory
here=$(pwd)
rm ~/.Xresources
ln -s $here/Xresources ~/.Xresources
rm ~/.inputrc
ln -s $here/inputrc ~/.inputrc
rm ~/.xinitrc
ln -s $here/xinitrc ~/.xinitrc
rm ~/.bashrc
ln -s $here/bashrc ~/.bashrc
rm ~/.vimrc
ln -s $here/vimrc ~/.vimrc
rm ~/.vim
ln -s $here/vim ~/.vim
rm ~/.zshrc
ln -s $here/zshrc ~/.zshrc
rm ~/.config/bspwm
ln -s $here/bspwm ~/.config/bspwm
rm ~/.vifm
ln -s $here/vifm ~/.vifm
rm ~/.shell
ln -s $here/shell ~/.shell
rm ~/.i3
ln -s $here/i3 ~/.i3
rm ~/bin
ln -s $here/bin ~/bin
