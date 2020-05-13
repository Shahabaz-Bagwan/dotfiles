#!/bin/bash

# Directory of wallpapers:
DIR="$HOME/Pictures/wallpapers"

# Choose a random wallpaper from files in that directory:
FILES=($DIR/*)
WALLPAPER=`printf "%s\n" "${FILES[RANDOM % ${#FILES[@]}]}"`
WALLPAPER1=`printf "%s\n" "${FILES[RANDOM % ${#FILES[@]}]}"`
# Set as desktop background:
#nitrogen --set-scaled "$WALLPAPER"
feh --bg-scale "$WALLPAPER" --bg-scale "$WALLPAPER1"
