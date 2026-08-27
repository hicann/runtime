# -----------------------------------------------------------------------------------------------------------
# Copyright (c) 2026 Huawei Technologies Co., Ltd.
# This program is free software, you can redistribute it and/or modify it under the terms and conditions of
# CANN Open Software License Agreement Version 2.0 (the "License").
# Please refer to the License for details. You may not use this file except in compliance with the License.
# THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
# INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
# See LICENSE in the root of the software repository for the full text of the License.
# -----------------------------------------------------------------------------------------------------------

cmake_minimum_required(VERSION 3.16.0)

project(Binary_Enumerate_Functions_Sample LANGUAGES C CXX)

include(GNUInstallDirs)

set(ASCENDC_CMAKE_DIR $ENV{ASCENDC_CMAKE_DIR} CACHE PATH "AscendC CMake directory")
set(RUN_MODE "npu" CACHE STRING "cpu/sim/npu")
set(SOC_VERSION $ENV{SOC_VERSION} CACHE STRING "Ascend SoC version")
set(ASCEND_CANN_PACKAGE_PATH $ENV{ASCEND_HOME_PATH} CACHE PATH "CANN installation path")

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_BUILD_TYPE "Debug" CACHE STRING "Build type Release/Debug" FORCE)
set(CMAKE_INSTALL_PREFIX "${CMAKE_CURRENT_LIST_DIR}/out" CACHE PATH "Install path" FORCE)

if(NOT EXISTS "${ASCENDC_CMAKE_DIR}/ascendc.cmake")
    message(FATAL_ERROR "Cannot find ${ASCENDC_CMAKE_DIR}/ascendc.cmake")
endif()

include("${ASCENDC_CMAKE_DIR}/ascendc.cmake")
ascendc_fatbin_library(custom_kernels kernel/custom.cpp)

set(CANN_SEARCH_ROOTS
    "${ASCEND_CANN_PACKAGE_PATH}"
    "${ASCEND_CANN_PACKAGE_PATH}/runtime"
    "${ASCEND_CANN_PACKAGE_PATH}/aarch64-linux"
    "${ASCEND_CANN_PACKAGE_PATH}/x86_64-linux"
)

find_path(ACL_INCLUDE_DIR
    NAMES acl/acl.h
    PATHS ${CANN_SEARCH_ROOTS}
    PATH_SUFFIXES include
    REQUIRED
)

find_library(ACL_RT_LIBRARY
    NAMES acl_rt
    PATHS ${CANN_SEARCH_ROOTS}
    PATH_SUFFIXES lib64 devlib devlib/linux/aarch64 devlib/linux/x86_64
    REQUIRED
)

add_executable(binary_enumerate_functions main.cpp)

target_include_directories(binary_enumerate_functions PRIVATE
    "${ACL_INCLUDE_DIR}"
    "${CMAKE_CURRENT_SOURCE_DIR}/../../.."
)

target_compile_options(binary_enumerate_functions PRIVATE
    -O2
    -Wall
    -Wextra
    -Werror
    -D_GLIBCXX_USE_CXX11_ABI=0
)

target_link_libraries(binary_enumerate_functions PRIVATE
    "${ACL_RT_LIBRARY}"
    dl
    pthread
)

install(TARGETS binary_enumerate_functions
    RUNTIME DESTINATION "${CMAKE_INSTALL_BINDIR}"
)
