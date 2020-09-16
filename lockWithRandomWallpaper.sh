#!/bin/bash

# Directory of wallpapers:
DIR="$HOME/Pictures/wallpapers"
# Choose a random wallpaper from files in that directory:
FILES=($DIR/*.png)
WALLPAPER=`printf "%s\n" "${FILES[RANDOM % ${#FILES[@]}]}"`
# Set as desktop background:
i3lock -ti "$WALLPAPER" 
