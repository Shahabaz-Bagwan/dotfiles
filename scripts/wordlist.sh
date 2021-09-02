#!/bin/bash

# prompt for adding a word
word=$(rofi -dmenu -p "Add a word ")

# Append word in a document
echo $word >> $HOME/repos/wordlist/Deutsch.txt

exit 0;
