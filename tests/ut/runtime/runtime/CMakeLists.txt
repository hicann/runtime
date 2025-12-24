# -----------------------------------------------------------------------------------------------------------
# Copyright (c) 2025 Huawei Technologies Co., Ltd.
# This program is free software, you can redistribute it and/or modify it under the terms and conditions of
# CANN Open Software License Agreement Version 2.0 (the "License").
# Please refer to the License for details. You may not use this file except in compliance with the License.
# THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
# INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
# See LICENSE in the root of the software repository for the full text of the License.
# -----------------------------------------------------------------------------------------------------------
add_subdirectory(test)
set(BASE_DIR ${CMAKE_CURRENT_SOURCE_DIR})
include_directories(${OPEN_SOURCE_DIR}/boost-1.87.0)

add_library(intf_llt_pub INTERFACE)

target_include_directories(intf_llt_pub INTERFACE
)

target_compile_definitions(intf_llt_pub INTERFACE
    CFG_BUILD_DEBUG
    _GLIBCXX_USE_CXX11_ABI=0
)

target_compile_options(intf_llt_pub INTERFACE
    -g
    -w
    $<$<BOOL:${ENABLE_GCOV}>:-fprofile-arcs -ftest-coverage>
    $<$<BOOL:${ENABLE_ASAN}>:-fsanitize=address -fno-omit-frame-pointer -static-libasan -fsanitize=undefined -static-libubsan -fsanitize=leak -static-libtsan>
    -fPIC
    -pipe
)

target_link_options(intf_llt_pub INTERFACE
    $<$<BOOL:${ENABLE_GCOV}>:-fprofile-arcs -ftest-coverage>
    $<$<BOOL:${ENABLE_ASAN}>:-fsanitize=address -static-libasan -fsanitize=undefined  -static-libubsan -fsanitize=leak -static-libtsan>
)

target_link_directories(intf_llt_pub INTERFACE
)

target_link_libraries(intf_llt_pub INTERFACE
    GTest::gtest
    ${OPEN_SOURCE_DIR}/mockcpp/lib/libmockcpp.a
    -lpthread
    $<$<BOOL:${ENABLE_GCOV}>:-lgcov>
)

include(CMakePackageConfigHelpers)

set(RUNTIME_TARGET
    runtime_utest_task_910B
    runtime_utest_api_910B
)
add_custom_target(runtime_ut DEPENDS ${RUNTIME_TARGET})
include_directories(${OPEN_SOURCE_DIR}/mockcpp_src/include)
