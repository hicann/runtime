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
project(Runtime_Sample)

set(ASCENDC_CMAKE_DIR $ENV{ASCENDC_CMAKE_DIR})
set(SOC_VERSION $ENV{SOC_VERSION})
set(RUN_MODE "npu" CACHE STRING "cpu/sim/npu")
set(CMAKE_BUILD_TYPE "Debug" CACHE STRING "Build type" FORCE)
set(CMAKE_INSTALL_PREFIX "${CMAKE_CURRENT_LIST_DIR}/out" CACHE STRING "Install path" FORCE)

include(${ASCENDC_CMAKE_DIR}/ascendc.cmake)
ascendc_library(workset_transform_kernel STATIC kernel/workset_transform_kernel.cpp)

include_directories(${CMAKE_CURRENT_SOURCE_DIR}/../../..)
include_directories(${ASCEND_CANN_PACKAGE_PATH}/include)

add_executable(main main.cpp prefetch_strategy_comparison.cpp)
target_compile_options(main PRIVATE -O2 -std=c++17 -D_GLIBCXX_USE_CXX11_ABI=0 -Wall -Werror)
target_link_libraries(main PRIVATE workset_transform_kernel ${ASCEND_CANN_PACKAGE_PATH}/lib64/libacl_rt.so)

install(TARGETS main RUNTIME DESTINATION bin)
