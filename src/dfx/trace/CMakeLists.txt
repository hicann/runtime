# -----------------------------------------------------------------------------------------------------------
# Copyright (c) 2025 Huawei Technologies Co., Ltd.
# This program is free software, you can redistribute it and/or modify it under the terms and conditions of
# CANN Open Software License Agreement Version 2.0 (the "License").
# Please refer to the License for details. You may not use this file except in compliance with the License.
# THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
# INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
# See LICENSE in the root of the software repository for the full text of the License.
# -----------------------------------------------------------------------------------------------------------
cmake_minimum_required(VERSION 3.12)
project(toolchain_adiag)
get_filename_component(ATRACE_DIR "${CMAKE_CURRENT_SOURCE_DIR}" ABSOLUTE)
set(ADIAG_COMMON_COMPILE_OPTIONS
    -Werror
    -Wall
    -Wextra
    -Wundef
    -Wunused
    -Wpointer-arith
    -Wdate-time
    -Wfloat-equal
    -Wformat=2
    -Wshadow
    -Wsign-compare
    -Wvla
    -Wdisabled-optimization
    -Wempty-body
    -Wignored-qualifiers
    -Wtype-limits
    -Wshift-negative-value
    -Wswitch-default
    -Wframe-larger-than=32768
    -Wwrite-strings
    -Wmissing-format-attribute
    -Wformat-nonliteral
    -Wmissing-include-dirs
    -Wmissing-declarations
    -Wredundant-decls
    -Wfloat-conversion
)


############################## [awatchdog_headers] ####################################
add_library(awatchdog_headers INTERFACE)
target_include_directories(awatchdog_headers INTERFACE
    $<BUILD_INTERFACE:${ATRACE_DIR}/../../../pkg_inc/trace>
    $<BUILD_INTERFACE:${RUNTIME_DIR}/pkg_inc/watchdog>
    $<BUILD_INTERFACE:${ATRACE_DIR}/../../../pkg_inc/watchdog>
    $<INSTALL_INTERFACE:include>
    $<INSTALL_INTERFACE:include/awatchdog>
)

############################## [atrace_headers] ####################################
add_library(atrace_headers INTERFACE)
target_include_directories(atrace_headers INTERFACE
    $<BUILD_INTERFACE:${ATRACE_DIR}/../../../pkg_inc/trace>
    $<BUILD_INTERFACE:${RUNTIME_DIR}/pkg_inc/trace>
    $<INSTALL_INTERFACE:include>
    $<INSTALL_INTERFACE:include/atrace>
    $<INSTALL_INTERFACE:include/atrace/utrace>
)

add_subdirectory(common)
add_subdirectory(atrace)
add_subdirectory(awatchdog)
# add_subdirectory(cpu_detect)