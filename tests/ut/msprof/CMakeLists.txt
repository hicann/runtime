# -----------------------------------------------------------------------------------------------------------
# Copyright (c) 2025 Huawei Technologies Co., Ltd.
# This program is free software, you can redistribute it and/or modify it under the terms and conditions of
# CANN Open Software License Agreement Version 2.0 (the "License").
# Please refer to the License for details. You may not use this file except in compliance with the License.
# THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
# INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
# See LICENSE in the root of the software repository for the full text of the License.
# -----------------------------------------------------------------------------------------------------------
set(MSPROF_SOURCE_DIR ${TOP_DIR}/src/dfx/msprof/collector)

include_directories(${OPEN_SOURCE_DIR}/boost)
include_directories(${OPEN_SOURCE_DIR}/mockcpp_src/include)

############# intf_llt_pub ####################
add_library(msprof_intf_llt_pub INTERFACE)

target_include_directories(msprof_intf_llt_pub INTERFACE
)

target_compile_definitions(msprof_intf_llt_pub INTERFACE
    CFG_BUILD_DEBUG
    _GLIBCXX_USE_CXX11_ABI=0
)
target_compile_options(msprof_intf_llt_pub INTERFACE
    -g
    -w
    $<$<BOOL:${ENABLE_GCOV}>:-fprofile-arcs -ftest-coverage>
    $<$<BOOL:${ENABLE_ASAN}>:-fsanitize=address -fno-omit-frame-pointer -static-libasan -fsanitize=undefined -static-libubsan -fsanitize=leak -static-libtsan>
    -fPIC
    -pipe
)

target_link_options(msprof_intf_llt_pub INTERFACE
    $<$<BOOL:${ENABLE_GCOV}>:-fprofile-arcs -ftest-coverage>
    $<$<BOOL:${ENABLE_ASAN}>:-fsanitize=address -static-libasan -fsanitize=undefined  -static-libubsan -fsanitize=leak -static-libtsan>
)

target_link_directories(msprof_intf_llt_pub INTERFACE
)

link_directories(${TOP_DIR}/output/third_party)

target_link_libraries(msprof_intf_llt_pub INTERFACE
    GTest::gtest
    ${OPEN_SOURCE_DIR}/mockcpp/lib/libmockcpp.a
    dl
    -lpthread
    $<$<BOOL:${ENABLE_GCOV}>:-lgcov>
    c_sec
    ascend_protobuf_static
)

############ msprof onetrack pub target for utest ############
add_library(msprof_utestonetrack_pub INTERFACE)

target_link_libraries(msprof_utestonetrack_pub INTERFACE
    $<BUILD_INTERFACE:msprof_intf_llt_pub>
    $<BUILD_INTERFACE:mmpa_headers>
    $<BUILD_INTERFACE:msprof_headers>
    $<BUILD_INTERFACE:slog_headers>
    $<BUILD_INTERFACE:msprof_headers>
    $<BUILD_INTERFACE:npu_runtime_headers>
    -Wl,--as-needed
    -lpthread
)

protobuf_generate(profiler
    CppPath
    HeaderPath
    ${MSPROF_SOURCE_DIR}/dvvp/proto/profiler.proto
)

add_subdirectory(ut/app)
add_subdirectory(ut/device)
add_subdirectory(ut/driver)
add_subdirectory(ut/message)
add_subdirectory(ut/profapi)
add_subdirectory(ut/profhal)
add_subdirectory(ut/streamio)
add_subdirectory(ut/stub_utest)
add_subdirectory(ut/transport)

###################################################################################################

set(MSPROF_TARGET
    application_utest
    message_utest
    prof_api_utest
    prof_hal_utest
    client_utest
    streamio_common_utest
    stub_file_utest
)

add_custom_target(msprof_ut DEPENDS ${MSPROF_TARGET})
