
# Copyright (c) 2012 Christopher Lux <christopherlux@gmail.com>
# Distributed under the Modified BSD License, see license.txt.

project(scm_gl_util)

include(schism_macros)

set(SRC_DIR                         "${scm_gl_util_SOURCE_DIR}/../../src/scm")
set(SCM_PROJECT_SOURCE_DIR          ${SRC_DIR})

set(CMAKE_RUNTIME_OUTPUT_DIRECTORY  ${SCHISM_LIBRARY_DIR})
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY  ${SCHISM_LIBRARY_DIR})
set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY  ${SCHISM_LIBRARY_DIR})

# source files
scm_project_files(SOURCE_FILES      ${SRC_DIR} *.cpp)
scm_project_files(HEADER_FILES      ${SRC_DIR} *.h *.inl)

scm_project_files(SOURCE_FILES      ${SRC_DIR}/gl_util *.cpp)
scm_project_files(HEADER_FILES      ${SRC_DIR}/gl_util *.h *.inl)

scm_project_files(SOURCE_FILES      ${SRC_DIR}/gl_util/font *.cpp)
scm_project_files(HEADER_FILES      ${SRC_DIR}/gl_util/font *.h *.inl)
scm_project_files(SOURCE_FILES      ${SRC_DIR}/gl_util/font/detail *.cpp)
scm_project_files(HEADER_FILES      ${SRC_DIR}/gl_util/font/detail *.h *.inl)

scm_project_files(SOURCE_FILES      ${SRC_DIR}/gl_util/data/analysis *.cpp)
scm_project_files(HEADER_FILES      ${SRC_DIR}/gl_util/data/analysis *.h *.inl)
scm_project_files(SOURCE_FILES      ${SRC_DIR}/gl_util/data/analysis/transfer_function *.cpp)
scm_project_files(HEADER_FILES      ${SRC_DIR}/gl_util/data/analysis/transfer_function *.h *.inl)
scm_project_files(SOURCE_FILES      ${SRC_DIR}/gl_util/data/imaging *.cpp)
scm_project_files(HEADER_FILES      ${SRC_DIR}/gl_util/data/imaging *.h *.inl)

scm_project_files(SOURCE_FILES      ${SRC_DIR}/gl_util/data/volume *.cpp)
scm_project_files(HEADER_FILES      ${SRC_DIR}/gl_util/data/volume *.h *.inl)
scm_project_files(SOURCE_FILES      ${SRC_DIR}/gl_util/data/volume/vgeo *.cpp)
scm_project_files(HEADER_FILES      ${SRC_DIR}/gl_util/data/volume/vgeo *.h *.inl)
scm_project_files(SOURCE_FILES      ${SRC_DIR}/gl_util/data/volume/segy *.cpp)
scm_project_files(HEADER_FILES      ${SRC_DIR}/gl_util/data/volume/segy *.h *.inl)

scm_project_files(SOURCE_FILES      ${SRC_DIR}/gl_util/manipulators *.cpp)
scm_project_files(HEADER_FILES      ${SRC_DIR}/gl_util/manipulators *.h *.inl)

scm_project_files(SOURCE_FILES      ${SRC_DIR}/gl_util/primitives *.cpp)
scm_project_files(HEADER_FILES      ${SRC_DIR}/gl_util/primitives *.h *.inl)
scm_project_files(SOURCE_FILES      ${SRC_DIR}/gl_util/primitives/util *.cpp)
scm_project_files(HEADER_FILES      ${SRC_DIR}/gl_util/primitives/util *.h *.inl)

scm_project_files(SOURCE_FILES      ${SRC_DIR}/gl_util/utilities *.cpp)
scm_project_files(HEADER_FILES      ${SRC_DIR}/gl_util/utilities *.h *.inl)

scm_project_files(SOURCE_FILES      ${SRC_DIR}/gl_util/viewer *.cpp)
scm_project_files(HEADER_FILES      ${SRC_DIR}/gl_util/viewer *.h *.inl)


# include header and inline files in source files for visual studio projects
if (WIN32)
    if (MSVC)
        set (SOURCE_FILES ${SOURCE_FILES} ${HEADER_FILES})
    endif (MSVC)
endif (WIN32)

# set include and lib directories
include_directories(${SCM_ROOT_DIR}/scm_core/src
                    ${SCM_ROOT_DIR}/scm_cl_core/src
                    ${SCM_ROOT_DIR}/scm_gl_core/src
                    ${SCM_ROOT_DIR}/scm_gl_util/src
                    ${SCM_ROOT_DIR}/scm_input/src
					${FREEIMAGE_INCLUDE_DIR}
				    ${FREETYPE_INCLUDE_DIR_freetype2}
				${FREETYPE_INCLUDE_DIR_ft2build}
					${CUDA_TOOLKIT_INCLUDE})

# set library directories
link_directories(${SCM_LIB_DIR}/${SCHISM_PLATFORM})

if (WIN32)
    # add preprocessor defines
    add_definitions(-DSCM_BUILD_LIBRARY_gl_util=\(\))
endif (WIN32)

# add/create library
if (SCHISM_BUILD_STATIC)
    add_definitions(-DSCM_STATIC_BUILD)
	add_library(${PROJECT_NAME} STATIC ${SOURCE_FILES})
else (SCHISM_BUILD_STATIC)
	add_library(${PROJECT_NAME} SHARED ${SOURCE_FILES})
endif (SCHISM_BUILD_STATIC)

set_target_properties( ${PROJECT_NAME} 
                PROPERTIES
                DEBUG_OUTPUT_NAME ${PROJECT_NAME}${SCHISM_DEBUG_LIBRARY_EXTENSION}
                RELEASE_OUTPUT_NAME ${PROJECT_NAME}
)

# link libraries
target_link_libraries(${PROJECT_NAME}
					  general scm_core
					  general scm_gl_core
					  general scm_input
					  optimized ${FREEIMAGE_PLUS_LIBRARY} debug ${FREEIMAGE_PLUS_LIBRARY_DEBUG}
					  optimized ${FREEIMAGE_LIBRARY} debug ${FREEIMAGE_LIBRARY_DEBUG}
					  optimized ${FREETYPE_LIBRARY_RELEASE} debug ${FREETYPE_LIBRARY_DEBUG}
)

add_dependencies(${PROJECT_NAME}
    scm_core
    scm_gl_core
    scm_input
)

IF (${SCM_ENABLE_CUDA_CL_SUPPORT})
	add_dependencies(${PROJECT_NAME}
		scm_cl_core
	)
  target_link_libraries(${PROJECT_NAME}
      scm_cl_core
	  general ${CUDA_CUDA_LIBRARY}
	  general ${CUDA_CUDART_LIBRARY}
  )
ENDIF (${SCM_ENABLE_CUDA_CL_SUPPORT})
