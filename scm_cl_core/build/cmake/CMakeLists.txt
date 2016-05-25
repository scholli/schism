
# Copyright (c) 2012 Christopher Lux <christopherlux@gmail.com>
# Distributed under the Modified BSD License, see license.txt.

project(scm_cl_core)

include(schism_macros)

#option(SCHISM_ENABLE_OPENCL         "Enable Use of OpenCL"                OFF)

set(SRC_DIR                         "${scm_cl_core_SOURCE_DIR}/../../src/scm")
set(SCM_PROJECT_SOURCE_DIR          ${SRC_DIR})

set(CMAKE_RUNTIME_OUTPUT_DIRECTORY  ${SCHISM_LIBRARY_DIR})
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY  ${SCHISM_LIBRARY_DIR})
set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY  ${SCHISM_LIBRARY_DIR})

# source files
scm_project_files(SOURCE_FILES      ${SRC_DIR} *.cpp)
scm_project_files(HEADER_FILES      ${SRC_DIR} *.h *.inl)

scm_project_files(SOURCE_FILES      ${SRC_DIR}/cl_core *.cpp)
scm_project_files(HEADER_FILES      ${SRC_DIR}/cl_core *.h *.inl)

#if (SCHISM_ENABLE_OPENCL)
    scm_project_files(SOURCE_FILES      ${SRC_DIR}/cl_core/opencl *.cpp)
    scm_project_files(HEADER_FILES      ${SRC_DIR}/cl_core/opencl *.h *.inl)
#endif (SCHISM_ENABLE_OPENCL)

scm_project_files(SOURCE_FILES      ${SRC_DIR}/cl_core/cuda *.cpp)
scm_project_files(HEADER_FILES      ${SRC_DIR}/cl_core/cuda *.h *.inl)

# include header and inline files in source files for visual studio projects
if (WIN32)
    if (MSVC)
        set (SOURCE_FILES ${SOURCE_FILES} ${HEADER_FILES})
    endif (MSVC)
endif (WIN32)


# set include and lib directories
include_directories(${SCM_ROOT_DIR}/scm_core/src
                    ${SCM_ROOT_DIR}/scm_cl_core/src
					          ${CUDA_TOOLKIT_INCLUDE})

if (WIN32)
    # add preprocessor defines
    add_definitions(-DSCM_BUILD_LIBRARY_cl_core=\(\))
endif (WIN32)

# add/create library
if (SCHISM_BUILD_STATIC)
    add_definitions(-DSCM_STATIC_BUILD)
	add_library(${PROJECT_NAME} STATIC ${SOURCE_FILES})
else (SCHISM_BUILD_STATIC)
	add_library(${PROJECT_NAME} SHARED ${SOURCE_FILES})
endif (SCHISM_BUILD_STATIC)

# set library directories
target_link_libraries( ${PROJECT_NAME} 
				               scm_core
					             scm_gl_core
					            )

set_target_properties( ${PROJECT_NAME} 
                PROPERTIES
                DEBUG_OUTPUT_NAME ${PROJECT_NAME}${SCHISM_DEBUG_LIBRARY_EXTENSION}
                RELEASE_OUTPUT_NAME ${PROJECT_NAME}
)

# link libraries
target_link_libraries(${PROJECT_NAME} 
					  scm_core)

add_dependencies(${PROJECT_NAME}
    scm_core
)

