#!/usr/bin/env bash

# It is needed to make nitrogen work correctly
export DISPLAY=":0"

# Defining the directory with wallpapers
BG_DIR=$HOME/.config/wallpapers

CACHE_DIR=$HOME/.cache/nitrogen

mkdir -p "$CACHE_DIR"

# delete bugged lockfile that is older than 1 minute
find "${CACHE_DIR}"/lockfile -mmin +1 -delete

[ -f "${CACHE_DIR}"/lockfile ] && exit 0

touch "${CACHE_DIR}"/lockfile

[ -f "${CACHE_DIR}"/current_bg_image.jpg ] && rm "${CACHE_DIR}"/current_bg_image.jpg 
[ -f "${CACHE_DIR}"/next_bg_image.jpg ] && mv "${CACHE_DIR}"/next_bg_image.jpg "${CACHE_DIR}"/current_bg_image.jpg

# refreshing wallpaper image
nitrogen --restore > /dev/null 2>&1 &

# set a matching window border color 
~/.config/i3/set_border_color.sh set

# provide some cpu time for other things like fade in animations
UPTIME=$(</proc/uptime)
UPTIME=${UPTIME%%.*}
[ "$UPTIME" -le 10 ] && sleep 5

# Feeding random generator with the date in seconds (UNIX time)
RANDOM=$$$(date +%s)

# Generating list of all wallpapers in the directory
BG_LIST=("${BG_DIR}"/*.jpg)

# Counting total number of files
BG_NUM=$(ls -1 "${BG_DIR}" | wc -l)

# Randomly select some number from the total number of wallpapers
SELECTED_BG=$(( RANDOM % BG_NUM ))

cp "${BG_LIST[$SELECTED_BG]}" "${CACHE_DIR}"/next_bg_image.jpg 

COUNT=1
for RES in $(xrandr --current | grep '\*' | uniq | awk '{print $1}');
do
  convert "${CACHE_DIR}"/next_bg_image.jpg -quality 100 -resize "$RES"^ -extent "$RES" "${CACHE_DIR}"/$COUNT.jpg
  let COUNT++
done;

# Copy image for login manager
[ -d /usr/share/sddm/Backgrounds ] && cp "$CACHE_DIR"/1.jpg /usr/share/sddm/Backgrounds

# generate a matching window border color 
~/.config/i3/set_border_color.sh next



rm "${CACHE_DIR}"/lockfile 
