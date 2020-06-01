[![Build Status](https://travis-ci.com/robotics-upo/nix_simulator.svg?token=TqYzdkAmMjrnqQCYqhh1&branch=master)](https://travis-ci.com/robotics-upo/nix_simulator)

# nix_simulator
Stand-alone package with the developments of the new nix-simulator. It has the following Gazebo simulation models:

- It includes a ROS gazebo Tracked Vehicle Simple plugin based on the RaposaNG product of Idmind company (https://www.idmind.pt/mobilerobotics/raposang/)
- It includes a sensor model for the Pico Flexx ToF cameras
- It includes the sensor designed in the NIx Project

The developments of this package have been funded by the European Commision under the NIx project of the Esmera innitiative. For more information please follow the link: http://www.esmera-project.eu/nix/

## Installation

In this section you will find the installation instructions for making it work. Next section (prerequisites) tells you the environment in which the package has been tested.

### Prerrequisites and dependencies

This package has been designed and tested in a x86_64 machine under a Linux 18.04 operating system and ROS melodic distribution. Besides, our update depends script lets you easilly install the following dependencies:

- Latest Gazebo 9 simulator from OSRF
- Gazebo ROS Package
- Gazebo plugins package for ROS
- Velodyne Gazebo plugin for ROS

### Instalation steps:

1- Clone this repository into the source of your catkin workspace. Please refer to http://wiki.ros.org/catkin/Tutorials/create_a_workspace to setup a new workspace.

2- Call the updateDepends.sh script to install the required dependencies.

```
rosrun nix_simulator updateDepends.sh
```

3- Build your catkin repository (catkin_make). It will automatically call download_mesh.sh and duplicate_sensor.sh scripts which are self-explanatory (please refer to the scripts to know the details).

```
roscd 
cd ..
catkin_make
```
## Usage

To launch the environment just launch the provided launch/nix_world.launch file.

```
roslaunch nix_simulator nix_world.launch
```

It will launch the NIX prototype inside the mockup given by the ESMERA consortium. The plaform accepts input command velocities with the ROS 'cmd_vel' topic. It also offers odometry measures in the 'odom' topic (to this date the estimation is the ground truth pose).

## TODO

The following characteristics are still pending:

- Add a thermal and a RGB camera to the sensing head
- Add noise to the odometry estimation
- Add motor to the flipper in the raposaNG platform
