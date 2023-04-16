#!/usr/bin/env bash
source "$HOME/.config/polybar/scripts/source-colors.sh"

icon_color="${green}"

pulseaudio-control --format '%{F'$icon_color'}$VOL_ICON $NODE_NICKNAME%{F-}${VOL_LEVEL}' --icons-volume "ﱘ" --icon-muted "ﱙ " --node-nicknames-from "device.description" --node-nickname "*: " --node-nickname "alsa_output.pci-0000_01_00.1.hdmi-stereo-extra4:墳 " --node-nickname "bluez_output.4F_F4_A0_BF_83_39.1: " listen
