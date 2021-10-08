#!/bin/sh

winid=`xdotool search --class "stalonetray" | head -1`
winstate=`xwininfo -id $winid | grep "Map State:"`

if [[ $winstate = *IsViewable ]]; then
    xdo hide $winid
else
    xdo show $winid
    xdo raise $winid
fi
