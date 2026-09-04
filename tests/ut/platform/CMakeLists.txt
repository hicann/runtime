# -----------------------------------------------------------------------------------------------------------
# Copyright (c) 2025 Huawei Technologies Co., Ltd.
# This program is free software, you can redistribute it and/or modify it under the terms and conditions of
# CANN Open Software License Agreement Version 2.0 (the "License").
# Please refer to the License for details. You may not use this file except in compliance with the License.
# THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
# INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
# See LICENSE in the root of the software repository for the full text of the License.
# -----------------------------------------------------------------------------------------------------------

set(CMAKE_CXX_STANDARD 14)

file(GLOB FE_SRC_CPP_1 RELATIVE ${CMAKE_CURRENT_LIST_DIR}
        "${TOP_DIR}/src/platform/acl_platform.cpp"
        "${TOP_DIR}/src/platform/platform_info.cpp"
        "${TOP_DIR}/src/platform/platform_infos_def.cpp"
        "${TOP_DIR}/src/platform/platform_infos_impl.cpp"
        "${TOP_DIR}/src/platform/platform_infos_utils.cpp")


add_library(platform_llt SHARED
        ${FE_SRC_CPP_1}
        ${PROTO_SRCS})

set_target_properties(platform_llt
        PROPERTIES
        OUTPUT_NAME platform
        LIBRARY_OUTPUT_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR})

target_include_directories(platform_llt PRIVATE
        ${TOP_DIR}/include/dfx/base
        ${TOP_DIR}/include/external
        ${TOP_DIR}/pkg_inc
        ${TOP_DIR}/pkg_inc/base
        ${TOP_DIR}/include/dfx/base
        ${CMAKE_BINARY_DIR}/proto/platform_infos_proto
)

target_compile_definitions(platform_llt PRIVATE
    google=ascend_private
)

target_compile_options(platform_llt PRIVATE
        $<$<COMPILE_LANGUAGE:CXX>:-std=c++14>
        -Werror)

add_library(intf_ut_pub INTERFACE)

target_compile_definitions(intf_ut_pub INTERFACE
    _OPEN_SOURCE_LLT_
    CFG_BUILD_DEBUG
    _GLIBCXX_USE_CXX11_ABI=0
)

target_compile_options(intf_ut_pub INTERFACE
    -g
    -w
    $<$<BOOL:${ENABLE_GCOV}>:-fprofile-arcs -ftest-coverage>
    $<$<BOOL:${ENABLE_ASAN}>:-fsanitize=address -fno-omit-frame-pointer -static-libasan -fsanitize=undefined -static-libubsan -fsanitize=leak -static-libtsan>
    -fPIC
    -pipe
)

target_link_options(intf_ut_pub INTERFACE
    $<$<BOOL:${ENABLE_GCOV}>:-fprofile-arcs -ftest-coverage>
    $<$<BOOL:${ENABLE_ASAN}>:-fsanitize=address -static-libasan -fsanitize=undefined  -static-libubsan -fsanitize=leak -static-libtsan>
)

target_link_directories(intf_ut_pub INTERFACE
)

target_link_libraries(intf_ut_pub INTERFACE
    GTestShared::gtest
    mockcpp
    -lpthread
    $<$<BOOL:${ENABLE_GCOV}>:-lgcov>
)

target_link_libraries(platform_llt PRIVATE
        $<BUILD_INTERFACE:intf_ut_pub>
        -Wl,--no-as-needed
        -Wl,--no-as-needed
        -ldl
        ascend_protobuf
)

add_library(platform_llt_tiling SHARED
        ${FE_SRC_CPP_1}
        ${PROTO_SRCS})

set_target_properties(platform_llt_tiling
        PROPERTIES
        OUTPUT_NAME platform
        LIBRARY_OUTPUT_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR})

target_include_directories(platform_llt_tiling PRIVATE
        ${TOP_DIR}/include/dfx/base
        ${TOP_DIR}/include/external
        ${TOP_DIR}/pkg_inc
        ${TOP_DIR}/pkg_inc/base
        ${TOP_DIR}/include/dfx/base
        ${CMAKE_BINARY_DIR}/proto/platform_infos_proto
)

target_compile_definitions(platform_llt_tiling PRIVATE
    google=ascend_private
)

target_compile_options(platform_llt_tiling PRIVATE
        $<$<COMPILE_LANGUAGE:CXX>:-std=c++14>
        -Werror
        -D_GLIBCXX_USE_CXX11_ABI=0)

target_link_libraries(platform_llt_tiling PRIVATE
        -Wl,--no-as-needed
        -Wl,--no-as-needed
        -ldl
        ascend_protobuf
)

add_dependencies(platform_llt platform_infos_proto)

add_dependencies(platform_llt_tiling platform_infos_proto)

set(INSTALL_BASE_DIR "")
set(INSTALL_INCLUDE_DIR include)
set(INSTALL_LIBRARY_DIR lib)
set(INSTALL_CONFIG_DIR  lib/cmake)
add_subdirectory(ut)
