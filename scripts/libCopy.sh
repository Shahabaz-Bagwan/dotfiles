#!/bin/bash

for i in `ldd $1 | awk 'NF > 2 {print $3}'`
do
  if [[ $i == "/lib/"* ||  $i == "/usr/lib/"* ]]; then
    continue
  fi
cp $i $2 
done
