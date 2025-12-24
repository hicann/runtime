# -----------------------------------------------------------------------------------------------------------
# Copyright (c) 2025 Huawei Technologies Co., Ltd.
# This program is free software, you can redistribute it and/or modify it under the terms and conditions of
# CANN Open Software License Agreement Version 2.0 (the "License").
# Please refer to the License for details. You may not use this file except in compliance with the License.
# THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
# INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
# See LICENSE in the root of the software repository for the full text of the License.
# -----------------------------------------------------------------------------------------------------------
############################# libutrace_server.so(linux)   #############################
set(libutraceserverSrcFiles
    ${CMAKE_CURRENT_SOURCE_DIR}/trace_server.c
    ${CMAKE_CURRENT_SOURCE_DIR}/trace_server_core.c
    ${CMAKE_CURRENT_SOURCE_DIR}/ktrace_ts/ktrace_ts.c
    ${CMAKE_CURRENT_SOURCE_DIR}/send_mgr/trace_send_mgr.c
    ${CMAKE_CURRENT_SOURCE_DIR}/send_mgr/trace_server_mgr.c
    ${CMAKE_CURRENT_SOURCE_DIR}/send_mgr/trace_adx_api.c
    ${CMAKE_CURRENT_SOURCE_DIR}/session_mgr/trace_session_mgr.c
    ${CMAKE_CURRENT_SOURCE_DIR}/session_mgr/trace_queue.c
    ${CMAKE_CURRENT_SOURCE_DIR}/session_mgr/trace_node.c
    ${CMAKE_CURRENT_SOURCE_DIR}/utrace_server/trace_server_socket.c
    ${CMAKE_CURRENT_SOURCE_DIR}/../utils/trace_system_api.c
)

set(libutraceserverHeaderDir
    ${CMAKE_CURRENT_SOURCE_DIR}
    ${CMAKE_CURRENT_SOURCE_DIR}/ktrace_ts
    ${CMAKE_CURRENT_SOURCE_DIR}/send_mgr
    ${CMAKE_CURRENT_SOURCE_DIR}/session_mgr
    ${CMAKE_CURRENT_SOURCE_DIR}/utrace_server
    ${CMAKE_CURRENT_SOURCE_DIR}/../utils
    ${CMAKE_CURRENT_SOURCE_DIR}/../../inc/utrace
    ${CMAKE_CURRENT_SOURCE_DIR}/../../inc/trace_server
    ${ATRACE_DIR}/common
    ${RUNTIME_DIR}/inc/driver
    ${RUNTIME_DIR}/abl/adump/inc/adump
    ${RUNTIME_DIR}/abl/adump/external
)

add_library(utrace_server_share
    SHARED
        ${libutraceserverSrcFiles}
        ${adiagCommonFiles})

target_include_directories(utrace_server_share
    PRIVATE
        ${LIBC_SEC_HEADER}
        ${libutraceserverHeaderDir})

target_compile_definitions(utrace_server_share
    PRIVATE
    PUBLIC
)

target_compile_options(utrace_server_share
    PRIVATE
        ${ADIAG_COMMON_COMPILE_OPTIONS}
        $<$<CONFIG:Debug>:-g -O0>
        $<$<CONFIG:Release>:-Os -D_FORTIFY_SOURCE=2>
        -std=gnu11
        -fPIC
        -fstack-protector-strong
        -fno-common
        -fsigned-char
        -fno-strict-aliasing
        -fdata-sections
        -ffunction-sections
        -fvisibility=hidden
)

target_link_options(utrace_server_share
    PRIVATE
        -Wl,-z,relro,-z,now,-z,noexecstack
        -Wl,--gc-sections
)

target_link_libraries(utrace_server_share
    PRIVATE
        $<BUILD_INTERFACE:intf_pub>
        $<BUILD_INTERFACE:slog_headers>
        $<BUILD_INTERFACE:mmpa_headers>
        mmpa
        unified_dlog
        ascend_hal
        adcore
    PUBLIC
        atrace_headers
)

target_compile_definitions(utrace_server_share
    PRIVATE
        OS_TYPE=0
)
set_target_properties(utrace_server_share
    PROPERTIES
    WINDOWS_EXPORT_ALL_SYMBOLS TRUE
    OUTPUT_NAME utrace_server
)

install_package(
    TARGETS utrace_server_share atrace_headers
    FILES   ${ATRACE_DIR}/../../include/trace_server/trace_server.h
            ${ATRACE_DIR}/../../include/utrace/atrace_types.h
    DESTINATION ${INSTALL_INCLUDE_DIR}/atrace/utrace
)