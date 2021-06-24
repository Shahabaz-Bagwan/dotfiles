#!/bin/bash

# Directory of wallpapers:
DIR=$(dir -H1 /bin)

# Choose a random wallpaper from files in that directory:
FILES=( $DIR )
MAN=`printf "%s\n" "${FILES[RANDOM % ${#FILES[@]}]}"`
exec man $MAN
exit 0
