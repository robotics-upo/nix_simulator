
#! /bin/bash

# Download the map resources:
DIR="./resources/maps/nix_ramp"

if [ -d "$DIR" ]; then
  # Take action if $DIR exists. #
  echo "Basic map set seems to be already installed, skipping"
else
  
  mkdir -p resources/maps
  cd resources/maps
  echo "Downloading basic map set"

  wget https://www.dropbox.com/sh/t7tf6wjbfzig70q/AAB6C-hW8NtQI-bZiGsQ3ZOKa?dl=1 -O sim.zip
  unzip sim.zip -d nix_ramp/
  echo "Basic map set succesfully downloaded in the resources/maps folder"
  cd ../..
fi

DIR="./resources/maps/nix_ramp_obscure"

if [ -d "$DIR" ]; then
  echo "Mockup with tunel area already downloaded"
else

  mkdir -p resources/maps/nix_ramp_obscure
  cd resources/maps
  echo "Downloading Marsella with tunnel area map"
  wget https://www.dropbox.com/sh/noqzt6wvvmn20iw/AAB-7nf_PDDiFCs-CYd8ZyD6a?dl=1 -O nix_ramp_obscure.zip
  unzip nix_ramp_obscure.zip -d nix_ramp_obscure/
  echo "Marsella with tunnel already downloaded"
  cd ../..
fi

rm resources/maps/*.zip