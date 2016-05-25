
# Copyright (c) 2012 Christopher Lux <christopherlux@gmail.com>
# Distributed under the Modified BSD License, see license.txt.

project(ex_glut_volume_ray_casting)

include(schism_project)
include(schism_macros)

# source files
scm_project_files(SOURCE_FILES      ${SRC_DIR} *.cpp)
scm_project_files(HEADER_FILES      ${SRC_DIR} *.h *.inl)

scm_project_files(SHADER_FILES      ${SRC_DIR}/shaders *.glsl *.glslf *.glslv *.glslg)

# include header and inline files in source files for visual studio projects
if (WIN32)
    if (MSVC)
        set (SOURCE_FILES ${SOURCE_FILES} ${HEADER_FILES} ${SHADER_FILES})
    endif (MSVC)
endif (WIN32)

# set include and lib directories
include_directories(${SRC_DIR}
                    ${SCM_ROOT_DIR}/scm_core/src
                    ${SCM_ROOT_DIR}/scm_gl_core/src
                    ${SCM_ROOT_DIR}/scm_gl_util/src
                    ${GLUT_INCLUDE_DIR}
)

scm_project_link_directories(ALL   ${SCM_LIB_DIR}/${SCHISM_PLATFORM})

# add/create library
add_executable(${PROJECT_NAME} ${SOURCE_FILES})

# link libraries
target_link_libraries(${PROJECT_NAME}
                      general scm_core
                      general scm_gl_core
                      general scm_gl_util
	                    ${GLUT_glut_LIBRARY}
)

if (${SCM_ENABLE_CUDA_CL_SUPPORT})
  target_link_libraries(${PROJECT_NAME} ${OpenCL_LIBRARY})
endif (${SCM_ENABLE_CUDA_CL_SUPPORT})

add_dependencies(${PROJECT_NAME}
    scm_core
    scm_gl_core
    scm_gl_util
)

# custom copy and debugging actions
scm_copy_schism_libraries()
scm_copy_external_runtime_libraries()
scm_apply_debug_working_directory()