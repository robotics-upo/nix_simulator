cmake_minimum_required(VERSION 2.8.3)
project(nix_simulator)

## Compile as C++11, supported in ROS Kinetic and newer
# add_compile_options(-std=c++11)

## Find catkin macros and libraries
## if COMPONENTS list like find_package(catkin REQUIRED COMPONENTS xyz)
## is used, also find other catkin packages

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

find_package(std_msgs REQUIRED)
include_directories(${catkin_INCLUDE_DIRS} include)
include_directories(${std_msgs_INCLUDE_DIRS})

# Find Gazebo
#find_package(gazebo REQUIRED)
#include_directories(${GAZEBO_INCLUDE_DIRS} deps/opende/src deps/threadpool/  )
#link_directories(${GAZEBO_LIBRARY_DIRS})
#set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} ${GAZEBO_CXX_FLAGS}")

# Build our plugin
# add_library(nix_plugin SHARED src/nix_plugin.cpp)
# target_link_libraries(nix_plugin SimpleTrackedVehiclePlugin /usr/lib/x86_64-linux-gnu/gazebo-9/plugins/libSimpleTrackedVehiclePlugin.so )
# target_link_libraries(nix_plugin SimpleTrackedVehiclePlugin TrackedVehiclePlugin /usr/lib/x86_64-linux-gnu/gazebo-9/plugins/libTrackedVehiclePlugin.a ${GAZEBO_LIBRARIES} ${catkin_LIBRARIES} )

#add_library(TrackedVehiclePluginROS SHARED src/TrackedVehiclePluginROS.cc)
#target_link_libraries(TrackedVehiclePluginROS ${GAZEBO_LIBRARIES} ${catkin_LIBRARIES} )

#add_library(SimpleTrackedVehiclePluginROS SHARED src/SimpleTrackedVehiclePluginROS.cc)
#target_link_libraries(SimpleTrackedVehiclePluginROS TrackedVehiclePluginROS ${GAZEBO_LIBRARIES} ${catkin_LIBRARIES} )

