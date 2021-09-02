#!/bin/bash

# prompt for adding a word
word=$(rofi -dmenu -p "Add a word ")

# Append word in a document
echo "$word: " >> $HOME/repos/dotfiles/wordlist/Deutsch.txt
st -e w3m de.wiktionary.org/wiki/$word

exit 0;
