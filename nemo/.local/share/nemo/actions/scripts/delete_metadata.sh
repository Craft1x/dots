#!/usr/bin/env bash
for file in "$@"
do
	/usr/bin/vendor_perl/exiftool -all:all= -tagsfromfile @ -exif:Orientation -overwrite_original "$file"
done
