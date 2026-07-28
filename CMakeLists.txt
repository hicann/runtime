# -----------------------------------------------------------------------------------------------------------
# Copyright (c) 2025 Huawei Technologies Co., Ltd.
# This program is free software, you can redistribute it and/or modify it under the terms and conditions of
# CANN Open Software License Agreement Version 2.0 (the "License").
# Please refer to the License for details. You may not use this file except in compliance with the License.
# THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
# INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
# See LICENSE in the root of the software repository for the full text of the License.
# -----------------------------------------------------------------------------------------------------------

cmake_minimum_required(VERSION 3.14)
include(cmake/fetch_cann_cmake.cmake)
project (rts)

init_cann_project()
add_cann_target_options()

set(RUNTIME_DIR "${CMAKE_CURRENT_SOURCE_DIR}" CACHE PATH "Project top directory")
include(cmake/func.cmake)
set_runtime_params("${RUNTIME_DIR}")

if (ENABLE_COV OR ENABLE_UT)
    set(DEFAULT_BUILD_TYPE "Debug")
else()
    set(DEFAULT_BUILD_TYPE "Release")
endif()

if (NOT CMAKE_BUILD_TYPE AND NOT CMAKE_CONFIGURATION_TYPES) 
    set(CMAKE_BUILD_TYPE "${DEFAULT_BUILD_TYPE}" CACHE STRING "Choose the build type: Release/Debug" FORCE)
endif()

if(NOT DEFINED PRODUCT_SIDE)
    set(PRODUCT_SIDE host)
endif()

# Mark cache entries as consumed even when the current configuration path does not use them.
set(_cmake_arg_enable_sign "${ENABLE_SIGN}")
set(_cmake_arg_custom_sign_script "${CUSTOM_SIGN_SCRIPT}")

# third_party
include(${RUNTIME_DIR}/cmake/third_party/acl_compat.cmake)
add_cann_third_party(json)
add_cann_third_party(csec)
add_cann_third_party(protobuf)

include(version.cmake)
check_cann_pkg_build_deps("npu-runtime")
add_cann_version_info_targets()
include(cmake/gen_version_headers.cmake)

add_subdirectory(src)

if (ENABLE_COV OR ENABLE_UT)

    set(CMAKE_MODULE_PATH ${CMAKE_CURRENT_LIST_DIR}/cmake/modules 
        ${CANN_3RD_LIB_PATH}/cmake/modules
    )
    set(CMAKE_PREFIX_PATH ${CANN_3RD_LIB_PATH}/json 
        ${CANN_3RD_LIB_PATH}/gtest_shared/lib64/cmake/GTest
        ${ASCEND_INSTALL_PATH}
        ${RUNTIME_DIR}/cmake
    )

    include(CMakePrintHelpers)
    find_package(Threads)
    add_cann_third_party(boost)
    add_cann_third_party(mockcpp)
    add_cann_third_party(gtest_shared)
    add_dependencies(GTestShared::gtest mockcpp)

    add_subdirectory(tests)
endif()

if(DEFINED ENV{TOOLCHAIN_DIR} AND ENABLE_BUILD_DEVICE)
    set(ENABLE_DEVICE ON)
    add_cann_device_project(npu-runtime)
else()
    set(ENABLE_DEVICE OFF)
endif()

if (NOT ENABLE_COV AND NOT ENABLE_UT)
    set_cann_cpack_config(npu-runtime ENABLE_DEVICE ${ENABLE_DEVICE} PACKAGE_TYPE ${PACKAGE_TYPE} SHARE_INFO_NAME runtime)
endif()
