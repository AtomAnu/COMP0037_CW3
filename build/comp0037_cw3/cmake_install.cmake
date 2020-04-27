# Install script for directory: /home/ros_user/COMP0037_CW3/src/comp0037_cw3

# Set the install prefix
if(NOT DEFINED CMAKE_INSTALL_PREFIX)
  set(CMAKE_INSTALL_PREFIX "/home/ros_user/COMP0037_CW3/install")
endif()
string(REGEX REPLACE "/$" "" CMAKE_INSTALL_PREFIX "${CMAKE_INSTALL_PREFIX}")

# Set the install configuration name.
if(NOT DEFINED CMAKE_INSTALL_CONFIG_NAME)
  if(BUILD_TYPE)
    string(REGEX REPLACE "^[^A-Za-z0-9_]+" ""
           CMAKE_INSTALL_CONFIG_NAME "${BUILD_TYPE}")
  else()
    set(CMAKE_INSTALL_CONFIG_NAME "")
  endif()
  message(STATUS "Install configuration: \"${CMAKE_INSTALL_CONFIG_NAME}\"")
endif()

# Set the component getting installed.
if(NOT CMAKE_INSTALL_COMPONENT)
  if(COMPONENT)
    message(STATUS "Install component: \"${COMPONENT}\"")
    set(CMAKE_INSTALL_COMPONENT "${COMPONENT}")
  else()
    set(CMAKE_INSTALL_COMPONENT)
  endif()
endif()

# Install shared libraries without execute permission?
if(NOT DEFINED CMAKE_INSTALL_SO_NO_EXE)
  set(CMAKE_INSTALL_SO_NO_EXE "1")
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/pkgconfig" TYPE FILE FILES "/home/ros_user/COMP0037_CW3/build/comp0037_cw3/catkin_generated/installspace/comp0037_cw3.pc")
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/comp0037_cw3/cmake" TYPE FILE FILES
    "/home/ros_user/COMP0037_CW3/build/comp0037_cw3/catkin_generated/installspace/comp0037_cw3Config.cmake"
    "/home/ros_user/COMP0037_CW3/build/comp0037_cw3/catkin_generated/installspace/comp0037_cw3Config-version.cmake"
    )
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/comp0037_cw3" TYPE FILE FILES "/home/ros_user/COMP0037_CW3/src/comp0037_cw3/package.xml")
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/comp0037_cw3" TYPE FILE FILES
    "/home/ros_user/COMP0037_CW3/src/comp0037_cw3/launch/test_obstacler_factory.launch"
    "/home/ros_user/COMP0037_CW3/src/comp0037_cw3/launch/part2_drive_factory_obstacles_sometimes.launch"
    "/home/ros_user/COMP0037_CW3/src/comp0037_cw3/launch/test_obstacler_factory_sometimes_obstacles.launch"
    "/home/ros_user/COMP0037_CW3/src/comp0037_cw3/launch/part2_drive_factory.launch"
    )
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/comp0037_cw3" TYPE FILE FILES
    "/home/ros_user/COMP0037_CW3/src/comp0037_cw3/scenarios/simple_maps/simple_plus_goal.txt"
    "/home/ros_user/COMP0037_CW3/src/comp0037_cw3/scenarios/simple_maps/simple_walls_goal.txt"
    "/home/ros_user/COMP0037_CW3/src/comp0037_cw3/scenarios/factory/part2_goals.txt"
    "/home/ros_user/COMP0037_CW3/src/comp0037_cw3/scenarios/factory/obstacler_test_sometimes_obstacles.txt"
    "/home/ros_user/COMP0037_CW3/src/comp0037_cw3/scenarios/factory/part2_obstacles.txt"
    "/home/ros_user/COMP0037_CW3/src/comp0037_cw3/scenarios/factory/obstacler_test_obstacles.txt"
    "/home/ros_user/COMP0037_CW3/src/comp0037_cw3/scenarios/factory/obstacler_test_goals.txt"
    "/home/ros_user/COMP0037_CW3/src/comp0037_cw3/scenarios/factory/part2_obstacles_sometimes.txt"
    )
endif()

