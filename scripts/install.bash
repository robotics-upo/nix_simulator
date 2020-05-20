#! /bin/bash

if [[ $# -ne 1 ]]
then
    echo "Use: $0 <root target catkin workspace location>"
    exit -1
fi

if [[ -d $1/src/nix_simulator ]] 
then
    cd $1/src/nix_simulator
    git pull
    cd ../..
else
    cd $1/src
    git clone https://github.com/robotics-upo/nix_simulator.git
    cd ..    
fi

# Install gazebo 9 last release. TODO: necessary??
# sudo sh -c 'echo "deb http://packages.osrfoundation.org/gazebo/ubuntu-stable `lsb_release -cs` main" > /etc/apt/sources.list.d/gazebo-stable.list'
# sudo apt-get update
# sudo apt-get upgrade -y
# sudo apt-get install gazebo9 -y

sudo apt-get install ros-melodic-gazebo-ros gazebo9 -y

# Build the SimpleTrackedVehicleROS plugin
# catkin_make

# Download the mesh resources:
mkdir -p src/nix_simulator/models/mockup_nix/mesh
cd src/nix_simulator/models/mockup_nix/mesh
echo "Downloading md5 check file"
wget --quiet https://www.dropbox.com/s/1gmnnnum9v0qezf/mockup_nix.md5?dl=1 -O mockup_nix.md5
md5sum --status --check mockup_nix.md5
Result=$?
if [[ $Result -eq 0 ]]
then
    echo "Nix mesh already downloaded"
else
    echo "MD5 check of the mesh failed. Downloading Nix mockup's mesh."
    wget --quiet https://www.dropbox.com/s/tpcqfmahtj9qxmg/mockup_nix.dae?dl=1 -O mockup_nix.dae
    echo "Checking MD5 again."
    ls -l
    md5sum -c mockup_nix.md5
    Result=$?
    if [[ $Result -ne 0 ]]
    then
        echo "MD5 error when downloaded the NIX mockup's mesh. Aborting."
        exit -1
    fi
    cd ../../../../../          # Going back to the root of the workspace
fi

echo "Nix world repository installed successfully. Use \"roslaunch nix_simulator nix_world.launch \" to test it."
