xrdb -merge ~/.Xresources
xmodmap ~/.Xmodmap

if [ -d /etc/X11/xinit/xinitrc.d ] ; then
    for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
        [ -x "$f" ] && . "$f"
    done
    unset f
fi

export TERMINAL=/home/chris/bin/evilvte

exec bspwm
# exec i3
# exec startxfce4
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
