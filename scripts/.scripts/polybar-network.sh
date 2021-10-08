#!/usr/bin/env bash

#  直睊.
#   .

count=0
disconnected="睊"
wireless_connected="直"
ethernet_connected=""

ID="$(ip link | awk '/state UP/ {print $2}')"

while true; do
    if (ping -c 1 archlinux.org || ping -c 1 duckduckgo.com || ping -c 1 bitbucket.org || ping -c 1 sourceforge.net) &>/dev/null; then
        if [[ $ID == e* ]]; then
            echo "$ethernet_connected" ; sleep 25
        else
            echo "$wireless_connected" ; sleep 25
        fi
    else
        echo "$disconnected" ; sleep 0.5
    fi
done
