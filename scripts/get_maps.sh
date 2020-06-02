
#! /bin/bash

# Download the map resources:
DIR="./resources/maps/sim"

if [ -d "$DIR" ]; then
  # Take action if $DIR exists. #
  echo "Basic map set seems to be already installed, skipping"
else
  
  mkdir -p resources/maps
  cd resources/maps
  echo "Downloading basic map set"

  wget --quiet https://www.dropbox.com/sh/t7tf6wjbfzig70q/AAB6C-hW8NtQI-bZiGsQ3ZOKa?dl=1 -O sim.zip
  unzip sim.zip -d sim/
  rm sim.zip
  echo "Basic map set succesfully downloaded in the resources/maps folder"
fi
