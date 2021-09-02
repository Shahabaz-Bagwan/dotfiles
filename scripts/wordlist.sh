#!/bin/bash

# prompt for adding a word

word=$(rofi -dmenu -p "Add a word ")

# Append word in a document
if [ -z "$word" ]; then
  exit 0;
else
  echo "$word: " >> $HOME/repos/dotfiles/wordlist/Deutsch.txt
  st -e w3m de.wiktionary.org/wiki/$word
fi 
exit 0;
