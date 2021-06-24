#!/bin/bash
pkill -f /dev/video || mpv --geometry=-0-0 --vf=hflip --autofit=20% av://v4l2:/dev/video0 --profile=low-latency --untimed

