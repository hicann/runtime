# -----------------------------------------------------------------------------------------------------------
# Copyright (c) 2025 Huawei Technologies Co., Ltd.
# This program is free software, you can redistribute it and/or modify it under the terms and conditions of
# CANN Open Software License Agreement Version 2.0 (the "License").
# Please refer to the License for details. You may not use this file except in compliance with the License.
# THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
# INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
# See LICENSE in the root of the software repository for the full text of the License.
# -----------------------------------------------------------------------------------------------------------
set(sysMonitorSrcFiles
    ${CMAKE_CURRENT_SOURCE_DIR}/sys_monitor_frame.c
    ${CMAKE_CURRENT_SOURCE_DIR}/sys_cpu_monitor.c
    ${CMAKE_CURRENT_SOURCE_DIR}/sys_memory_monitor.c
    ${CMAKE_CURRENT_SOURCE_DIR}/sys_fd_monitor.c
    ${CMAKE_CURRENT_SOURCE_DIR}/sys_zp_monitor.c
    ${TOOLAHCIN_LOG_DIR}/utils/log_time.c
)

set(sysMonitorDir
    ${TOOLAHCIN_LOG_DIR}/utils
)

###################################################################
add_library(sys_monitor STATIC
    ${sysMonitorSrcFiles})

target_include_directories(sys_monitor PRIVATE
    ${sysMonitorDir})

target_compile_definitions(sys_monitor PRIVATE
    $<$<STREQUAL:${TARGET_SYSTEM_NAME},Windows>:OS_TYPE_DEF=1>
    $<$<NOT:$<STREQUAL:${TARGET_SYSTEM_NAME},Windows>>:OS_TYPE_DEF=0>
)

target_compile_options(sys_monitor PRIVATE
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

target_link_options(sys_monitor PRIVATE
    -Wl,-z,relro,-z,now,-z,noexecstack
    -Wl,--gc-sections
)

target_link_libraries(sys_monitor PRIVATE
    $<BUILD_INTERFACE:intf_pub>
    $<BUILD_INTERFACE:mmpa_headers>
    $<BUILD_INTERFACE:slog_headers>
    c_sec
    slog
)

set_target_properties(sys_monitor
    PROPERTIES
    OUTPUT_NAME sys_monitor
)