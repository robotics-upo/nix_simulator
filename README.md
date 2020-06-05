[![Build Status](https://travis-ci.com/robotics-upo/nix_simulator.svg?token=TqYzdkAmMjrnqQCYqhh1&branch=master)](https://travis-ci.com/robotics-upo/nix_simulator)

# nix_simulator
Stand-alone package with the developments of the new nix-simulator. It has the following Gazebo simulation models:

- It includes a ROS gazebo Tracked Vehicle Simple plugin based on the RaposaNG product of Idmind company (https://www.idmind.pt/mobilerobotics/raposang/)
- It includes a sensor model for the Pico Flexx ToF cameras
- It includes the sensor designed in the NIx Project

The developments of this package have been funded by the European Commision under the NIx project of the Esmera innitiative. For more information please follow the link: http://www.esmera-project.eu/nix/


<p align="center">
    <img src="resources/sim_preview.gif" width="900">
</p>

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

## Optional extras

### Raposa Marker

In order to take better snapshots of the simulation in RViz, you can launch the environment with the following modification

```
roslaunch nix_simulator nix_world.launch launch_raposa_marker:=true
```

but you will need to download and compile the package first:

```
git clone https://github.com/robotics-upo/raposa_marker.git
```

### Teleop

By default there is no telepo included in the simulator, but you can the standard one [teleop_twist_joy](http://wiki.ros.org/teleop_twist_joy) or the [teleop_twist_keyboard](http://wiki.ros.org/teleop_twist_keyboard) depending if you have a a joystick or not. To install them

```
sudo apt-get install ros-$ROS_DISTRO-teleop-twist-joy
```
or 

```
sudo apt-get install ros-$ROS_DISTRO-teleop-twist-keyboard
```

to launch the simulation with the teleop simply run:

```
roslaunch nix_simulator nix_world.launch joy_teleop:=true
```

By now it's only configured for joy teleoperation, if you want to use the keyboard you have to launch it by yourself. Note that to enable the teleoperation you should use the joystick with the R1 button pressed. 

### Mapping 

To launch the mapping features you will need three more packages, the LOAM(branch final) and the nix_launchers (branch simulation_features). In order to compile and run the loam package you need to install [ceres solver](http://ceres-solver.org/installation.html) before. 

```
git clone -b final https://github.com/robotics-upo/a-loam.git
```
And
```
git clone -b simulation_features https://github.com/robotics-upo/nix_launchers.git
```
And the timed roslaunch package:
```
sudo apt-get install ros-melodic-timed-roslaunch
```

Download and compile them in your workspace and launch the whole system with:

```
roslaunch nix_simulator nix_world.launch joy_teleop:=true launch_raposa_marker:=true rviz:=true mapping_system:=true
```

It will also launch the teleop, the raposa marker for rviz, the rviz mapping layout. If you are happy with the maps, you can save them by running:
```
rosrun nix_launchers save_maps.sh <map_name> <projected_map_topic> <folder_to_save_maps>
```

Where ```<projected_map_topic>``` can be ```/p_map``` or ```/projected_map``` and ```<folder_to_save_maps>``` the *full* path of the folder where you want to save your maps.
### 3D MCL Localization system 

<p align="center">
    <img src="resources/localization_demo.gif" width="900">
</p>
You can also play launch the 3D Monte Carlo localization system along with the simulator. First, you need to download and compile the package in your workspace:

```
git clone -b feature_gps2 https://github.com/robotics-upo/mcl3d.git && git clone https://github.com/robotics-upo/range_msgs.git
```

It will clone the package and the range_msgs dependency. 

To launch the simulation with the localization system:

```
roslaunch nix_simulator nix_world.launch localization_system:=true
```

It will launch the mcl3d, a custom RViz layout for visualizing the clouds and the pose array, it will launch the teleop and raposa marker.

### Rviz Layout

You can also launch the simulation along with rviz, in the viz/ folder you can find the configuration that will be used launching the world with the argument ```rviz:=true```.

## Performance Notes

Using a MSI GE63 Laptop we have achieve a real time factor of 0.8 ~ 0.9 suscribing to the five point clouds from the lidar and cameras simultaneously. This is mostly due to the use of the GPU. If you have any suggestion about improving the performance, tell us!

## TODO

The following characteristics are still pending:

 - [ ] Add a thermal and a RGB camera to the sensing head
 - [ ] Add noise to the odometry estimation
 - [ ] Add motor to the flipper in the raposaNG platform
 - [ ] Check why the floor does not appear in the map, because of LOAM, because of OctoMap...?
 - [ ] Add simulated imu, mainly to use with MCL3D