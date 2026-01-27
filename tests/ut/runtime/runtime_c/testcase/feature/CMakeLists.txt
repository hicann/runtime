# -----------------------------------------------------------------------------------------------------------
# Copyright (c) 2025 Huawei Technologies Co., Ltd.
# This program is free software, you can redistribute it and/or modify it under the terms and conditions of
# CANN Open Software License Agreement Version 2.0 (the "License").
# Please refer to the License for details. You may not use this file except in compliance with the License.
# THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
# INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
# See LICENSE in the root of the software repository for the full text of the License.
# -----------------------------------------------------------------------------------------------------------
include(${TOP_DIR}/src/inc/runtime/runtime_headers.cmake)

set(C_BASE_TESTED_SRC_DIR ${TOP_DIR}/src/runtime/c/c_base)
set(C_MMPA_TESTED_SRC_DIR ${TOP_DIR}/src/runtime/c/c_mmpa)

set(C_FEATURE_INCLUDE_DIR
    ${TOP_DIR}/src/runtime/c/stub/inc
    ${TOP_DIR}/src/runtime/c/feature/inc
    ${TOP_DIR}/src/runtime/c/c_mmpa/inc
    ${TOP_DIR}/src/runtime/c/c_base/inc
    ${TOP_DIR}/include/external/acl
)

set(C_BASE_TESTED_FILES
    ${C_BASE_TESTED_SRC_DIR}/src/vector.c
    ${C_BASE_TESTED_SRC_DIR}/src/sort_vector.c
    ${C_BASE_TESTED_SRC_DIR}/src/json_parser.c
    ${C_BASE_TESTED_SRC_DIR}/src/ref_obj.c
    ${C_BASE_TESTED_SRC_DIR}/src/mem_pool.c
)

set(C_FEATURE_TESTED_SRC_DIR ${TOP_DIR}/src/runtime/c/feature)

set(C_FEATURE_TESTED_COMMON_FILES
    ${C_FEATURE_TESTED_SRC_DIR}/src/api.c
    ${C_FEATURE_TESTED_SRC_DIR}/src/device.c
    ${C_FEATURE_TESTED_SRC_DIR}/src/context_common.c
    ${C_FEATURE_TESTED_SRC_DIR}/src/stream.c
    ${C_FEATURE_TESTED_SRC_DIR}/src/error_manage.c
    ${C_FEATURE_TESTED_SRC_DIR}/src/model.c
    ${C_FEATURE_TESTED_SRC_DIR}/src/rt_ctrl_model.c
    ${C_FEATURE_TESTED_SRC_DIR}/src/host_func.c
    ${C_BASE_TESTED_SRC_DIR}/src/error_manager.c
)

set(C_FEATURE_STUB
    ${CMAKE_CURRENT_SOURCE_DIR}/../../stub/rt_utest_stub.cc
)

set(C_FEATURE_TEST_CASE_FILES
    main.cc
    mmpa_linux_test.cc
    rt_api_test.cc
    rt_model_api_test.cc
)

#------------------------- linux -------------------------
set(C_FEATURE_TESTED_LINUX_FILES
    ${C_FEATURE_TESTED_SRC_DIR}/src/context_linux.c
    ${C_FEATURE_TESTED_SRC_DIR}/src/subscribe_manager_linux.c
)

add_executable(c_feature_linux_utest
    ${C_FEATURE_TESTED_COMMON_FILES}
    ${C_FEATURE_TESTED_LINUX_FILES}
    ${C_BASE_TESTED_FILES}
    ${C_FEATURE_TEST_CASE_FILES}
    ${C_FEATURE_STUB}
)

target_compile_options(c_feature_linux_utest PRIVATE
    -fsanitize=address -fsanitize=leak
    -g --coverage -fprofile-arcs -ftest-coverage
    -Wall
    -Wextra
    -Werror
)

target_include_directories(c_feature_linux_utest PRIVATE
    ${C_FEATURE_INCLUDE_DIR}
)

target_compile_definitions(c_feature_linux_utest PRIVATE
    _GLIBCXX_USE_CXX11_ABI=0
    google=ascend_private
    RUN_TEST
    NANO_OS_TYPE=0
)

target_link_libraries(c_feature_linux_utest
    PRIVATE
        -fsanitize=address -fsanitize=leak
        -Wl,--whole-archive
        -Wl,--no-whole-archive
        $<BUILD_INTERFACE:intf_llt_pub>
        $<BUILD_INTERFACE:msprof_headers>
        $<BUILD_INTERFACE:slog_headers>
        $<BUILD_INTERFACE:c_sec_headers>
        $<BUILD_INTERFACE:npu_runtime_headers>
        c_sec
        -lgcov
    PUBLIC
)

#------------------------- liteos -------------------------
set(C_FEATURE_STUB_LITEOS
    ${CMAKE_CURRENT_SOURCE_DIR}/../../stub/rt_utest_stub.cc
)

set(C_FEATURE_TESTED_LITEOS_FILES
    ${C_FEATURE_TESTED_SRC_DIR}/src/context_liteos.c
    ${C_FEATURE_TESTED_SRC_DIR}/src/subscribe_manager_liteos.c
)

add_executable(c_feature_liteos_utest
    ${C_FEATURE_TESTED_COMMON_FILES}
    ${C_FEATURE_TESTED_LITEOS_FILES}
    ${C_BASE_TESTED_FILES}
    ${C_FEATURE_TEST_CASE_FILES}
    ${C_FEATURE_STUB_LITEOS}
)

target_compile_options(c_feature_liteos_utest PRIVATE
    -fsanitize=address -fsanitize=leak
    -g --coverage -fprofile-arcs -ftest-coverage
    -Wall
    -Wextra
    -Werror
)

target_include_directories(c_feature_liteos_utest PRIVATE
    ${C_FEATURE_INCLUDE_DIR}
)

target_compile_definitions(c_feature_liteos_utest PRIVATE
    _GLIBCXX_USE_CXX11_ABI=0
    google=ascend_private
    RUN_TEST
    NANO_OS_TYPE=0
)

target_link_libraries(c_feature_liteos_utest
    PRIVATE
        -fsanitize=address -fsanitize=leak
        -Wl,--whole-archive
        -Wl,--no-whole-archive
        $<BUILD_INTERFACE:intf_llt_pub>
        $<BUILD_INTERFACE:msprof_headers>
        $<BUILD_INTERFACE:slog_headers>
        $<BUILD_INTERFACE:c_sec_headers>
        $<BUILD_INTERFACE:npu_runtime_headers>
        c_sec
        -lgcov
    PUBLIC
)

include_directories(${OPEN_SOURCE_DIR}/boost-1.87.0)
include_directories(${OPEN_SOURCE_DIR}/mockcpp_src/include)