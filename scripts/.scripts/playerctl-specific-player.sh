#! /usr/bin/env bash

if [[ $# > 0 ]]; then
    if [[ $(playerctl --list-all | grep $1) ]]; then
        PLAYER="--player=$1"
    else
        PLAYER=""
    fi
    playerctl $PLAYER ${@:2}
else
    echo "Error: specify player name as 1st argument"
    exit 1
fi
