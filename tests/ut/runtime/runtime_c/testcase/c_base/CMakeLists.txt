# -----------------------------------------------------------------------------------------------------------
# Copyright (c) 2025 Huawei Technologies Co., Ltd.
# This program is free software, you can redistribute it and/or modify it under the terms and conditions of
# CANN Open Software License Agreement Version 2.0 (the "License").
# Please refer to the License for details. You may not use this file except in compliance with the License.
# THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
# INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
# See LICENSE in the root of the software repository for the full text of the License.
# -----------------------------------------------------------------------------------------------------------
set(C_BASE_TESTED_SRC_DIR ${TOP_DIR}/src/runtime/c/c_base)
set(C_MMPA_TESTED_SRC_DIR ${TOP_DIR}/src/runtime/c/c_mmpa)

# c_base ut
set(C_BASE_TESTED_FILES
    ${C_BASE_TESTED_SRC_DIR}/src/vector.c
    ${C_BASE_TESTED_SRC_DIR}/src/sort_vector.c
    ${C_BASE_TESTED_SRC_DIR}/src/json_parser.c
    ${C_BASE_TESTED_SRC_DIR}/src/ref_obj.c
    ${C_BASE_TESTED_SRC_DIR}/src/mem_pool.c
    ${C_BASE_TESTED_SRC_DIR}/src/error_manager.c
)

set(C_BASE_TEST_CASE_FILES
    main.cc
    vector_test.cc
    sort_vector_test.cc
    json_parser_test.cc
    single_list_test.cc
    ref_obj_test.cc
    mem_pool_test.cc
    error_manager_test.cc
)

add_executable(c_base_utest
    ${C_BASE_TESTED_FILES}
    ${C_BASE_TEST_CASE_FILES}
)

target_include_directories(c_base_utest PRIVATE
    ${C_BASE_TESTED_SRC_DIR}/inc
    ${C_MMPA_TESTED_SRC_DIR}/inc
)

target_compile_options(c_base_utest PRIVATE
    -g --coverage -fprofile-arcs -ftest-coverage
    -Wall
    -Wextra
    -Werror
)

target_compile_definitions(c_base_utest PRIVATE
    _GLIBCXX_USE_CXX11_ABI=0
    google=ascend_private
    $<IF:$<STREQUAL:${TARGET_SYSTEM_NAME},LiteOS>,NANO_OS_TYPE=1,NANO_OS_TYPE=0>
)

target_link_libraries(c_base_utest
    c_sec
    -lpthread
    -Wl,--whole-archive
    -Wl,--no-whole-archive
    $<BUILD_INTERFACE:intf_llt_pub>
    $<BUILD_INTERFACE:c_sec_headers>
    -lgcov
)

include_directories(${OPEN_SOURCE_DIR}/boost-1.87.0)
include_directories(${OPEN_SOURCE_DIR}/mockcpp_src/include)