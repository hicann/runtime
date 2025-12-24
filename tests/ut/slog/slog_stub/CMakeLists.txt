# -----------------------------------------------------------------------------------------------------------
# Copyright (c) 2025 Huawei Technologies Co., Ltd.
# This program is free software, you can redistribute it and/or modify it under the terms and conditions of
# CANN Open Software License Agreement Version 2.0 (the "License").
# Please refer to the License for details. You may not use this file except in compliance with the License.
# THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
# INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
# See LICENSE in the root of the software repository for the full text of the License.
# -----------------------------------------------------------------------------------------------------------
set(TOOLCHAIN_LOG_DIR ${TOP_DIR}/abl/slog)

if(NOT TARGET slog_headers)
    add_library(slog_headers INTERFACE)
    target_include_directories(slog_headers INTERFACE
        $<BUILD_INTERFACE:${TOOLCHAIN_LOG_DIR}/inc>
        $<BUILD_INTERFACE:${TOOLCHAIN_LOG_DIR}/inc/toolchain>
        $<INSTALL_INTERFACE:include>
        $<INSTALL_INTERFACE:include/slog>
        $<INSTALL_INTERFACE:include/slog/toolchain>
    )
endif()

set(libslogSrcFiles
    ${CMAKE_CURRENT_SOURCE_DIR}/slog_stub.cc
)

set(libslogHeaderDir
    ${TOP_DIR}/abl/libc_sec/include
)

add_library(slog SHARED
    ${libslogSrcFiles})

target_include_directories(slog PRIVATE
    ${libslogHeaderDir})

target_compile_definitions(slog
    PUBLIC LOG_CPP
)

target_compile_options(slog PRIVATE
    -O2
    -Werror
)

target_link_libraries(slog
    PRIVATE
        $<BUILD_INTERFACE:intf_pub>
        c_sec
    PUBLIC
        slog_headers
)

set_target_properties(slog
    PROPERTIES
    WINDOWS_EXPORT_ALL_SYMBOLS TRUE
)

add_library(alog SHARED
    ${libslogSrcFiles})

target_include_directories(alog PRIVATE
    ${libslogHeaderDir})

target_compile_definitions(alog
    PUBLIC LOG_CPP
)

target_compile_options(alog PRIVATE
    -O2
    -Werror
)

target_link_libraries(alog
    PRIVATE
        $<BUILD_INTERFACE:intf_pub>
        c_sec
    PUBLIC
        slog_headers
)

set_target_properties(alog
    PROPERTIES
    WINDOWS_EXPORT_ALL_SYMBOLS TRUE
    OUTPUT_NAME ascendalog>
)