#!/usr/bin/env bash
echo "Building ROS nodes"

cd Examples/ROS/
#rm -rf build
#rm -rf devel
catkin_make

cd src/ORB_SLAM2_CUDA
mkdir Vocabulary
cd ..
cd ..
cd ..
cd ..
cp Vocabulary/ORBvoc.txt Examples/ROS/src/ORB_SLAM2_CUDA/Vocabulary/
