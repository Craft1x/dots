#!/bin/sh

# Verify clipster is running, fail otherwise
clipster -o > /dev/null 2>&1
if [ $? -ne 0 ]; then
  echo 'Failed to retrieve history from Clipster, please ensure daemon is running!'
  exit 1
fi

# Extract clipboard history from clipster and format for rofi
#  - Remove Newlines from clips
#  - Limit line length to 100 chars (for display in rofi)
#  - Split into lines based on NUL byte
#  - Remove Leading whitespace
#  - Remove empty clipboard items
#  - Add line numbers to clip items
# NOTE: This is all done in a single line because bash can't store a NUL byte
C_HIST="$(clipster -c -o -n 500 -0 \
        | gawk 'BEGIN {RS = "\0"; ORS = "\0"} NF > 0 { print substr($0, 1, 100) }' \
        | gawk 'BEGIN {RS = "\0"; FS="\n"; OFS=" " } { $1=$1; print $0 }'  \
        | sed 's/^ *//' \
        | gawk '{printf("%002d   %s\n", NR, $0)}')"

theme="style-noicon"
dir="$HOME/.config/rofi"

SELECTION="$(echo "$C_HIST" | rofi -theme $dir/"$theme" -matching fuzzy -dmenu -i -lines 20 -p '')"

# Verify user made a selection
if [ -n "$SELECTION" ]; then

  # Retrieve the line number from the beginning of selection and remove leading zeros
  NUMBER="$(echo "$SELECTION" | cut -c1-3 | sed 's/^0*//')"

  # Extract clipboard history from clipster and find the nth non-empty clip based selected line number
  EXACT_SELECTION="$(clipster -c -o -n 500 -0 \
                   | gawk 'BEGIN {RS = "\0"; ORS = "\0"} NF > 0 { print }' \
                   | gawk 'BEGIN {RS = "\0"}'"NR == $NUMBER { print; exit }")"

  # Echo the selection back to clipster
  echo -n "$EXACT_SELECTION" | clipster -c
fi
