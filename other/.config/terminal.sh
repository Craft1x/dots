#!/usr/bin/env bash

# ln this to /bin/gnome-terminal

# for kitty
#if [ $# == 3 ] && [ "${1}" == "--" ]; then
#		kitty --title="$(basename $3)" "${2}" "${3}"
#fi

# for tilix
#if [ $# == 3 ] && [ "${1}" == "--" ]; then
#		tilix --title="$(basename $3)" --geometry=90x60 -e "${2}" "${3}"
#fi

# for alaritty
if [ $# == 3 ] && [ "${1}" == "--" ]; then
		alacritty msg create-window --title="$(basename "$3")" -e "${2}" "${3}" || alacritty --title="$(basename "$3")" -e "${2}" "${3}"
    return
fi

alacritty msg create-window "$@" || alacritty "$@"

# for urxvt
#if [ $# == 3 ] && [ "${1}" == "--" ]; then
#		urxvt -title "$(basename $3)" -e "${2}" "${3}"
#fi
