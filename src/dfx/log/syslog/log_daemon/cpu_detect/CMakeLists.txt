# -----------------------------------------------------------------------------------------------------------
# Copyright (c) 2025 Huawei Technologies Co., Ltd.
# This program is free software, you can redistribute it and/or modify it under the terms and conditions of
# CANN Open Software License Agreement Version 2.0 (the "License").
# Please refer to the License for details. You may not use this file except in compliance with the License.
# THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
# INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
# See LICENSE in the root of the software repository for the full text of the License.
# -----------------------------------------------------------------------------------------------------------
set(libcpuDeviceSrcFiles
    ${CMAKE_CURRENT_SOURCE_DIR}/cpu_detect.c
)

set(libcpuDeviceDir
    ${RUNTIME_DIR}/inc/driver
    ${RUNTIME_DIR}/abl/libc_sec/include
    ${TOOLAHCIN_LOG_DIR}/utils
    ${TOOLAHCIN_LOG_DIR}/syslog/log_daemon/cpu_detect
    ${RUNTIME_DIR}/abl/adump/external
)

###################################################################
add_library(cpu_detect_server STATIC
    ${libcpuDeviceSrcFiles})

target_include_directories(cpu_detect_server PRIVATE
    ${libcpuDeviceDir}
    ../include
    ../server_mgr
)

target_compile_definitions(cpu_detect_server PRIVATE
    $<$<STREQUAL:${TARGET_SYSTEM_NAME},Windows>:OS_TYPE_DEF=1>
    $<$<NOT:$<STREQUAL:${TARGET_SYSTEM_NAME},Windows>>:OS_TYPE_DEF=0>
)

target_compile_options(cpu_detect_server PRIVATE
    -Wfloat-equal -Wextra
    $<$<CONFIG:Debug>:-g -O0>
    $<$<CONFIG:Release>:-Os>
    -Wunused
    -Wshadow
    -Wundef
    -Werror
    -fPIE
    -fstack-protector-strong
    -fno-common
    -fsigned-char
    -fno-strict-aliasing
    -fdata-sections
    -ffunction-sections
    -std=gnu11
)

target_link_options(cpu_detect_server PRIVATE
    -Wl,-z,relro,-z,now,-z,noexecstack
    -Wl,--gc-sections
)

target_link_libraries(cpu_detect_server PRIVATE
    $<BUILD_INTERFACE:intf_pub>
    $<BUILD_INTERFACE:mmpa_headers>
    $<BUILD_INTERFACE:adump_headers>
    $<BUILD_INTERFACE:slog_headers>
    c_sec
    -ldl
)

set_target_properties(cpu_detect_server
    PROPERTIES
    OUTPUT_NAME cpu_detect_server
)
