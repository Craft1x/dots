#!/bin/bash
kitty -e bash -c "/usr/bin/vendor_perl/exiftool \"$1\"  ; sleep infinity"
