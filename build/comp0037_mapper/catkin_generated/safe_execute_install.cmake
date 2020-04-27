execute_process(COMMAND "/home/ros_user/COMP0037_CW3/build/comp0037_mapper/catkin_generated/python_distutils_install.sh" RESULT_VARIABLE res)

if(NOT res EQUAL 0)
  message(FATAL_ERROR "execute_process(/home/ros_user/COMP0037_CW3/build/comp0037_mapper/catkin_generated/python_distutils_install.sh) returned error code ")
endif()
