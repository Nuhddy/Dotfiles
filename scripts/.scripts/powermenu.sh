#!/bin/bash

rofi_command="rofi -theme powermenu.rasi"

power_off=""
reboot=""
lock=""
suspend="鈴"
log_out=""

options="$power_off\n$reboot\n$lock\n$suspend\n$log_out"

chosen="$(echo -e "$options" | $rofi_command -dmenu -selected-row 2)"
case $chosen in
    $power_off)
        promptmenu.sh --yes-command "systemctl poweroff" --query "Shutdown?"
        ;;
    $reboot)
        promptmenu.sh --yes-command "systemctl reboot" --query "Reboot?"
        ;;
    $lock)
        screenlock.sh
        ;;
    $suspend)
        systemctl suspend
        ;;
    $log_out)
        bspc quit
        ;;
esac
