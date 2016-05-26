##############################################################################
# search paths
##############################################################################
SET(FREEIMAGE_SEARCH_DIRS
  ${GLOBAL_EXT_DIR}/freeimage/include
  ${GLOBAL_EXT_DIR}/freeimage/lib
  ${FREEIMAGE_ROOT}/include
  ${FREEIMAGE_ROOT}/lib
  /usr/include
  /usr/lib
)

##############################################################################
# search
##############################################################################
message(STATUS "-- checking for FREEIMAGE")

find_path(FREEIMAGE_INCLUDE_DIR NAMES FreeImage.h PATHS ${FREEIMAGE_SEARCH_DIRS})

find_library(FREEIMAGE_LIBRARY NAMES FreeImage.lib freeimage PATHS ${FREEIMAGE_SEARCH_DIRS} PATH_SUFFIXES release)
find_library(FREEIMAGE_PLUS_LIBRARY NAMES FreeImagePlus.lib freeimageplus PATHS ${FREEIMAGE_SEARCH_DIRS} PATH_SUFFIXES release)

find_library(FREEIMAGE_LIBRARY_DEBUG NAMES FreeImaged.lib freeimage PATHS ${FREEIMAGE_SEARCH_DIRS} PATH_SUFFIXES debug)
find_library(FREEIMAGE_PLUS_LIBRARY_DEBUG NAMES FreeImagePlusd.lib FREEIMAGE3d.lib freeimageplus PATHS ${FREEIMAGE_SEARCH_DIRS} PATH_SUFFIXES debug)

get_filename_component(_FREEIMAGE_LIBRARY_DIR ${FREEIMAGE_LIBRARY} DIRECTORY)
get_filename_component(_FREEIMAGE_LIBRARY_DEBUG_DIR ${FREEIMAGE_LIBRARY_DEBUG} DIRECTORY)
set(FREEIMAGE_LIBRARY_DIR ${_FREEIMAGE_LIBRARY_DIR} ${_FREEIMAGE_LIBRARY_DEBUG_DIR} CACHE STRING "freeimage library path.")
