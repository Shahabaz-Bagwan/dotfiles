#!/bin/bash

usage="$(basename "$0") [-h] [-n containerName] [-s sourceDir] [-t targetDir] -- script to run docker container from docker image

where:
    -h  show this help text
    -n  set the container name
    -s  set the source directory to mount in container
    -t  set the target directory in container"

name=dockerContainer
sourceDir="$HOME"
targetDir="$HOME"
while getopts ':h:n:s:t:' option; do
  case "$option" in
    h) echo "$usage"
       exit
       ;;
    n) name=$OPTARG
       ;;
    s) sourceDir=$OPTARG
       ;;
    t) targetDir=$OPTARG
       ;;
    :) printf "missing argument for -%s\n" "$OPTARG" >&2
       echo "$usage" >&2
       exit 1
       ;;
   \?) printf "illegal option: -%s\n" "$OPTARG" >&2
       echo "$usage" >&2
       exit 1
       ;;
  esac
done
shift $((OPTIND - 1))
echo "running docker container..."

image=$( docker image list | rofi -dmenu -i -p "Select docker image" | awk '{printf "%s:%s",$1,$2}')

check=0

docker run -d -it --name $name --mount type=bind,source=$sourceDir,target=$targetDir $image && check=1

if [ $check == 1 ]
then
  echo "container is started..."
else
  echo "container creation failed..."
fi
