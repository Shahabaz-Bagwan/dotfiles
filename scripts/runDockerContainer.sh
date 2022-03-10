#!/bin/bash

echo "running docker container..."

name=$1
sourceDir=$2
targetDir=$3
image=$4

check=0

docker run -d -it --name $name --mount type=bind,source=$sourceDir,target=$targetDir $image && check=1

if [ $check == 1 ]
then
  echo "container is started..."
else
  echo "container creation failed..."
fi

exit 0
