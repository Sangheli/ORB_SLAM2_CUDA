cmake_minimum_required(VERSION  2.8.0)
project(orb_slam2_cuda)

#add_compile_options(-std=c++11)
#set (CMAKE_CXX_STANDARD 11)
#set (CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++11")

set(CMAKE_CXX_STANDARD 11)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)

add_compile_options(-std=c++11)
add_definitions ("-w")

LIST(APPEND CMAKE_MODULE_PATH ${PROJECT_SOURCE_DIR}/../../../cmake_modules)

find_package(OpenCV 3.4.0 REQUIRED)
find_package(Eigen )
find_package(Pangolin REQUIRED)
find_package(PCL REQUIRED)
find_package(CUDA REQUIRED)

## is used, also find other catkin packages
find_package(catkin REQUIRED COMPONENTS
  message_filters
  roscpp
  rospy
  nav_msgs
  sensor_msgs
  std_msgs
  pcl_conversions
  pcl_ros
  cv_bridge
  dynamic_reconfigure
  image_transport
)

catkin_package()

include_directories(  ${catkin_INCLUDE_DIRS}  ${PCL_INCLUDE_DIRS} )
link_directories(${PCL_LIBRARY_DIRS})
add_definitions(${PCL_DEFINITIONS})

#generate_dynamic_reconfigure_options(
#  cfg/orbslam.cfg
#)



include_directories(
${catkin_INCLUDE_DIRS}
${PROJECT_SOURCE_DIR}
${PROJECT_SOURCE_DIR}/lib
#${PROJECT_SOURCE_DIR}/include
${PROJECT_SOURCE_DIR}/../../../../
${PROJECT_SOURCE_DIR}/../../../../include
${Pangolin_INCLUDE_DIRS}
${PCL_INCLUDE_DIRS}
${CUDA_INCLUDE_DIRS}
)

set(LIBS
${catkin_LIBRARIES}
${OpenCV_LIBS} 
${EIGEN3_LIBS}
${Pangolin_LIBRARIES}
${PCL_LIBRARIES}
${PROJECT_SOURCE_DIR}/../../../../Thirdparty/DBoW2/lib/libDBoW2.so
${PROJECT_SOURCE_DIR}/../../../../Thirdparty/g2o/lib/libg2o.so
${PROJECT_SOURCE_DIR}/../../../../lib/libORB_SLAM2_CUDA.so
-lboost_system
)

#add_executable(MonoPub src/ros_mono_pub.cc)
#target_link_libraries(MonoPub ${LIBS})


# Node for monocular camera
add_executable(Mono
lib/SlamData.cc
src/ros_mono.cc
)
target_link_libraries(Mono ${LIBS})

# Node for stereo camera
add_executable(Stereo src/ros_stereo.cc)
target_link_libraries(Stereo ${LIBS})

# Node for RGB-D camera
add_executable(RGBD src/ros_rgbd.cc)
target_link_libraries(RGBD ${LIBS})