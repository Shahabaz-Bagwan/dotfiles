#!/bin/bash

# Directory of wallpapers:
DIR="$HOME/Pictures/wallpapers"

# Choose a random wallpaper from files in that directory:
FILES=($DIR/*)
WALLPAPER=`printf "%s\n" "${FILES[RANDOM % ${#FILES[@]}]}"`
WALLPAPER1=`printf "%s\n" "${FILES[RANDOM % ${#FILES[@]}]}"`
# Set as desktop background:
feh --bg-fill "$WALLPAPER" 
#--bg-fill "$WALLPAPER1"
wal -ni "$WALLPAPER"
i3 restart
