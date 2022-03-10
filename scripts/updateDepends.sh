#! /bin/bash
if [[ -z "$ROS_DISTRO" ]]; then
    echo ROS_DISTRO environment variable not set. Aborting!!
    exit -1
fi

# Install our ignition gazebo with radar support
echo "Getting ignition gazebo sources. First dependencies (source )"
sudo apt install python3-pip wget lsb-release gnupg curl
pip install vcstool || pip3 install vcstool
pip install -U colcon-common-extensions || pip3 install -U colcon-common-extensions
# Get vcstool and colcon (the apt way, pip way commented out)
#pip install vcstool || pip3 install vcstool
#pip install -U colcon-common-extensions || pip3 install -U colcon-common-extensions
#export PATH=$PATH:$HOME/.local/bin/
sudo sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list'
curl -s https://raw.githubusercontent.com/ros/rosdistro/master/ros.asc | sudo apt-key add -
sudo apt-get update
sudo apt-get -y install python3-vcstool python3-colcon-common-extensions
sudo apt-get -y install git ros-$ROS_DISTRO-joy-teleop 
# Getting the sources
mkdir -p ~/ign_workspace/src
cd ~/ign_workspace/src
wget https://raw.githubusercontent.com/robotics-upo/ign-gazebo/ign-gazebo6/tools/collection-fortress-radar.yaml
vcs import < collection-fortress-radar.yaml
#Update dependencies
sudo wget https://packages.osrfoundation.org/gazebo.gpg -O /usr/share/keyrings/pkgs-osrf-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/pkgs-osrf-archive-keyring.gpg] http://packages.osrfoundation.org/gazebo/ubuntu-stable $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/gazebo-stable.list > /dev/null
sudo apt-get update
sudo apt -y install \
  $(sort -u $(find . -iname 'packages-'`lsb_release -cs`'.apt' -o -iname 'packages.apt' | grep -v '/\.git/') | sed '/ignition\|sdf/d' | tr '\n' ' ')
# Build the ignition workspace
cd ~/ign_workspace
colcon graph
colcon build --cmake-args -DBUILD_TESTING=OFF --merge-install

#Get ign ros
# Setup the workspace
mkdir -p ~/catkin_ws/src
cd ~/catkin_ws/src
export IGNITION_VERSION=fortress
# Download needed software
git clone https://github.com/osrf/ros_ign.git -b $(ROS_DISTRO)
cd ~/catkin_ws
rosdep install -r --from-paths src -i -y --rosdistro $(ROS_DISTRO)
catkin_make
source devel/setup.bash

#Downlaod and install kindr library for elevation maps
cd ~/
git clone https://github.com/anybotics/kindr.git
cd kindr 
mkdir build && cd build
cmake ..
make
sudo make install

echo "Nix simulator dependencies installed."

echo "To install the nix_launchers package, please go to the src directory of your workspace and execute:"
echo "$ rosinstall . nix_simulator/nix_simulator.rosinstall"

echo "Then, build your workspace with catkin_make."
echo "Finally, use \"roslaunch nix_simulator nix_world.launch \" to test it."

