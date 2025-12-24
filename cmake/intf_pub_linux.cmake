# -----------------------------------------------------------------------------------------------------------
# Copyright (c) 2025 Huawei Technologies Co., Ltd.
# This program is free software, you can redistribute it and/or modify it under the terms and conditions of
# CANN Open Software License Agreement Version 2.0 (the "License").
# Please refer to the License for details. You may not use this file except in compliance with the License.
# THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
# INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
# See LICENSE in the root of the software repository for the full text of the License.
# -----------------------------------------------------------------------------------------------------------

include_guard(GLOBAL)
if (TARGET intf_pub)
    return()
endif()

############ intf_pub_base ############
add_library(intf_pub_base INTERFACE)

target_compile_options(intf_pub_base INTERFACE
    -Wall
    -fPIC
    -fstack-protector-strong
    $<$<CONFIG:Debug>:-g>
    $<$<BOOL:${ENABLE_ASAN}>:-fsanitize=address -fsanitize=leak -fsanitize-recover=address,all -fno-stack-protector -fno-omit-frame-pointer -g>
)

target_compile_definitions(intf_pub_base INTERFACE
    # _GLIBCXX_USE_CXX11_ABI=0
    $<$<STREQUAL:${PRODUCT_SIDE},device>:_GLIBCXX_USE_CXX11_ABI=1>
    $<$<NOT:$<STREQUAL:${PRODUCT_SIDE},device>>:_GLIBCXX_USE_CXX11_ABI=0>
    $<$<CONFIG:Release>:CFG_BUILD_NDEBUG>
    $<$<CONFIG:Debug>:CFG_BUILD_DEBUG>
    LINUX=0
    $<$<BOOL:${ENABLE_TEST}>:SUPPORT_LARGE_MODEL_ENABLE=1>
)

target_link_options(intf_pub_base INTERFACE
    -Wl,-z,relro
    -Wl,-z,now
    -Wl,-z,noexecstack
    $<$<CONFIG:Release>:-Wl,--build-id=none>
    $<$<CONFIG:Release>:-s>
    $<$<BOOL:${ENABLE_ASAN}>:-fsanitize=address -fsanitize=leak -fsanitize-recover=address>
)

target_link_libraries(intf_pub_base INTERFACE
    -lpthread
)

############ intf_pub c++11 ############
add_library(intf_pub INTERFACE)

target_compile_options(intf_pub INTERFACE
    $<$<COMPILE_LANGUAGE:CXX>:-std=c++17>
)

target_link_libraries(intf_pub INTERFACE
    $<BUILD_INTERFACE:intf_pub_base>
)

############ intf_pub c++17 ############
add_library(intf_pub_cxx17 INTERFACE)

target_compile_options(intf_pub_cxx17 INTERFACE
    $<$<COMPILE_LANGUAGE:CXX>:-std=c++17>
)

target_link_libraries(intf_pub_cxx17 INTERFACE
    $<BUILD_INTERFACE:intf_pub_base>
)

############ ccache ############
find_program(CCACHE_FOUND ccache)
set(CMAKE_C_COMPILER_LAUNCHER ${CCACHE_FOUND} CACHE PATH "cache Compiler")
set(CMAKE_CXX_COMPILER_LAUNCHER ${CCACHE_FOUND} CACHE PATH "cache Compiler")
message(STATUS "CMAKE_C_COMPILER_LAUNCHER:${CMAKE_C_COMPILER_LAUNCHER}")
message(STATUS "CMAKE_CXX_COMPILER_LAUNCHER:${CMAKE_CXX_COMPILER_LAUNCHER}")
