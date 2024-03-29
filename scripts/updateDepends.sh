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
sudo apt-get install gazebo9 ros-$ROS_DISTRO-gazebo-ros ros-$ROS_DISTRO-gazebo-plugins gazebo9  ros-$ROS_DISTRO-velodyne-gazebo-plugins ros-$ROS_DISTRO-twist-mux ros-$ROS_DISTRO-teleop-twist-joy ros-$ROS_DISTRO-timed-roslaunch ros-$ROS_DISTRO-octomap ros-$ROS_DISTRO-octomap-ros ros-$ROS_DISTRO-pointcloud-to-laserscan ros-$ROS_DISTRO-ira-laser-tools -y  ros-$ROS_DISTRO-ros-type-instrospection libceres-dev libgsl-dev ros-$ROS_DISTRO-costmap-2d libzmq3-dev libdw-dev ros-$ROS_DISTRO-people-msgs ros-$ROS_DISTRO-map-server ros-$ROS_DISTRO-grid-map-core ros-$ROS_DISTRO-grid-map-ros ros-$ROS_DISTRO-grid-map

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

