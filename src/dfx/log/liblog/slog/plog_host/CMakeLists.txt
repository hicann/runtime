# -----------------------------------------------------------------------------------------------------------
# Copyright (c) 2025 Huawei Technologies Co., Ltd.
# This program is free software, you can redistribute it and/or modify it under the terms and conditions of
# CANN Open Software License Agreement Version 2.0 (the "License").
# Please refer to the License for details. You may not use this file except in compliance with the License.
# THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
# INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
# See LICENSE in the root of the software repository for the full text of the License.
# -----------------------------------------------------------------------------------------------------------

############################# libalog.so(linux)   #############################
set(libalogSrcFiles
    ${CMAKE_CURRENT_SOURCE_DIR}/../alog_to_slog.c
    ${CMAKE_CURRENT_SOURCE_DIR}/../dlog_core.c
    ${CMAKE_CURRENT_SOURCE_DIR}/../slog_api.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/../dlog_time.c
    ${CMAKE_CURRENT_SOURCE_DIR}/../dlog_attr.c
    ${CMAKE_CURRENT_SOURCE_DIR}/../dlog_message.c
    ${CMAKE_CURRENT_SOURCE_DIR}/../dlog_console.c
    ${CMAKE_CURRENT_SOURCE_DIR}/../dlog_level_env.c
    ${CMAKE_CURRENT_SOURCE_DIR}/../dlog_level_mgr.c
    ${CMAKE_CURRENT_SOURCE_DIR}/../dlog_communication/dlog_socket.c
    ${CMAKE_CURRENT_SOURCE_DIR}/../dlog_communication/dlog_shm_control.c
    ${CMAKE_CURRENT_SOURCE_DIR}/../../../utils/log_print_syslog.c
    ${CMAKE_CURRENT_SOURCE_DIR}/../../../utils/log_system_api.c
    ${CMAKE_CURRENT_SOURCE_DIR}/../../../utils/share_mem.c
    ${CMAKE_CURRENT_SOURCE_DIR}/../../../utils/log_time.c
)

set(libalogHeaderDir
    ${LIBC_SEC_HEADER}
    ${CMAKE_CURRENT_SOURCE_DIR}/../../../utils
    ${CMAKE_CURRENT_SOURCE_DIR}/../dlog_communication
    ${CMAKE_CURRENT_SOURCE_DIR}/../plog
    ${CMAKE_CURRENT_SOURCE_DIR}/../
    ${TOOLAHCIN_LOG_DIR}/../../../include/driver
    ${CMAKE_CURRENT_SOURCE_DIR}/../../../../../../pkg_inc/mmpa
    ${TOOLAHCIN_LOG_DIR}/inc/toolchain
)

set(CMAKE_C_STANDARD 11)
set(CMAKE_CXX_STANDARD 11)

add_library(slog
    SHARED
        ${libalogSrcFiles})

target_include_directories(slog
    PRIVATE
        ${libalogHeaderDir})

target_compile_definitions(slog
    PRIVATE
        OS_TYPE_DEF=0
        OS_TYPE=0
        WRITE_TO_SYSLOG
    PUBLIC
        LOG_CPP
        PROCESS_LOG
)

target_compile_options(slog
    PRIVATE
        -Werror
        -Wfloat-equal -Wextra
        -Wunused
        -Wshadow
        -Wundef
        $<$<CONFIG:Debug>:-g -O0>
        $<$<CONFIG:Release>:-Os -D_FORTIFY_SOURCE=2>
        -fPIC
        -fstack-protector-strong
        -fno-common
        -fsigned-char
        -fno-strict-aliasing
        -fvisibility=hidden
        -fdata-sections
        -ffunction-sections
)

target_link_options(slog
    PRIVATE
        -Wl,-z,relro,-z,now,-z,noexecstack
        -Wl,--gc-sections
)

target_link_libraries(slog
    PRIVATE
        $<BUILD_INTERFACE:intf_pub>
        c_sec
        -Wl,--whole-archive;static_plog_cpp;-Wl,--no-whole-archive
        mmpa
    PUBLIC
        slog_headers
)

set_target_properties(slog
    PROPERTIES
    WINDOWS_EXPORT_ALL_SYMBOLS TRUE
    OUTPUT_NAME $<IF:$<STREQUAL:${TARGET_SYSTEM_NAME},Windows>,libascendalog,ascendalog>
)

