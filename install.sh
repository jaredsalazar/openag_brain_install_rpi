#!/bin/bash

set -e

# Tell apt to read from the ROS package repository
sudo sh -c 'echo "deb http://packages.ros.org/ros/ubuntu jessie main" > /etc/apt/sources.list.d/ros-latest.list'
wget https://raw.githubusercontent.com/ros/rosdistro/master/ros.key -O - | sudo apt-key add -
read -rsp $'Press any key to continue...\n' -n1 key

# Update apt
sudo apt-get update
sudo apt-get -y upgrade
read -rsp $'Press any key to continue...\n' -n1 key

# Install dependencies
sudo apt-get install python-pip
sudo pip install rosdep rosinstall_generator wstool
read -rsp $'Press any key to continue...\n' -n1 key

# Initialize rosdep
sudo rosdep init
rosdep update
read -rsp $'Press any key to continue...\n' -n1 key

# Create a catkin workspace
mkdir -p ~/ros_catkin_ws
cd ~/ros_catkin_ws
read -rsp $'Press any key to continue...\n' -n1 key

# Install ros_comm and rosserial
echo Generating rosinstall file...
rm -f indigo.rosinstall src/.rosinstall
rosinstall_generator ros_comm rosserial rosserial_arduino --rosdistro indigo --deps --wet-only --exclude roslisp --tar > indigo.rosinstall
wstool init src indigo.rosinstall
read -rsp $'Press any key to continue...\n' -n1 key

# Install dependencies for all installed packages
rosdep install --from-paths src --ignore-src --rosdistro indigo -y -r --os=debian:jessie
read -rsp $'Press any key to continue...\n' -n1 key

# Install packages in system directory
sudo ./src/catkin/bin/catkin_make_isolated --install -DCMAKE_BUILD_TYPE=Release --install-space /opt/ros/indigo -j2
read -rsp $'Press any key to continue...\n' -n1 key

# Activate the ROS environment
source /opt/ros/indigo/setup.bash
echo "source /opt/ros/indigo/setup.bash" >> ~/.bashrc
read -rsp $'Press any key to continue...\n' -n1 key

# Install couchdb
sudo apt-get install -y couchdb
read -rsp $'Press any key to continue...\n' -n1 key

# Create a catkin workspace to work in and install openag_brain in it
mkdir -p ~/catkin_ws/src
cd ~/catkin_ws/src
catkin_init_workspace
git clone https://github.com/OpenAgInitiative/openag_brain.git
cd ~/catkin_ws
catkin_make
catkin_make install
source devel/setup.bash
rosdep install -i -y openag_brain || exit 1
rosrun openag_brain install_pio
read -rsp $'Press any key to continue...\n' -n1 key
