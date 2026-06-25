# -----------------------------------------------------------------------------------------------------------
# Copyright (c) 2026 Huawei Technologies Co., Ltd.
# This program is free software, you can redistribute it and/or modify it under the terms and conditions of
# CANN Open Software License Agreement Version 2.0 (the "License").
# Please refer to the License for details. You may not use this file except in compliance with the License.
# THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
# INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
# See LICENSE in the root of the software repository for the full text of the License.
# -----------------------------------------------------------------------------------------------------------

# CMake lowest version requirement
cmake_minimum_required(VERSION 3.16.0)

# Project information
project(Runtime_Memory_Pool_SomaReuse_Sample)
set(SOC_VERSION $ENV{SOC_VERSION})
set(ASCENDC_CMAKE_DIR $ENV{ASCENDC_CMAKE_DIR})
set(RUN_MODE "npu" CACHE STRING "run mode: npu")
set(CMAKE_BUILD_TYPE "Debug" CACHE STRING "Build type Release/Debug (default Debug)" FORCE)
set(CMAKE_INSTALL_PREFIX "${CMAKE_CURRENT_LIST_DIR}/out" CACHE STRING "path for install()" FORCE)

# Ascend library use to add kernel file to generate ascendc library
include(${ASCENDC_CMAKE_DIR}/ascendc.cmake)
ascendc_library(kernels STATIC ../../../../example/kernel_func/kernel_add.cpp)
include_directories(${CMAKE_CURRENT_SOURCE_DIR}/../../../../example)
include_directories(${CMAKE_CURRENT_SOURCE_DIR}/../../../../example/kernel_func)

# Include directories and libraries
include_directories(${ASCEND_CANN_PACKAGE_PATH}/include)
include_directories(${CMAKE_CURRENT_SOURCE_DIR}/../../..)
link_directories(${ASCEND_CANN_PACKAGE_PATH}/lib64)
include_directories(${ASCEND_CANN_PACKAGE_PATH}/asc/include)
include_directories(${ASCEND_CANN_PACKAGE_PATH}/asc/include/basic_api)
include_directories(${ASCEND_CANN_PACKAGE_PATH}/asc/impl/basic_api)

add_executable(main main.cpp)

target_link_libraries(main PRIVATE ascendcl kernels)