############################# libalog.so(linux)   #############################
add_library(alog
    SHARED
        ${libalogSrcFiles})

add_dependencies(slog alog)

target_include_directories(alog
    PRIVATE
        ${libalogHeaderDir})

target_compile_definitions(alog
    PRIVATE
        OS_TYPE_DEF=0
        OS_TYPE=0
        WRITE_TO_SYSLOG
    PUBLIC
        LOG_CPP
        PROCESS_LOG
)

target_compile_options(alog
    PRIVATE
        -Werror
        -Wfloat-equal -Wextra
        -Wunused
        -Wshadow
        -Wundef
        -fvisibility=hidden
        $<$<CONFIG:Debug>:-g -O0>
        $<$<CONFIG:Release>:-Os -D_FORTIFY_SOURCE=2>
        -fPIC
        -fstack-protector-strong
        -fno-common
        -fsigned-char
        -fno-strict-aliasing
        -fdata-sections
        -ffunction-sections
)

target_link_options(alog
    PRIVATE
        -Wl,-z,relro,-z,now,-z,noexecstack
        -Wl,--gc-sections
        $<$<CONFIG:Release>:-s>
)

target_link_libraries(alog
    PRIVATE
        $<BUILD_INTERFACE:intf_pub>
        mmpa
        "$<$<STREQUAL:${TARGET_SYSTEM_NAME},Windows>:adump_headers>"
        c_sec
        "$<$<NOT:$<STREQUAL:${TARGET_SYSTEM_NAME},Windows>>:-Wl,--whole-archive;static_plog_cpp;-Wl,--no-whole-archive>"
    PUBLIC
        slog_headers
)

set_target_properties(alog
    PROPERTIES
    WINDOWS_EXPORT_ALL_SYMBOLS TRUE
    LIBRARY_OUTPUT_DIRECTORY alog
    OUTPUT_NAME $<IF:$<STREQUAL:${TARGET_SYSTEM_NAME},Windows>,libascendalog,ascendalog>
)

install(TARGETS alog
    LIBRARY DESTINATION ${INSTALL_LIBRARY_DIR}/${CMAKE_SYSTEM_PROCESSOR} OPTIONAL
)

############################# libunified_npu_log.so(linux)   #############################
add_library(unified_dlog
    SHARED
        ${libalogSrcFiles})

add_dependencies(slog unified_dlog)

target_include_directories(unified_dlog
    PRIVATE
        ${libalogHeaderDir})

target_compile_definitions(unified_dlog
    PRIVATE
        OS_TYPE_DEF=0
        OS_TYPE=0
        WRITE_TO_SYSLOG
    PUBLIC
        PROCESS_LOG
        APP_LOG
)

target_compile_options(unified_dlog
    PRIVATE
        -Werror
        -Wfloat-equal -Wextra
        -Wunused
        -Wshadow
        -Wundef
        -fvisibility=hidden
        $<$<CONFIG:Debug>:-g -O0>
        $<$<CONFIG:Release>:-Os -D_FORTIFY_SOURCE=2>
        -fPIC
        -fstack-protector-strong
        -fno-common
        -fsigned-char
        -fno-strict-aliasing
        -fdata-sections
        -ffunction-sections
)

target_link_options(unified_dlog
    PRIVATE
        -Wl,-z,relro,-z,now,-z,noexecstack
        -Wl,--gc-sections
)

target_link_libraries(unified_dlog
    PRIVATE
        $<BUILD_INTERFACE:intf_pub>
        mmpa
        c_sec
        -Wl,--whole-archive;static_plog;-Wl,--no-whole-archive
    PUBLIC
        slog_headers
)

set_target_properties(unified_dlog
    PROPERTIES
    WINDOWS_EXPORT_ALL_SYMBOLS TRUE
    LIBRARY_OUTPUT_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}/unified_dlog
    OUTPUT_NAME $<IF:$<STREQUAL:${TARGET_SYSTEM_NAME},Windows>,libunified_dlog,unified_dlog>
)

install(TARGETS unified_dlog
    LIBRARY DESTINATION ${INSTALL_LIBRARY_DIR} OPTIONAL
)

install(TARGETS unified_dlog
    LIBRARY DESTINATION ${INSTALL_LIBRARY_DIR}/${CMAKE_SYSTEM_PROCESSOR} OPTIONAL
)