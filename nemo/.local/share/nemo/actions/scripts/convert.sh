#!/usr/bin/env bash
type -a trash || notify-send "/bin/trash not found"

newFormat=$(zenity --entry --title="Enter new file format" --text="New format:")

# remove the leading dot
newFormat=`echo "${newFormat}" | sed 's/^\.//'`

[ -z "$newFormat" ] && exit 0

for var in "$@"
do
	oldFormat="${var##*.}"

	[ "$oldFormat" == "$newFormat" ] && continue

	inType=`file -b -L --mime-type "$var"`

	#if inType contains a space
	if [[ "$oldFormat" == *" "* ]]; then
		newName="$var"
	else
		newName="${var%.*}"
	fi

	notify-send "$var"

	if [ `echo "$inType" | grep "video\|audio"` ]; then
		ffmpeg -i "$var" "$newName.$newFormat" && trash "$var"
	else
		convert "$var" "$newName.$newFormat" && trash "$var"
	fi
done
