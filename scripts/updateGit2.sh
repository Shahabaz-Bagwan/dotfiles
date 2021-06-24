#!/bin/bash

# Update all git directories below specified directories
# Skips directories that contain a file called .ignore
# See https://stackoverflow.com/a/61207488/553865

HIGHLIGHT="\e[01;34m"
NORMAL='\e[00m'

export PATH=${PATH/':./:'/:}
export PATH=${PATH/':./bin:'/:}
#echo "$PATH"

DIRS="$( find "$@" -type d \( -execdir test -e {}/.ignore \; -prune \) -o \( -execdir test -d {}/.git \; -prune -print \) )"

echo -e "${HIGHLIGHT}Scanning ${PWD}${NORMAL}"
for d in $DIRS; do
  cd "$d" > /dev/null
  echo -e "\n${HIGHLIGHT}Updating `pwd`$NORMAL"
  git pull
  cd - > /dev/null
done
