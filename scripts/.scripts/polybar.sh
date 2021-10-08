#!/usr/bin/env bash

polybar-msg cmd quit

echo "---" | tee -a /tmp/polybarmain.log
polybar main >>/tmp/polybarmain.log 2>&1 &
