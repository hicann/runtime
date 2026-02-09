# -----------------------------------------------------------------------------------------------------------
# Copyright (c) 2025 Huawei Technologies Co., Ltd.
# This program is free software, you can redistribute it and/or modify it under the terms and conditions of
# CANN Open Software License Agreement Version 2.0 (the "License").
# Please refer to the License for details. You may not use this file except in compliance with the License.
# THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
# INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
# See LICENSE in the root of the software repository for the full text of the License.
# -----------------------------------------------------------------------------------------------------------
set(MMPA_UT_TEST_LIST
    ${BASE_DIR}/tests/ut/mmpa/testcase/mmpa_linux_unittest.cc
    ${BASE_DIR}/tests/ut/mmpa/stub/mmpa_linux_stubtest.cc
    ${BASE_DIR}/src/mmpa/src/mmpa_linux.c
    ${BASE_DIR}/src/mmpa/src/mmpa_linux_thread.c
    ${BASE_DIR}/src/mmpa/src/mmpa_linux_file.c
    ${BASE_DIR}/src/mmpa/src/mmpa_linux_time.c
    ${BASE_DIR}/src/mmpa/src/mmpa_linux_atom.c
    ${BASE_DIR}/src/mmpa/src/mmpa_linux_dlfcn.c
    ${BASE_DIR}/src/mmpa/src/mmpa_linux_memory.c
    ${BASE_DIR}/src/mmpa/src/mmpa_linux_message.c
    ${BASE_DIR}/src/mmpa/src/mmpa_linux_option.c
    ${BASE_DIR}/src/mmpa/src/mmpa_linux_env.c
)

add_executable(mmpa_cpp_utest
    ${MMPA_UT_TEST_LIST}
)

target_compile_definitions(mmpa_cpp_utest PRIVATE
    OS_TYPE=0
)

target_include_directories(mmpa_cpp_utest PRIVATE
    ${BASE_DIR}/pkg_inc/mmpa
    ${BASE_DIR}/tests/ut/mmpa
    ${OPEN_SOURCE_DIR}/mockcpp_src/include
    ${OPEN_SOURCE_DIR}/boost-1.87.0
)

target_link_libraries(mmpa_cpp_utest PRIVATE
    $<BUILD_INTERFACE:intf_pub>
    $<BUILD_INTERFACE:c_sec_headers>
    -fsanitize=address -fsanitize=leak -fsanitize-recover=address
    c_sec
    json
    GTest::gtest
    GTest::gtest_main
    GTest::gmock
    GTest::gmock_main
    ${OPEN_SOURCE_DIR}/mockcpp/lib/libmockcpp.a
    -lgcov
    -ldl
    -lrt
)
