#!/bin/bash

# Get all possible displays
allposs=$(xrandr -q | grep -w "connected")

# Get all connected screens.
screens=$(echo "$allposs" | awk '{print $1}')

EXTERNAL_OUTPUT=$(echo $screens | awk '1 {print $3}')
EXTERNAL_OUTPUT2=$(echo $screens | awk '1 {print $2}')
INTERNAL_OUTPUT=$(echo $screens | awk '1 {print $1}')

# if we don't have a file, start at zero
if [ ! -f "/tmp/monitor_mode.dat" ] ; then
  monitor_mode=""

# otherwise read the value from the file
else
  monitor_mode=`cat /tmp/monitor_mode.dat`
fi

if [ $monitor_mode = "EXTERNAL" ]; then
        monitor_mode="INTERNAL"
        xrandr --output $INTERNAL_OUTPUT --auto --primary --output $EXTERNAL_OUTPUT \
               --off --output $EXTERNAL_OUTPUT2 --off
elif [ $monitor_mode = "INTERNAL" ]; then
        monitor_mode="CLONES"
        xrandr --output $INTERNAL_OUTPUT --auto --primary --output $EXTERNAL_OUTPUT2 \
               --auto --same-as $INTERNAL_OUTPUT
elif [ $monitor_mode = "CLONES" ]; then
        monitor_mode="ALL"
        xrandr --output $INTERNAL_OUTPUT --auto --primary --output $EXTERNAL_OUTPUT2 \
          --auto --right-of $INTERNAL_OUTPUT --output $EXTERNAL_OUTPUT --rotate right \
          --auto --right-of $EXTERNAL_OUTPUT2
else
        monitor_mode="EXTERNAL"
        xrandr --output $INTERNAL_OUTPUT --off --output $EXTERNAL_OUTPUT2 --auto --primary \
               --output $EXTERNAL_OUTPUT --rotate right --auto \
               --right-of $EXTERNAL_OUTPUT2
fi
echo "${monitor_mode}" > /tmp/monitor_mode.dat

exit 0
