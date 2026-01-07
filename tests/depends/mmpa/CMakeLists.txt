# -----------------------------------------------------------------------------------------------------------
# Copyright (c) 2025 Huawei Technologies Co., Ltd.
# This program is free software, you can redistribute it and/or modify it under the terms and conditions of
# CANN Open Software License Agreement Version 2.0 (the "License").
# Please refer to the License for details. You may not use this file except in compliance with the License.
# THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
# INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
# See LICENSE in the root of the software repository for the full text of the License.
# -----------------------------------------------------------------------------------------------------------

project(STUB_MMPA)

file(GLOB_RECURSE SRC_FILES RELATIVE ${CMAKE_CURRENT_SOURCE_DIR}
    "src/mmpa_stub.cpp"
)

include_directories(${TOP_DIR}/include)
include_directories(${TOP_DIR}/include/external)
include_directories(${TOP_DIR}/pkg_inc/runtime)
include_directories(${TOP_DIR}/pkg_inc/runtime/runtime)
include_directories(${CMAKE_BINARY_DIR}/include_acl)
include_directories(${CMAKE_BINARY_DIR}/include_acl/tdt)
include_directories(${TOP_DIR}/src/dfx/error_manager)
include_directories(${BASE_DIR}/tests/depends)

include_directories(${BASE_DIR}/pkg_inc)
include_directories(${BASE_DIR}/pkg_inc/base)
include_directories(${BASE_DIR}/pkg_inc/profiling)
include_directories(${BASE_DIR}/pkg_inc/dump)
include_directories(${BASE_DIR}/pkg_inc/watchdog)
include_directories(${BASE_DIR}/include/dfx)
include_directories(${BASE_DIR}/src/dfx/adump/inc/metadef/external)

add_library(mmpa_stub SHARED ${SRC_FILES})

add_dependencies(mmpa_stub copy_acl_headers_and_libs)

target_link_libraries(mmpa_stub PRIVATE
    $<BUILD_INTERFACE:intf_pub>
    $<BUILD_INTERFACE:c_sec_headers>
    -Wl,--no-as-needed
    c_sec
    GTest::gtest
    GTest::gtest_main
    GTest::gmock
    GTest::gmock_main
)
