#!/bin/bash

pgrep screenkey > /dev/null &&
  killall screenkey ||
    setsid screenkey & > /dev/null 
