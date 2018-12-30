export TERMINAL=/usr/bin/urxvt

xrdb -merge ~/.Xresources
xmodmap ~/.Xmodmap
setxkbmap -model latitude -layout gb

if [ -d /etc/X11/xinit/xinitrc.d ] ; then
    for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
        [ -x "$f" ] && . "$f"
    done
    unset f
fi


# exec herbstluftwm --locked
# exec bspwm
# exec startxfce4
exec i3
# exec cinnamon-session
# export KDEWM=/usr/bin/i3
# exec startkde
# exec enlightenment_start
# exec startdde
# exec startlxqt
# export XDG_CURRENT_DESKTOP=GNOME-Classic:GNOME
# export GNOME_SHELL_SESSION_MODE=classic
# exec gnome-session
# exec gnome-session --session=gnome-classic
# exec mate-session
