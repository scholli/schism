
# Copyright (c) 2012 Christopher Lux <christopherlux@gmail.com>
# Distributed under the Modified BSD License, see license.txt.

project(ex_atomic_counters)

include(schism_project)
include(schism_macros)

# source files
scm_project_files(SOURCE_FILES      ${SRC_DIR} *.cpp)
scm_project_files(HEADER_FILES      ${SRC_DIR} *.h *.inl)

scm_project_files(SOURCE_FILES_GUI  ${SRC_DIR}/application *.cpp)
scm_project_files(HEADER_FILES_GUI  ${SRC_DIR}/application *.h *.inl)

scm_project_files(SOURCE_FILES_GUI  ${SRC_DIR}/gui_support *.cpp)
scm_project_files(HEADER_FILES_GUI  ${SRC_DIR}/gui_support *.h *.inl)

scm_project_files(SHADER_FILES      ${SRC_DIR}/shaders *.glsl *.glslh *.glslf *.glslv *glslg *.glsltc *.glslte)

set(APPLICATION_QT4_MOC ${SRC_DIR}/application/application_moc.cpp)
set(VIEWER_WINDOW_QT4_MOC ${SRC_DIR}/gui_support/viewer_window_moc.cpp)
set(VIEWER_WIDGET_QT4_MOC ${SRC_DIR}/gui_support/viewer_widget_moc.cpp)

QT4_GENERATE_MOC(${SRC_DIR}/application/application.h ${APPLICATION_QT4_MOC})
QT4_GENERATE_MOC(${SRC_DIR}/gui_support/viewer_window.h ${VIEWER_WINDOW_QT4_MOC})
QT4_GENERATE_MOC(${SRC_DIR}/gui_support/viewer_widget.h ${VIEWER_WIDGET_QT4_MOC})

list(APPEND HEADER_FILES ${HEADER_FILES_GUI})
list(APPEND SOURCE_FILES ${SOURCE_FILES_GUI} ${APPLICATION_QT4_MOC} ${VIEWER_WINDOW_QT4_MOC}  ${VIEWER_WIDGET_QT4_MOC})

# include header and inline files in source files for visual studio projects
if (WIN32)
    if (MSVC)
        set (SOURCE_FILES ${SOURCE_FILES} ${HEADER_FILES} ${SHADER_FILES} ${APPLICATION_QT4_MOC})
    endif (MSVC)
endif (WIN32)

# set include and lib directories
include_directories( ${SRC_DIR}
                     ${SCM_ROOT_DIR}/scm_core/src
                     ${SCM_ROOT_DIR}/scm_gl_core/src
                     ${SCM_ROOT_DIR}/scm_gl_util/src
                     ${SCM_ROOT_DIR}/scm_input/src
					           ${QT4_INCLUDE_DIR}
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
                      general scm_input
	                    optimized ${Boost_FILESYSTEM_LIBRARY_RELEASE}  debug ${Boost_FILESYSTEM_LIBRARY_DEBUG}
                      optimized ${Boost_THREAD_LIBRARY_RELEASE}  debug ${Boost_THREAD_LIBRARY_DEBUG}
                      optimized ${Boost_PROGRAM_OPTIONS_LIBRARY_RELEASE}  debug ${Boost_PROGRAM_OPTIONS_LIBRARY_DEBUG}
	                    optimized ${FREEIMAGE_PLUS_LIBRARY} debug ${FREEIMAGE_PLUS_LIBRARY_DEBUG}
	                    optimized ${FREEIMAGE_LIBRARY} debug ${FREEIMAGE_LIBRARY_DEBUG}
	                    ${QT_QTCORE_LIBRARY}
                      ${QT_QTGUI_LIBRARY}
)

if (${SCM_ENABLE_CUDA_CL_SUPPORT})
  target_link_libraries(${PROJECT_NAME} ${OpenCL_LIBRARY})
endif (${SCM_ENABLE_CUDA_CL_SUPPORT})

add_dependencies(${PROJECT_NAME}
                 scm_core
                 scm_gl_core
                 scm_gl_util
                 scm_input
)

# custom copy and debugging actions
scm_copy_schism_libraries()
scm_copy_external_runtime_libraries()
scm_apply_debug_working_directory()