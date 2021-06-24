#!/bin/bash

# Directory of wallpapers:
DIR="$HOME/Pictures/wallpapers"
# Choose a random wallpaper from files in that directory:
FILES=($DIR/*)
WALLPAPER=`printf "%s\n" "${FILES[RANDOM % ${#FILES[@]}]}"`
# Set as desktop background:
convert -geometry 1920x $WALLPAPER /tmp/lockImg.png 
i3lock -ti /tmp/lockImg.png
