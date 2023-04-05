#!/usr/bin/env bash
adb -d install "$1" && notify-send "Install Successful" || notify-send "Error Installing"
