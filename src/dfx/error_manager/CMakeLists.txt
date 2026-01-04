# Copyright (c) 2025 Huawei Technologies Co., Ltd.
# This program is free software, you can redistribute it and/or modify it under the terms and conditions of
# CANN Open Software License Agreement Version 2.0 (the "License").
# Please refer to the License for details. You may not use this file except in compliance with the License.
# THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
# INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
# See LICENSE in the root of the software repository for the full text of the License.
# ===================================================================================================================

cmake_minimum_required(VERSION 3.14.1)

include(${BASE_DIR}/cmake/common_funcs.cmake)

set(ERRMGR_DIR ${CMAKE_CURRENT_LIST_DIR})

set(SRC_LIST
    "error_manager.cc"
)

############ liberror_manager.so ############
add_library(error_manager SHARED ${SRC_LIST})

target_compile_options(error_manager PRIVATE
    $<$<STREQUAL:${TARGET_SYSTEM_NAME},Linux>:-Werror -fno-common -Wextra -Wfloat-equal -O2>
    $<$<AND:$<STREQUAL:${TARGET_SYSTEM_NAME},Windows>,$<STREQUAL:${CMAKE_CONFIGURATION_TYPES},Debug>>:/MTd>
    $<$<AND:$<STREQUAL:${TARGET_SYSTEM_NAME},Windows>,$<STREQUAL:${CMAKE_CONFIGURATION_TYPES},Release>>:/MT>
)

target_include_directories(error_manager PRIVATE
    ${CMAKE_CURRENT_LIST_DIR}
    ${BASE_DIR}/include/dfx
)

target_link_libraries(error_manager PRIVATE
        $<BUILD_INTERFACE:intf_pub>
        $<BUILD_INTERFACE:c_sec_headers>
        static_mmpa
        -Wl,--no-as-needed
        c_sec
        unified_dlog
        -Wl,--as-needed
        json
        $<$<NOT:$<STREQUAL:${TARGET_SYSTEM_NAME},Android>>:-lrt>
        -ldl
)

set_target_properties(error_manager PROPERTIES
    OUTPUT_NAME $<IF:$<STREQUAL:${TARGET_SYSTEM_NAME},Windows>,liberror_manager,error_manager>
    WINDOWS_EXPORT_ALL_SYMBOLS TRUE
)

target_clone(error_manager error_manager_static STATIC)

target_compile_definitions(error_manager_static PRIVATE
    $<$<STREQUAL:${ENABLE_OPEN_SRC},True>:ONLY_COMPILE_OPEN_SRC>
    LOG_CPP
    )

set_target_properties(error_manager_static PROPERTIES
    OUTPUT_NAME error_manager
)

if(NOT TARGET_SYSTEM_NAME STREQUAL "Windows")
    install(TARGETS error_manager_static
        ARCHIVE DESTINATION ${INSTALL_LIBRARY_DIR} OPTIONAL
    )
endif()

##############################################################
set(STUB_SRC_LIST
    ${CMAKE_CURRENT_BINARY_DIR}/stub_error_manager.cc
    ${CMAKE_CURRENT_BINARY_DIR}/stub_err_msg.cc
    ${CMAKE_CURRENT_BINARY_DIR}/stub_err_mgr.cc
)

add_custom_command(
    OUTPUT ${STUB_SRC_LIST}
    COMMAND echo "Generating stub files."
            && ${RUNTIME_PYTHON} ${ERRMGR_DIR}/stub/gen_stubapi.py ${ERRMGR_DIR} ${CMAKE_CURRENT_BINARY_DIR}
            && ${RUNTIME_PYTHON} ${ERRMGR_DIR}/stub/gen_stubapi.py ${BASE_DIR}/include/dfx ${CMAKE_CURRENT_BINARY_DIR}
            && ${RUNTIME_PYTHON} ${ERRMGR_DIR}/stub/gen_stubapi.py ${BASE_DIR}/pkg_inc ${CMAKE_CURRENT_BINARY_DIR}
            && echo "Generating stub files end."
)

add_custom_target(error_manager_stub DEPENDS ${STUB_SRC_LIST})

############ stub/liberror_manager.so ############
add_library(stub_error_manager SHARED ${STUB_SRC_LIST})

add_dependencies(stub_error_manager error_manager_stub)

target_include_directories(stub_error_manager PRIVATE
    ${ERRMGR_DIR}
    ${BASE_DIR}/include/dfx
    ${BASE_DIR}/pkg_inc
)

target_compile_options(stub_error_manager PRIVATE
    -Wfloat-equal
    -fno-common
    -Werror=return-type
)

target_link_libraries(stub_error_manager PRIVATE
        $<BUILD_INTERFACE:intf_pub>
        $<BUILD_INTERFACE:c_sec_headers>
        c_sec
        unified_dlog
        json
)

set_target_properties(stub_error_manager PROPERTIES
    OUTPUT_NAME error_manager
    LIBRARY_OUTPUT_DIRECTORY stub
)

############ install ############
install(TARGETS stub_error_manager OPTIONAL
    LIBRARY DESTINATION ${INSTALL_LIBRARY_DIR}/${CMAKE_SYSTEM_PROCESSOR}/stub
)
