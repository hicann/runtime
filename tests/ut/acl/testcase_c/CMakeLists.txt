# -----------------------------------------------------------------------------------------------------------
# Copyright (c) 2025 Huawei Technologies Co., Ltd.
# This program is free software, you can redistribute it and/or modify it under the terms and conditions of
# CANN Open Software License Agreement Version 2.0 (the "License").
# Please refer to the License for details. You may not use this file except in compliance with the License.
# THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
# INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
# See LICENSE in the root of the software repository for the full text of the License.
# -----------------------------------------------------------------------------------------------------------
project(ascendcl_c_utest)

set(UT_FILES
    "main.cpp"
    "acl_rt_unittest.cpp"
)

set(UT_STUBS
    "${CMAKE_CURRENT_SOURCE_DIR}/gmock_executor/ge_executor_stub.cc"
    "${CMAKE_CURRENT_SOURCE_DIR}/stub/runtime_stub.cpp"
    "${CMAKE_CURRENT_SOURCE_DIR}/stub/mmpa_api_stub.cpp"
)

set(SRC_FILES
    "${BASE_DIR}/src/acl/aclrt_c/runtime/callback.c"
    "${BASE_DIR}/src/acl/aclrt_c/runtime/host_func.c"
    "${BASE_DIR}/src/acl/aclrt_c/runtime/context.c"
    "${BASE_DIR}/src/acl/aclrt_c/runtime/device.c"
    "${BASE_DIR}/src/acl/aclrt_c/runtime/stream.c"
    "${BASE_DIR}/src/acl/aclrt_c/runtime/memory.c"
    "${BASE_DIR}/src/acl/aclrt_c/common/acl_rt.c"
    "${BASE_DIR}/src/acl/aclrt_c/common/model_config_rt.c"
)
set(SRC_CBASE_FILES
    "${BASE_DIR}/src/runtime/c/c_base/src/error_manager.c"
    "${BASE_DIR}/src/runtime/c/c_base/src/json_parser.c"
    "${BASE_DIR}/src/runtime/c/c_base/src/mem_pool.c"
    "${BASE_DIR}/src/runtime/c/c_base/src/ref_obj.c"
    "${BASE_DIR}/src/runtime/c/c_base/src/sort_vector.c"
    "${BASE_DIR}/src/runtime/c/c_base/src/vector.c"
)

############ ascendcl_c_utest ############
add_executable(ascendcl_c_utest
               ${UT_FILES}
               ${SRC_FILES}
               ${UT_STUBS}
               ${SRC_CBASE_FILES}
)

#include directories
target_include_directories(ascendcl_c_utest PRIVATE
    ${BASE_DIR}/include/external
    ${BASE_DIR}/include/external/acl # error_codes
    ${BASE_DIR}/pkg_inc/base # slog.h
    ${BASE_DIR}/pkg_inc # toolchain/prof_api.h
    ${BASE_DIR}/pkg_inc/profiling # toolchain/prof_api.h
    ${BASE_DIR}/src/acl/aclrt_c
    ${BASE_DIR}/src/acl/aclrt_c/common
    ${BASE_DIR}/src/inc   # runtime/mem.h，runtime/base.h
    ${BASE_DIR}/src/inc/runtime # base.h
    ${BASE_DIR}/src/runtime/c/c_base/inc
    ${BASE_DIR}/src/acl/aclrt_c/common  # ge_executor_rt.h
    ${BASE_DIR}/tests/ut/acl/testcase_c/
    ${BASE_DIR}/tests/ut/acl/testcase_c/gmock_executor
    ${BASE_DIR}/tests/ut/acl/testcase_c/stub
    ${BASE_DIR}/tests/depends/
    ${BASE_DIR}/tests/depends/
    ${BASE_DIR}/tests/ut
)

target_compile_options(ascendcl_c_utest PRIVATE
    -fsanitize=address -fsanitize=leak
    -g --coverage -fprofile-arcs -ftest-coverage
    -Wall -Wextra -Wfloat-equal -Werror
)

target_compile_definitions(ascendcl_c_utest PRIVATE
    google=ascend_private
    ENABLE_DVPP_INTERFACE
    RUN_TEST
    $<$<STREQUAL:${ENABLE_OPEN_SRC},True>:ONLY_COMPILE_OPEN_SRC>
    $<IF:$<STREQUAL:${TARGET_SYSTEM_NAME},LiteOS>,NANO_OS_TYPE=1,NANO_OS_TYPE=0>
)

target_link_libraries(ascendcl_c_utest PRIVATE
    -fsanitize=address -fsanitize=leak
    $<BUILD_INTERFACE:intf_pub>
    $<BUILD_INTERFACE:c_sec_headers>
    c_sec
    GTest::gtest
    GTest::gtest_main
    GTest::gmock
    GTest::gmock_main
    -lrt
    -ldl
    -lpthread
    -lgcov
)
