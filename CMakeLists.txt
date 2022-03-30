cmake_minimum_required(VERSION 2.8.3)
project(nix_simulator)

## Compile as C++14, supported in ROS Kinetic and newer
add_compile_options(-std=c++14)

## Execute commands needed for simulation
execute_process(COMMAND "./scripts/duplicate_sensors.sh" 
                WORKING_DIRECTORY ${PROJECT_SOURCE_DIR} )
execute_process(COMMAND "./scripts/download_mesh.sh" 
                WORKING_DIRECTORY ${PROJECT_SOURCE_DIR} )
execute_process(COMMAND "./scripts/get_maps.sh" 
                WORKING_DIRECTORY ${PROJECT_SOURCE_DIR} )          

find_package(catkin REQUIRED COMPONENTS
  ros_ign_bridge
  ros_ign_gazebo
  roscpp
  std_msgs
  geometry_msgs
)

catkin_package(
#  INCLUDE_DIRS include
#  LIBRARIES cloud_concatenator
#  CATKIN_DEPENDS message_filters pcl_ros roscpp sensor_msgs
#  DEPENDS system_lib
)

# Find the Ignition_Transport library
find_package(ignition-transport11 QUIET REQUIRED OPTIONAL_COMPONENTS log)
set(IGN_TRANSPORT_VER ${ignition-transport11_VERSION_MAJOR})

add_executable(ign_clock_publisher src/ign_clock_publisher.cpp)
target_link_libraries(ign_clock_publisher  ignition-transport${IGN_TRANSPORT_VER}::core )

add_executable(ground_truth_pose_publisher src/ground_truth_pose_publisher.cpp)
target_link_libraries(ground_truth_pose_publisher  ignition-transport${IGN_TRANSPORT_VER}::core )
