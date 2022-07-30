#!/bin/bash


#Get destination directory
if [ -z "$2" ]
  then
    DEST=$(dirname "$(readlink -f "$1")")
   else 
   	DEST="$2"
fi

echo "Filename: "  ${DEST}


#Confirm name of link
FILE=$(basename "$1")

NAME="Link to $FILE"

#Check not overwriting an existing file or directory
if [ -e "$DEST/$NAME" ]; then
  # zenity --info --width=250 --text="Error creating link. $DEST/$NAME already exists. Try again."
  echo "already exist"
  exit 1
fi
#Is destination writeable?
if [ ! -w "$DEST" ] ; then
  export SUDO_ASKPASS="$HOME/.local/share/nemo/actions/scripts/zenity_askpass.sh"
  sudo -A ln -s "$1" "$DEST/$NAME"
else
  ln -s "$1" "$DEST/$NAME"
fi
