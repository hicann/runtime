# Copyright (c) 2025 Huawei Technologies Co., Ltd.
# This program is free software, you can redistribute it and/or modify it under the terms and conditions of
# CANN Open Software License Agreement Version 2.0 (the "License").
# Please refer to the License for details. You may not use this file except in compliance with the License.
# THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
# INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
# See LICENSE in the root of the software repository for the full text of the License.
# ===================================================================================================================

# include directories
include_directories(${CMAKE_CURRENT_LIST_DIR})
include_directories(${BASE_DIR}/src/dfx/error_manager)
include_directories(${BASE_DIR}/include/dfx)
include_directories(${BASE_DIR}/pkg_inc)
include_directories(${BASE_DIR}/pkg_inc/base)
include_directories(${BASE_DIR}/src/mmpa/inc)
include_directories(${OPEN_SOURCE_DIR}/mockcpp_src/include)

set(UT_FILES
    "testcase/error_manager_unittest.cc"
)

set(SRC_FILES
    "${BASE_DIR}/src/dfx/error_manager/error_manager.cc"
)

add_executable(ut_error_manager ${UT_FILES} ${SRC_FILES})

target_compile_definitions(ut_error_manager PRIVATE
    BASE_DIR="${BASE_DIR}"
)

target_compile_options(ut_error_manager PRIVATE
    -g --coverage -fprofile-arcs -ftest-coverage
    -Wno-deprecated-declarations
    -Wall -Wfloat-equal -Werror
    -fno-access-control
)

target_compile_definitions(ut_error_manager PRIVATE
    google=ascend_private
)

target_link_options(ut_error_manager PRIVATE
        -Wl,--disable-new-dtags
        -Wl,-rpath,${CMAKE_CURRENT_LIST_DIR}
        )

target_link_libraries(ut_error_manager PRIVATE
    $<BUILD_INTERFACE:intf_pub>
    $<BUILD_INTERFACE:c_sec_headers>
    mmpa
    unified_dlog
    json
    GTest::gtest
    GTest::gtest_main    
    ascend_protobuf
    c_sec
    -lrt
    -ldl
    -lgcov
    -lpthread
)
