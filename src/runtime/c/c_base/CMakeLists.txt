# -----------------------------------------------------------------------------------------------------------
# Copyright (c) 2025 Huawei Technologies Co., Ltd.
# This program is free software, you can redistribute it and/or modify it under the terms and conditions of
# CANN Open Software License Agreement Version 2.0 (the "License").
# Please refer to the License for details. You may not use this file except in compliance with the License.
# THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
# INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
# See LICENSE in the root of the software repository for the full text of the License.
# -----------------------------------------------------------------------------------------------------------
include(${CMAKE_CURRENT_SOURCE_DIR}/c_base_headers.cmake)
include(${CMAKE_CURRENT_SOURCE_DIR}/../liteos_headers.cmake)
#------------------------- c_base -------------------------
set(C_BASE_SRC
    src/vector.c
    src/sort_vector.c
    src/mem_pool.c
    src/ref_obj.c
    $<$<STREQUAL:${TARGET_SYSTEM_NAME},Linux>:src/error_manager.c>
)

add_library(c_base_static STATIC
    ${C_BASE_SRC}
)

target_compile_definitions(c_base_static PRIVATE
    $<IF:$<STREQUAL:${TARGET_SYSTEM_NAME},LiteOS>,NANO_OS_TYPE=1,NANO_OS_TYPE=0>
)

target_link_libraries(c_base_static
    PRIVATE
        $<BUILD_INTERFACE:intf_pub>
        c_sec_headers
)

message(STATUS "LiteOS file header path ${NANO_LITEOS_HEADER_FILES_PATH}")
target_include_directories(c_base_static PRIVATE
    ${CMAKE_CURRENT_SOURCE_DIR}/../c_mmpa/inc
    ${CMAKE_CURRENT_SOURCE_DIR}/inc
    $<BUILD_INTERFACE:${CMAKE_CURRENT_LIST_DIR}/../stub/inc>
    $<$<STREQUAL:${TARGET_SYSTEM_NAME},LiteOS>:$<BUILD_INTERFACE:${NANO_LITEOS_HEADER_FILES_PATH}>>
)

target_compile_options(c_base_static PRIVATE
    -fno-common
    -fno-strict-aliasing
    $<$<STREQUAL:${TARGET_SYSTEM_NAME},Linux>:-Wall>
    $<$<STREQUAL:${TARGET_SYSTEM_NAME},Linux>:-Wextra>
    $<$<STREQUAL:${TARGET_SYSTEM_NAME},Linux>:-Werror>
    $<$<NOT:$<STREQUAL:${CMAKE_HOST_SYSTEM_NAME},Windows>>:-O2>
    $<$<NOT:$<STREQUAL:${CMAKE_HOST_SYSTEM_NAME},Windows>>:-fPIC>
    ${CMAKE_EXTRA_COMPILE_OPTIONS}
)

set_target_properties(c_base_static PROPERTIES
    OUTPUT_NAME c_base
)

#------------------------- c_json -------------------------
set(C_JSON_SRC
    src/json_parser.c
)

add_library(c_json_static STATIC
    ${C_JSON_SRC}
)

target_link_libraries(c_json_static
    PRIVATE
        $<BUILD_INTERFACE:intf_pub>
        c_sec_headers
)

target_include_directories(c_json_static PRIVATE
    ${CMAKE_CURRENT_SOURCE_DIR}/../c_mmpa/inc
    ${CMAKE_CURRENT_SOURCE_DIR}/inc
    $<BUILD_INTERFACE:${CMAKE_CURRENT_LIST_DIR}/../stub/inc>
    $<$<STREQUAL:${TARGET_SYSTEM_NAME},LiteOS>:$<BUILD_INTERFACE:${NANO_LITEOS_HEADER_FILES_PATH}>>
)

target_compile_options(c_json_static PRIVATE
    -fno-common
    -fno-strict-aliasing
    $<$<STREQUAL:${TARGET_SYSTEM_NAME},Linux>:-Wall>
    $<$<STREQUAL:${TARGET_SYSTEM_NAME},Linux>:-Wextra>
    $<$<STREQUAL:${TARGET_SYSTEM_NAME},Linux>:-Werror>
    $<$<NOT:$<STREQUAL:${CMAKE_HOST_SYSTEM_NAME},Windows>>:-O2>
    $<$<NOT:$<STREQUAL:${CMAKE_HOST_SYSTEM_NAME},Windows>>:-fPIC>
    ${CMAKE_EXTRA_COMPILE_OPTIONS}
)

target_compile_definitions(c_json_static PRIVATE
  $<IF:$<STREQUAL:${TARGET_SYSTEM_NAME},LiteOS>,NANO_OS_TYPE=1,NANO_OS_TYPE=0>
)

set_target_properties(c_json_static PROPERTIES
    OUTPUT_NAME c_json
)

#------------------------- install -------------------------
install_package(
    PACKAGE c_base
    TARGETS c_base_static c_base_headers c_json_static
    DIRECTORY   ${CMAKE_CURRENT_SOURCE_DIR}/inc/
    DESTINATION ${INSTALL_INCLUDE_DIR}/c_base
)