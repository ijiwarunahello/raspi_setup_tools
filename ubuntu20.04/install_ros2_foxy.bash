#!/bin/bash
# install ros2
sudo apt update && sudo apt install curl gnupg2 lsb-release
curl -s https://raw.githubusercontent.com/ros/rosdistro/master/ros.asc | sudo apt-key add -
sudo sh -c 'echo "deb [arch=$(dpkg --print-architecture)] http://packages.ros.org/ros2/ubuntu $(lsb_release -cs) main" > /etc/apt/sources.list.d/ros2-latest.list'
sudo apt update
sudo apt install ros-foxy-ros-base -y
echo "source /opt/ros/foxy/setup.bash" >> ~/.bashrc
source ~/.bashrc

sudo apt install python3-argcomplete -y
sudo apt install python3-rodep -y
sudo apt install libpython3-dev -y
sudo apt install build-essential
sudo rosdep init
rosdep update

# setting ros2 workspace
mkdir -p ~/ros2/src
cd ~/ros2/src
git clone https://github.com/ros2/examples ros2_examples
cd ~/ros2/src/ros2_examples
git checkout $ROS_DISTRO
# install colcon
$ sudo apt install python3-colcon-common-extensions -y
# build
cd ~/ros2
rosdep install --from-paths src --ignore-src --rosdistro foxy -y --skip-keys "console_bridge fastcdr fastrtps osrf_testing_tools_cpp poco_vendor rmw_connext_cpp rosidl_typesupport_connext_c rosidl_typesupport_connext_cpp rti-connext-dds-5.3.1 tinyxml_vendor tinyxml2_vendor urdfdom urdfdom_headers"
colcon build --symlink-install --parallel-workers 1
echo "source ~/ros2/install/setup.bash" >> ~/.bashrc
source ~/.bashrc
