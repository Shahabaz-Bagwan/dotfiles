#!/bin/bash
tmp_file="/tmp/qr.png"
scrot -s $tmp_file
zbarimg --quiet --raw "$tmp_file" | xclip -sel c -r
rm $tmp_file
