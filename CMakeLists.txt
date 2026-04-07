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
project (rts)

if(POLICY CMP0135)
    cmake_policy(SET CMP0135 NEW)
endif()

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
set(_cmake_arg_version_info "${VERSION_INFO}")

# third_party
include(${RUNTIME_DIR}/cmake/third_party/protobuf.cmake)
include(${RUNTIME_DIR}/cmake/third_party/json.cmake)
include(${RUNTIME_DIR}/cmake/third_party/acl_compat.cmake)
include(${RUNTIME_DIR}/cmake/third_party/csec.cmake)

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
    include(cmake/third_party/boost.cmake)
    include(cmake/third_party/mockcpp.cmake)
    include(cmake/third_party/gtest_shared.cmake)
    add_dependencies(GTest::gtest mockcpp)

    add_subdirectory(tests)
endif()

if(DEFINED ENV{TOOLCHAIN_DIR} AND ENABLE_BUILD_DEVICE)
    set(ENABLE_DEVICE ON)
else()
    set(ENABLE_DEVICE OFF)
endif()

if(ENABLE_DEVICE)
    set(TOOLCHAIN_DIR $ENV{TOOLCHAIN_DIR})
    # 对于libc_sec，只有makefile，需要传递编译器路径
    set(CMAKE_CXX_COMPILER_ "${TOOLCHAIN_DIR}/bin/aarch64-target-linux-gnu-g++")
    set(CMAKE_C_COMPILER_ "${TOOLCHAIN_DIR}/bin/aarch64-target-linux-gnu-gcc")
    set(CMAKE_C_AR "${TOOLCHAIN_DIR}/bin/aarch64-target-linux-gnu-ar")
    ExternalProject_Add(device
        SOURCE_DIR ${RUNTIME_DIR}/cmake/device
        BINARY_DIR ${CMAKE_BINARY_DIR}/device_build
        CMAKE_ARGS  
            -DENABLE_GCOV=${ENABLE_GCOV}
            -DCMAKE_BUILD_TYPE=${CMAKE_BUILD_TYPE}
            -DTOOLCHAIN_DIR=${TOOLCHAIN_DIR}
            -DCMAKE_INSTALL_PREFIX=${CMAKE_BINARY_DIR}/device_install
            -DCMAKE_TOOLCHAIN_FILE=${RUNTIME_DIR}/cmake/aarch64-hcc-toolchain.cmake
            -DCANN_3RD_LIB_PATH=${CANN_3RD_LIB_PATH}
            -DCMAKE_C_AR=${CMAKE_C_AR}
            -DCMAKE_C_COMPILER=${CMAKE_C_COMPILER_}
            -DCMAKE_CXX_COMPILER=${CMAKE_CXX_COMPILER_}
            -DCMAKE_C_COMPILER_LAUNCHER=${CMAKE_C_COMPILER_LAUNCHER}
            -DCMAKE_CXX_COMPILER_LAUNCHER=${CMAKE_CXX_COMPILER_LAUNCHER}
            -DENABLE_SIGN=${ENABLE_SIGN}
            -DCUSTOM_SIGN_SCRIPT=${CUSTOM_SIGN_SCRIPT}
            -DVERSION_INFO=${VERSION_INFO}
            -DENABLE_OPEN_SRC=TRUE
        INSTALL_COMMAND ${CMAKE_CPACK_COMMAND}
        BUILD_ALWAYS TRUE
    )

    install(FILES
        ${CMAKE_BINARY_DIR}/device_build/device-npu-runtime.tar.gz
        DESTINATION .
        COMPONENT npu-runtime
    )
endif()

if (TOPLEVEL_PROJECT AND NOT ENABLE_COV AND NOT ENABLE_UT)
    include(${RUNTIME_DIR}/cmake/makeself-fetch.cmake)
    # ============= CPack =============
    # acl-compat do not need pack
    set(CPACK_PACKAGE_NAME "${PROJECT_NAME}")
    set(CPACK_PACKAGE_VERSION "${PROJECT_VERSION}")
    set(CPACK_PACKAGE_FILE_NAME "${CPACK_PACKAGE_NAME}-${CPACK_PACKAGE_VERSION}-${CMAKE_SYSTEM_NAME}")

    set(CPACK_CMAKE_SOURCE_DIR "${CMAKE_SOURCE_DIR}")
    set(CPACK_CMAKE_BINARY_DIR "${CMAKE_BINARY_DIR}")
    set(CPACK_CMAKE_INSTALL_PREFIX "${CMAKE_INSTALL_PREFIX}")
    set(CPACK_CMAKE_CURRENT_SOURCE_DIR "${CMAKE_CURRENT_SOURCE_DIR}")
    set(CPACK_ENABLE_DEVICE "${ENABLE_DEVICE}")
    set(CPACK_GENERATOR External)
    set(CPACK_EXTERNAL_PACKAGE_SCRIPT "${CMAKE_SOURCE_DIR}/cmake/makeself.cmake")
    set(CPACK_EXTERNAL_ENABLE_STAGING true)
    set(CPACK_PACKAGE_DIRECTORY "${CMAKE_BINARY_DIR}")
    set(CPACK_MAKESELF_PATH "${MAKESELF_PATH}")
    set(CPACK_PACKAGE_PARAM_NAME "runtime")
    set(CPACK_BUILD_MODE "RUN_COPY")
    include(CPack)
endif()
