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

project(Launch_Blocking_Sample)

set(ASCENDC_CMAKE_DIR $ENV{ASCENDC_CMAKE_DIR})
set(SOC_VERSION $ENV{SOC_VERSION})
set(CMAKE_BUILD_TYPE "Debug" CACHE STRING "Build type Release/Debug (default Debug)" FORCE)
set(CMAKE_INSTALL_PREFIX "${CMAKE_CURRENT_LIST_DIR}/out" CACHE STRING "path for install()" FORCE)

include(${ASCENDC_CMAKE_DIR}/ascendc.cmake)
ascendc_fatbin_library(launch_blocking_kernel ../../../kernel_func/launch_blocking_kernel.cpp)

find_package(Threads REQUIRED)
add_executable(launch_blocking main.cpp)
target_include_directories(launch_blocking PRIVATE
    ${ASCEND_CANN_PACKAGE_PATH}/include
)
target_compile_options(launch_blocking PRIVATE
    -O2 -std=c++17 -D_GLIBCXX_USE_CXX11_ABI=0 -Wall -Werror
)
target_link_libraries(launch_blocking PRIVATE
    ${ASCEND_CANN_PACKAGE_PATH}/lib64/libacl_rt.so
    Threads::Threads
)

install(TARGETS launch_blocking
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    ARCHIVE DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)
