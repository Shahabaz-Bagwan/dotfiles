#!/bin/bash

# prompt for adding a word

word=$(rofi -dmenu -p "search a word ")

# Append word in a document
if [ -z "$word" ]; then
  exit 0;
else
  st -e w3m de.wiktionary.org/wiki/$word
fi 
exit 0;
