
# Copyright (c) 2012 Christopher Lux <christopherlux@gmail.com>
# Distributed under the Modified BSD License, see license.txt.

PROJECT(app_win32_device_test)

include(schism_project)
include(schism_macros)

# source files
scm_project_files(SOURCE_FILES      ${SRC_DIR} *.cpp)
scm_project_files(HEADER_FILES      ${SRC_DIR} *.h *.inl)

# include header and inline files in source files for visual studio projects
if (WIN32)
    if (MSVC)
        set (SOURCE_FILES ${SOURCE_FILES} ${HEADER_FILES} ${SHADER_FILES})
    endif (MSVC)
endif (WIN32)

include_directories(${SRC_DIR}
                    ${SCM_ROOT_DIR}/scm_core/src
                    ${SCM_ROOT_DIR}/scm_gl_core/src
                    ${SCM_ROOT_DIR}/scm_gl_util/src
				            ${GLUT_INCLUDE_DIR}
)

link_directories( ${SCM_ROOT_DIR} 
                  ${FREEIMAGE_LIBRARY_DIR})

# add/create library
add_executable(${PROJECT_NAME} ${SOURCE_FILES})

# link libraries
target_link_libraries(${PROJECT_NAME}
                      scm_core
                      scm_gl_core
                      scm_gl_util
	                    optimized ${FREEIMAGE_PLUS_LIBRARY} debug ${FREEIMAGE_PLUS_LIBRARY_DEBUG}
	                    optimized ${FREEIMAGE_LIBRARY} debug ${FREEIMAGE_LIBRARY_DEBUG}
	                    general ${FREETYPE_LIBRARY}
)

add_dependencies(${PROJECT_NAME}
                 scm_core
	               scm_gl_core
	               scm_gl_util
)

# custom copy and debugging actions
scm_copy_schism_libraries()
scm_copy_external_runtime_libraries()
scm_apply_debug_working_directory()