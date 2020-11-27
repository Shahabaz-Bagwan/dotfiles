#!/bin/bash

ffmpeg -f x11grab -s 1920x1200 -i :0.0 out.mkv
