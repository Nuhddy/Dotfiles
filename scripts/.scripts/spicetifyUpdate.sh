#!/bin/bash

sudo --user=$USER spicetify backup update apply && killall -q spotify
