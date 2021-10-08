#!/bin/bash

rofi_command="rofi -theme maimmenu.rasi"

screen=""
area=""
window=""

options="$screen\n$area\n$window"

chosen="$(echo -e "$options" | $rofi_command -dmenu -selected-row 1)"
case $chosen in
    $screen)
        sleep 1; maim
        ;;
    $area)
        maim -s
        ;;
    $window)
        sleep 1; maim -i $(xdotool getactivewindow)
        ;;
esac
