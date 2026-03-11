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

set(RUNTIME_DIR "${CMAKE_CURRENT_SOURCE_DIR}" CACHE PATH "Project top directory")
set(PRODUCT_SIDE host)

if (CMAKE_SOURCE_DIR STREQUAL PROJECT_SOURCE_DIR)
    message(STATUS "Build with dependency cann pkgs installed")
    option(BUILD_WITH_INSTALLED_DEPENDENCY_CANN_PKG "Build with dependency cann pkgs installed" TRUE)
else()
    message(STATUS "Build with no dependency cann pkgs installed")
    option(BUILD_WITH_INSTALLED_DEPENDENCY_CANN_PKG "Build with no dependency cann pkgs installed" FALSE)
endif()

set(INSTALL_BASE_DIR "")
set(INSTALL_LIBRARY_DIR lib)
set(INSTALL_RUNTIME_DIR bin)
set(INSTALL_INCLUDE_DIR include)
set(INSTALL_CONFIG_DIR cmake)

include(${RUNTIME_DIR}/cmake/func.cmake)

set_common_params("${RUNTIME_DIR}")
set_runtime_params()

# third_party
include(${RUNTIME_DIR}/cmake/third_party/protobuf.cmake)
include(${RUNTIME_DIR}/cmake/third_party/json.cmake)
include(${RUNTIME_DIR}/cmake/third_party/acl_compat.cmake)
include(${RUNTIME_DIR}/cmake/third_party/csec.cmake)

include(${RUNTIME_DIR}/src/inc/runtime/runtime_inner_headers.cmake)

if (ENABLE_COV OR ENABLE_UT)
    set(DEFAULT_BUILD_TYPE "Debug")
    set(CMAKE_MODULE_PATH ${CMAKE_CURRENT_LIST_DIR}/cmake/modules 
        ${OPEN_SOURCE_DIR}/cmake/modules
    )
    set(CMAKE_PREFIX_PATH ${OPEN_SOURCE_DIR}/json 
        ${OPEN_SOURCE_DIR}/gtest_shared/lib64/cmake/GTest
        ${ASCEND_INSTALL_PATH}
        ${RUNTIME_DIR}/cmake
    )
    include(cmake/intf_pub_linux.cmake)
    include(CMakePrintHelpers)
    find_package(Threads)
    include(cmake/third_party/boost.cmake)
    include(cmake/third_party/mockcpp.cmake)
    include(cmake/third_party/gtest_shared.cmake)
    add_dependencies(GTest::gtest mockcpp)
    add_subdirectory(tests) 
else()
    set(DEFAULT_BUILD_TYPE "Release")
endif()

if (NOT CMAKE_BUILD_TYPE AND NOT CMAKE_CONFIGURATION_TYPES) 
    set(CMAKE_BUILD_TYPE "${DEFAULT_BUILD_TYPE}" CACHE STRING "Choose the build type: Release/Debug" FORCE)
endif()

get_filename_component(ASCEND_PROJECT_NAME "${CMAKE_CURRENT_BINARY_DIR}" NAME)

add_subdirectory(src/aicpu_sched)
add_subdirectory(src/queue_schedule)
add_subdirectory(src/mmpa)
add_subdirectory(cmake/stub)
add_subdirectory(src/dfx/log/liblog)
add_subdirectory(src/dfx/trace)
add_subdirectory(src/tsd)
add_subdirectory(src/dfx/error_manager)
add_subdirectory(src/dfx/msprof)
add_subdirectory(src/platform)
add_subdirectory(src/dfx/adump)
add_subdirectory(src/runtime EXCLUDE_FROM_ALL)
add_subdirectory(src/acl/aclrt_impl)
add_subdirectory(src/acl/aclrt)
add_subdirectory(src/acl/acl_tdt_queue)
add_subdirectory(src/acl/acl_tdt_channel)
add_subdirectory(stub)

include(${RUNTIME_DIR}/version.cmake)
if(ENABLE_OPEN_SRC)
    check_pkg_build_deps("npu-runtime")
endif()
add_version_info_targets()

