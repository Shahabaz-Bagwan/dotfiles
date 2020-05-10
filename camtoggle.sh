#!/bin/bash
pkill -f /dev/video || mpv --geometry=-0-0 --vf=hflip --autofit=20% /dev/video0
