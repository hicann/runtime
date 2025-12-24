# -----------------------------------------------------------------------------------------------------------
# Copyright (c) 2025 Huawei Technologies Co., Ltd.
# This program is free software, you can redistribute it and/or modify it under the terms and conditions of
# CANN Open Software License Agreement Version 2.0 (the "License").
# Please refer to the License for details. You may not use this file except in compliance with the License.
# THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
# INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
# See LICENSE in the root of the software repository for the full text of the License.
# -----------------------------------------------------------------------------------------------------------
# cmakelist for adx ut
set(SRC_CODE_ROOT_PATH ${TOP_DIR}/src/dfx/adump)
set(LLT_CODE_ROOT_PATH ${TOP_DIR}/tests/ut/adump/ut)

include_directories(${OPEN_SOURCE_DIR}/boost)
include_directories(${OPEN_SOURCE_DIR}/mockcpp_src/include)

############# intf_llt_pub ####################
add_library(adump_intf_llt_pub INTERFACE)

target_include_directories(adump_intf_llt_pub INTERFACE
)

target_compile_definitions(adump_intf_llt_pub INTERFACE
    CFG_BUILD_DEBUG
    _GLIBCXX_USE_CXX11_ABI=0
)
target_compile_options(adump_intf_llt_pub INTERFACE
    -g
    -w
    $<$<BOOL:${ENABLE_GCOV}>:-fprofile-arcs -ftest-coverage>
    $<$<BOOL:${ENABLE_ASAN}>:-fsanitize=address -fno-omit-frame-pointer -static-libasan -fsanitize=undefined -static-libubsan -fsanitize=leak -static-libtsan>
    -fPIC
    -pipe
)

target_link_options(adump_intf_llt_pub INTERFACE
    $<$<BOOL:${ENABLE_GCOV}>:-fprofile-arcs -ftest-coverage>
    $<$<BOOL:${ENABLE_ASAN}>:-fsanitize=address -static-libasan -fsanitize=undefined  -static-libubsan -fsanitize=leak -static-libtsan>
)

target_link_directories(adump_intf_llt_pub INTERFACE
)

target_link_libraries(adump_intf_llt_pub INTERFACE
    GTest::gtest
    ${OPEN_SOURCE_DIR}/mockcpp/lib/libmockcpp.a
    -lpthread
    $<$<BOOL:${ENABLE_GCOV}>:-lgcov>
    c_sec_static
    ascend_protobuf_static
)

############ adump onetrack pub target for utest ############
add_library(adx_utestonetrack_pub INTERFACE)

target_link_libraries(adx_utestonetrack_pub INTERFACE
    $<BUILD_INTERFACE:adump_intf_llt_pub>
    $<BUILD_INTERFACE:mmpa_headers>
    $<BUILD_INTERFACE:adump_headers>
    $<BUILD_INTERFACE:slog_headers>
    $<BUILD_INTERFACE:msprof_headers>
    $<BUILD_INTERFACE:npu_runtime_headers>
    -Wl,--as-needed
    -lpthread
)

############ adump utest ###########
add_subdirectory(adx_hdc_dump)
add_subdirectory(adx_soc_dump)
add_subdirectory(adump_base)

set(ADUMP_UT_SUB_TARGETS
    adx_hdc_dump_utest
    adx_soc_dump_utest
    adump_base_utest
)

add_custom_target(adump_ut DEPENDS ${ADUMP_UT_SUB_TARGETS})