set(NPU_DEPENDENCIES platform runtime_v100 runtime runtime_common acl_rt_impl acl_rt 
        acl_tdt_queue acl_tdt_channel stub_acl_rt stub_acl_tdt_channel
        stub_acl_tdt_queue stub_acl_prof adump_server ascend_dump_static
        mmpa static_mmpa error_manager stub_error_manager runtime_platform_others 
        xpu_tprt runtime_v200 runtime_model runtime_platform_910B
        runtime_v201 runtime_model_v200 copy_acl_headers_and_libs version_npu-runtime_info
)

if (NOT ENABLE_COV AND NOT ENABLE_UT)
    add_dependencies(mmpa c_sec)
    add_dependencies(runtime_platform_others c_sec)
    add_dependencies(runtime_platform_tiny c_sec)
    add_dependencies(runtime_platform_910B c_sec)
    add_dependencies(runtime_platform_kirin c_sec)
    add_custom_target(pre_npu_runtime DEPENDS c_sec)
    foreach(depend ${NPU_DEPENDENCIES})
        add_dependencies(${depend} pre_npu_runtime)
    endforeach()
endif()

if(DEFINED ENV{TOOLCHAIN_DIR} AND NOT BUILD_HOST_ONLY)
    message(STATUS "start build device")
    message(STATUS $ENV{TOOLCHAIN_DIR})
    set(TOOLCHAIN_DIR $ENV{TOOLCHAIN_DIR})
    # 对于libc_sec，只有makefile，需要传递编译器路径
    set(CMAKE_CXX_COMPILER_ "${TOOLCHAIN_DIR}/bin/aarch64-target-linux-gnu-g++")
    set(CMAKE_C_COMPILER_ "${TOOLCHAIN_DIR}/bin/aarch64-target-linux-gnu-gcc")
    set(CMAKE_C_AR "${TOOLCHAIN_DIR}/bin/aarch64-target-linux-gnu-ar")
    set(CHILD_INSTALL_DIR ${CMAKE_BINARY_DIR}/device_install)
    ExternalProject_Add(device
        SOURCE_DIR ${RUNTIME_DIR}/cmake/device
        BINARY_DIR ${CMAKE_BINARY_DIR}/device_build
        CMAKE_ARGS  
            -DENABLE_GCOV=${ENABLE_GCOV}
            -DCMAKE_BUILD_TYPE=${CMAKE_BUILD_TYPE}
            -DTOOLCHAIN_DIR=${TOOLCHAIN_DIR}
            -DCMAKE_INSTALL_PREFIX=${CHILD_INSTALL_DIR}
            -DCMAKE_TOOLCHAIN_FILE=${RUNTIME_DIR}/cmake/aarch64-hcc-toolchain.cmake
            -DOPEN_SOURCE_DIR=${OPEN_SOURCE_DIR}
            -DCMAKE_C_AR=${CMAKE_C_AR}
            -DCMAKE_C_COMPILER=${CMAKE_C_COMPILER_}
            -DBUILD_WITH_INSTALLED_DEPENDENCY_CANN_PKG=${BUILD_WITH_INSTALLED_DEPENDENCY_CANN_PKG}
            -DCMAKE_CXX_COMPILER=${CMAKE_CXX_COMPILER_}
            -DCMAKE_C_COMPILER_LAUNCHER=${CMAKE_C_COMPILER_LAUNCHER}
            -DCMAKE_CXX_COMPILER_LAUNCHER=${CMAKE_CXX_COMPILER_LAUNCHER}
            -DINSTALL_LIBRARY_DIR=${INSTALL_LIBRARY_DIR}
            -DENABLE_SIGN=${ENABLE_SIGN}
            -DCUSTOM_SIGN_SCRIPT=${CUSTOM_SIGN_SCRIPT}
            -DVERSION_INFO=${VERSION_INFO}
            -DCMAKE_SKIP_RPATH=TRUE
        BUILD_ALWAYS TRUE
    )
    list(APPEND NPU_DEPENDENCIES device)
    add_dependencies(device copy_acl_headers_and_libs)
endif()

add_custom_target(npu_runtime DEPENDS ${NPU_DEPENDENCIES})
if (NOT ENABLE_COV AND NOT ENABLE_UT)
    include(cmake/package.cmake)
endif()
