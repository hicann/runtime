# -----------------------------------------------------------------------------------------------------------
# Copyright (c) 2025 Huawei Technologies Co., Ltd.
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
project(Profiling_Sample)
set(ASCEND_CANN_PACKAGE_PATH $ENV{ASCEND_HOME_PATH})
set(CMAKE_BUILD_TYPE "Debug" CACHE STRING "Build type Release/Debug (default Debug)" FORCE)
set(CMAKE_INSTALL_PREFIX "${CMAKE_CURRENT_LIST_DIR}/out" CACHE STRING "path for install()" FORCE)

include_directories(${ASCEND_CANN_PACKAGE_PATH}/include
                    ${ASCEND_CANN_PACKAGE_PATH}/include/driver
                    ${ASCEND_CANN_PACKAGE_PATH}/include/acl
                    ${ASCEND_CANN_PACKAGE_PATH}/runtime/include
                    ${CMAKE_CURRENT_SOURCE_DIR}/../..)

link_directories(${ASCEND_CANN_PACKAGE_PATH}/lib64)

add_executable(main main.cpp)

target_link_libraries(main PRIVATE
                    pthread
                    ${ASCEND_CANN_PACKAGE_PATH}/lib64/libc_sec.so
                    ${ASCEND_CANN_PACKAGE_PATH}/lib64/libmsprofiler.so
                    ${ASCEND_CANN_PACKAGE_PATH}/lib64/libascendcl.so
                    ${ASCEND_CANN_PACKAGE_PATH}/lib64/libprofapi.so)