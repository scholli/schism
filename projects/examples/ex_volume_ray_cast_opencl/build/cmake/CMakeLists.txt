
# Copyright (c) 2012 Christopher Lux <christopherlux@gmail.com>
# Distributed under the Modified BSD License, see license.txt.

project(ex_volume_ray_cast_opencl)

include(schism_project)
include(schism_macros)

IF (NOT ${SCM_ENABLE_CUDA_CL_SUPPORT})
  message("Warning: Ignoring target ex_volume_ray_cast_opencl: Please enable SCM_ENABLE_CUDA_CL_SUPPORT to build this example.")
  return()
ENDIF (NOT ${SCM_ENABLE_CUDA_CL_SUPPORT})

# source files
scm_project_files(SOURCE_FILES      ${SRC_DIR} *.cpp)
scm_project_files(HEADER_FILES      ${SRC_DIR} *.h *.inl)

scm_project_files(SOURCE_FILES_GUI  ${SRC_DIR}/application *.cpp)
scm_project_files(HEADER_FILES_GUI  ${SRC_DIR}/application *.h *.inl)
scm_project_files(SOURCE_FILES_GUI  ${SRC_DIR}/application/volume_gui *.cpp)
scm_project_files(HEADER_FILES_GUI  ${SRC_DIR}/application/volume_gui *.h *.inl)

scm_project_files(SOURCE_FILES_GUI  ${SRC_DIR}/gui_support *.cpp)
scm_project_files(HEADER_FILES_GUI  ${SRC_DIR}/gui_support *.h *.inl)

scm_project_files(SOURCE_FILES      ${SRC_DIR}/renderer *.cpp)
scm_project_files(HEADER_FILES      ${SRC_DIR}/renderer *.h *.inl)
scm_project_files(SHADER_FILES      ${SRC_DIR}/renderer/shader *.glsl *.glslh *.glslf *.glslv *glslg *.glsltc *.glslte)
scm_project_files(KERNEL_FILES      ${SRC_DIR}/renderer/kernel *.cl *.clh)

QT4_WRAP_CPP(GENERATED_MOC_OUTPUT ${HEADER_FILES_GUI})

list(APPEND HEADER_FILES ${HEADER_FILES_GUI})
list(APPEND SOURCE_FILES ${SOURCE_FILES_GUI} ${GENERATED_MOC_OUTPUT})
						 
# include header and inline files in source files for visual studio projects
if (WIN32)
    if (MSVC)
        set (SOURCE_FILES ${SOURCE_FILES} ${HEADER_FILES} ${SHADER_FILES} ${KERNEL_FILES})
    endif (MSVC)
endif (WIN32)

# set include and lib directories
include_directories(${SRC_DIR}
                    ${SCM_ROOT_DIR}/scm_core/src
                    ${SCM_ROOT_DIR}/scm_gl_core/src
					          ${SCM_ROOT_DIR}/scm_cl_core/src
                    ${SCM_ROOT_DIR}/scm_gl_util/src
					          ${SCM_ROOT_DIR}/scm_input/src
					          ${QT4_INCLUDE_DIR}
					          ${OpenCL_INCLUDE_DIR}
)

# set library directories
scm_project_link_directories(ALL      ${SCM_LIB_DIR}/${SCHISM_PLATFORM})

# add/create library
add_executable(${PROJECT_NAME} ${SOURCE_FILES})

# link libraries
target_link_libraries(${PROJECT_NAME}
                      general scm_core
                      general scm_gl_core
                      general scm_gl_util
	                    ${QT_QTCORE_LIBRARY}
	                    ${QT_QTGUI_LIBRARY}
)

if (${SCM_ENABLE_CUDA_CL_SUPPORT})
  target_link_libraries(${PROJECT_NAME} ${OpenCL_LIBRARY})
endif (${SCM_ENABLE_CUDA_CL_SUPPORT})

add_dependencies(${PROJECT_NAME}
                 scm_core
                 scm_cl_core
                 scm_gl_core
                 scm_gl_util
)

# custom copy and debugging actions
scm_copy_schism_libraries()
scm_copy_external_runtime_libraries()
scm_apply_debug_working_directory()