#!/usr/bin/env bash

udevadm monitor --kernel --property --subsystem-match=input | grep  --line-buffered "ACTION=add"  | \
  while read -r LINE; do \
    sleep 1 ; \
    setxkbmap -option altwin:swap_alt_win ; \
    xset r rate 300 50 ; \
  done
