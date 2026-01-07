# -----------------------------------------------------------------------------------------------------------
# Copyright (c) 2025 Huawei Technologies Co., Ltd.
# This program is free software, you can redistribute it and/or modify it under the terms and conditions of
# CANN Open Software License Agreement Version 2.0 (the "License").
# Please refer to the License for details. You may not use this file except in compliance with the License.
# THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
# INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
# See LICENSE in the root of the software repository for the full text of the License.
# -----------------------------------------------------------------------------------------------------------
set(libawatchdogSrcFiles
    ${CMAKE_CURRENT_SOURCE_DIR}/awatchdog.c
    ${CMAKE_CURRENT_SOURCE_DIR}/awatchdog_core.c
    ${CMAKE_CURRENT_SOURCE_DIR}/awatchdog_monitor.c
)

set(libawatchdogHeaderDir
    ${CMAKE_CURRENT_SOURCE_DIR}
    ${ATRACE_DIR}/common
    ${LIBC_SEC_HEADER}
    ${ATRACE_DIR}/../../../include/driver
    ${ATRACE_DIR}/inc/toolchain
    ${ATRACE_DIR}/../../../pkg_inc/mmpa
)

add_library(awatchdog_share
    SHARED
        ${libawatchdogSrcFiles}
        ${adiagCommonFiles})

target_include_directories(awatchdog_share
    PRIVATE
        ${LIBC_SEC_HEADER}
        ${ATRACE_DIR}/../../../include/driver
        ${libawatchdogHeaderDir})

target_compile_definitions(awatchdog_share
    PRIVATE
    PUBLIC
)

target_compile_options(awatchdog_share
    PRIVATE
        -Wcast-qual
        ${ADIAG_COMMON_COMPILE_OPTIONS}
        $<$<CONFIG:Debug>:-g -O0>
        $<$<CONFIG:Release>:-Os -D_FORTIFY_SOURCE=2>
        -fPIC
        -std=gnu11
        -fstack-protector-strong
        -fno-common
        -fvisibility=hidden
)

target_link_options(awatchdog_share
    PRIVATE
        -Wl,-z,relro,-z,now,-z,noexecstack
        -Wl,--gc-sections
)

target_link_libraries(awatchdog_share
    PRIVATE
        $<BUILD_INTERFACE:intf_pub>
        $<BUILD_INTERFACE:slog_headers>
        mmpa
        unified_dlog
    PUBLIC
        $<BUILD_INTERFACE:awatchdog_headers>
)

target_compile_definitions(awatchdog_share
    PRIVATE
        OS_TYPE=0
        _GNU_SOURCE
)

set_target_properties(awatchdog_share
    PROPERTIES
    WINDOWS_EXPORT_ALL_SYMBOLS TRUE
    OUTPUT_NAME ascend_watchdog
)

# install_package(
#     PACKAGE awatchdog
#     TARGETS awatchdog_share awatchdog_headers
#     FILES   ${ATRACE_DIR}/../../include/awatchdog/awatchdog_types.h
#             ${ATRACE_DIR}/../../include/awatchdog/awatchdog.h
#     DESTINATION ${INSTALL_INCLUDE_DIR}/awatchdog
# )

############################# libascend_watchdog_stub.so(linux)   #############################

add_library(awatchdog_stub_share
    SHARED
        ${CMAKE_CURRENT_SOURCE_DIR}/awatchdog_stub.c)


target_include_directories(awatchdog_stub_share
    PRIVATE
        ${LIBC_SEC_HEADER}
        ${libawatchdogHeaderDir})

target_compile_definitions(awatchdog_stub_share
    PRIVATE
    PUBLIC
)

target_compile_options(awatchdog_stub_share
    PRIVATE
        -Wcast-qual
        ${ADIAG_COMMON_COMPILE_OPTIONS}
        $<$<CONFIG:Debug>:-g -O0>
        $<$<CONFIG:Release>:-Os -D_FORTIFY_SOURCE=2>
        -fPIC
        -std=gnu11
        -fstack-protector-strong
        -fno-common
        -fvisibility=hidden
)

target_link_options(awatchdog_stub_share
    PRIVATE
        -Wl,-z,relro,-z,now,-z,noexecstack
        -Wl,--gc-sections
)

target_link_libraries(awatchdog_stub_share
    PRIVATE
        # $<BUILD_INTERFACE:intf_pub>
    PUBLIC
        $<BUILD_INTERFACE:awatchdog_headers>
)

target_compile_definitions(awatchdog_stub_share
    PRIVATE
        OS_TYPE=0
        _GNU_SOURCE
)

set_target_properties(awatchdog_stub_share
    PROPERTIES
    LIBRARY_OUTPUT_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}/stub
    WINDOWS_EXPORT_ALL_SYMBOLS TRUE
    OUTPUT_NAME ascend_watchdog
)

install(TARGETS awatchdog_stub_share OPTIONAL
    LIBRARY DESTINATION ${INSTALL_LIBRARY_DIR}/stub
)