#!/usr/bin/env bash

function run {
    if ! pgrep $1 ;
    then
        $@&
    fi
}

run xrdb -load .config/xresources/Xresources
run picom
run stalonetray --config $HOME/.config/stalonetray/stalonetrayrc
run redshift-gtk
run $HOME/.fehbg
run xss-lock screenlock.sh
run polybar.sh
run nm-applet
run xsetroot -cursor_name left_ptr
run unclutter
run dunst
run keepassxc
run nextcloud
run easyeffects --gapplication-service
