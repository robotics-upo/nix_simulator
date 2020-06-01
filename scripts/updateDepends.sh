#! /bin/bash

if [[ -z "$ROS_DISTRO" ]]; then
    echo ROS_DISTRO environment variable not set. Aborting!!
    exit -1
fi

# Install gazebo 9 last release. 
echo Adding osrf Repository and downloading the keys
sudo sh -c 'echo "deb http://packages.osrfoundation.org/gazebo/ubuntu-stable `lsb_release -cs` main" > /etc/apt/sources.list.d/gazebo-stable.list'
wget https://packages.osrfoundation.org/gazebo.key -O - | sudo apt-key add -
echo Updating apt cache
sudo apt-get update
echo Downloading necessary packages
sudo apt-get install gazebo9 ros-$ROS_DISTRO-gazebo-ros ros-$ROS_DISTRO-gazebo-plugins gazebo9  ros-$ROS_DISTRO-velodyne-gazebo-plugins -y

echo "Nix simulator dependencies installed."
echo "First, use catkin_make in your catkin workspace."
echo "Then, use \"roslaunch nix_simulator nix_world.launch \" to test it."
