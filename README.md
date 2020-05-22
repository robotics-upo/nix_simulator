# nix_simulator
Stand-alone package with the developments of the new nix-simulator

The developments of this package have been funded by the European Commision under the NIx project of the Esmera innitiative. For more information please follow the link: http://www.esmera-project.eu/nix/

## Installation

In this section you will find the installation instructions for making it work. Next section (prerequisites) tells you the environment in which the package has been tested.

### Prerrequisites

This package has been designed and tested in a x86_64 machine under a Linux 18.04 operating system and ROS melodic distribution. 

### Instalation steps:

We provide you with a handy installation script, which is found in scripts/install.bash. 

You have to call it with the root location of the target catkin workspace to be installed in. It should be called from a regular user account with sudo priviledges.

Example:

```
scripts/install.bash ~/catkin_ws
```

It will install the required packages, download or pull this repository into the selected workspace, build it. Finally, it will download the necessary mesh mesources if needed.

## Usage

To launch the environment just launch the provided launch/nix_world.launch file.

```
roslaunch nix_simulator nix_world.launch
```

It will launch a raposa platform inside the nix mockup. The plaform accepts input command velocities with the ROS 'cmd_vel' topic.
