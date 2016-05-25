# boost (standard CMake script CMakeVersion > 3.0.2)
if (MSVC)
  set(Boost_USE_STATIC_LIBS ON)
  set(BOOST_ROOT ${GLOBAL_EXT_DIR}/boost)
  add_definitions( -DBOOST_ALL_NO_LIB )
endif (MSVC)

find_package(Boost 1.52 REQUIRED atomic date_time filesystem program_options regex system thread timer)
include_directories(${Boost_INCLUDE_DIR})

# freetype (standard CMake script CMakeVersion > 3.0.2)
if (WIN32 AND NOT DEFINED ENV{FREETYPE_DIR})
  set(ENV{FREETYPE_DIR} ${GLOBAL_EXT_DIR}/freetype )
endif()

message(STATUS "Searching freetype in FREETYPE_DIR=$ENV{FREETYPE_DIR}")
include (FindFreetype)

# freeimage (custom find script. FindFreeImage.cmake not in CMake standard scripts)
set(FREEIMAGE_ROOT ${GLOBAL_EXT_DIR}/freeimage )
include(FindFreeImage)

# freeglut (standard CMake script CMakeVersion > 3.0.2)
if (WIN32 AND NOT DEFINED ENV{GLUT_ROOT_PATH})
  set(GLUT_ROOT_PATH ${GLOBAL_EXT_DIR}/freeglut)
endif()
find_package(GLUT REQUIRED)

# Qt4 (standard CMake script CMakeVersion > 3.0.2)
list(APPEND CMAKE_PREFIX_PATH "${GLOBAL_EXT_DIR}/qt4")

set(QT_MOC_EXECUTABLE ${GLOBAL_EXT_DIR}/qt4/bin/moc.exe)
set(QT_UIC_EXECUTABLE ${GLOBAL_EXT_DIR}/qt4/bin/uic.exe)
set(QT_RCC_EXECUTABLE ${GLOBAL_EXT_DIR}/qt4/bin/rcc.exe)
set(QT_QMAKE_EXECUTABLE ${GLOBAL_EXT_DIR}/qt4/bin/qmake.exe)

find_package(Qt4 4.4.3 REQUIRED QtGui QtOpenGL QtCore)

if (QT_QTCORE_INCLUDE_DIR)
  set(QT4_INCLUDE_DIR ${QT_QTCORE_INCLUDE_DIR}/.. CACHE STRING "Qt4 include directory.")
endif()

# Qt5 (standard CMake script CMakeVersion > 3.0.2)
if (WIN32)
  list(APPEND CMAKE_PREFIX_PATH "${GLOBAL_EXT_DIR}/Qt5/lib/cmake")
endif ()

find_package(Qt5OpenGL REQUIRED)
find_package(Qt5Core REQUIRED)
find_package(Qt5Gui REQUIRED)
find_package(Qt5Widgets REQUIRED)

get_target_property(QtCore_location Qt5::Core LOCATION)

# CUDA and OpenCL
if (${SCM_ENABLE_CUDA_CL_SUPPORT}) 
  if (WIN32 AND NOT DEFINED ENV{CUDA_TOOLKIT_ROOT_DIR})
	set(CUDA_TOOLKIT_ROOT_DIR ${GLOBAL_EXT_DIR}/cuda)
  endif()
  include(FindCUDA)

  if (WIN32 AND NOT DEFINED ENV{CUDA_PATH})
    set(ENV{CUDA_PATH} ${CUDA_TOOLKIT_ROOT_DIR})
  endif()
  include(FindOpenCL)
endif()


