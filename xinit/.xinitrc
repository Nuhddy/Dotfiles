#!/bin/sh

if [ -d /etc/X11/xinit/xinitrc.d ] ; then
 for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
  [ -x "$f" ] && . "$f"
 done
 unset f
fi

eval $(/usr/bin/gnome-keyring-daemon --start --components=pkcs11,secrets,ssh)
export SSH_AUTH_SOCK

session=${1:-i3}

case $session in
    awesome)    exec awesome;;
    bspwm)      exec bspwm;;
    i3)         exec i3;;
    qtile)      exec qtile;;
esac
