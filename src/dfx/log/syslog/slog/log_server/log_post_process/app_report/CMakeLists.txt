# -----------------------------------------------------------------------------------------------------------
# Copyright (c) 2025 Huawei Technologies Co., Ltd.
# This program is free software, you can redistribute it and/or modify it under the terms and conditions of
# CANN Open Software License Agreement Version 2.0 (the "License").
# Please refer to the License for details. You may not use this file except in compliance with the License.
# THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
# INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
# See LICENSE in the root of the software repository for the full text of the License.
# -----------------------------------------------------------------------------------------------------------
########liblog_server
set(logServerHeaders
    ${CMAKE_CURRENT_SOURCE_DIR}
    ${CMAKE_CURRENT_SOURCE_DIR}/../../../../../utils
    ${CMAKE_CURRENT_SOURCE_DIR}/../../../../common/driver
    ${CMAKE_CURRENT_SOURCE_DIR}/../../
    ${CMAKE_CURRENT_SOURCE_DIR}/../session_mgr
    ${RUNTIME_DIR}/inc/driver
)

set(logServerSrcList
    ${CMAKE_CURRENT_SOURCE_DIR}/../session_mgr/log_hdc_server.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/log_hdc.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/../session_mgr/log_session_manage.c
)

set(no_needed_linklibs )
set(needed_linklibs )
list(APPEND no_needed_linklibs c_sec mmpa slog adcore msn_report)
list(APPEND needed_linklibs ascend_hal)

add_library(log_server STATIC
    ${logServerSrcList}
)

target_include_directories(log_server PRIVATE
    ${logServerHeaders}
)

target_compile_options(log_server PRIVATE
    -fstack-protector-strong
    -fno-common
    -fno-strict-aliasing
    -Wfloat-equal -Wextra
    $<$<CONFIG:Debug>:-g -O0>
    $<$<CONFIG:Release>:-Os>
)

target_compile_definitions(log_server PRIVATE
    OS_TYPE=0
)

target_link_libraries(log_server PRIVATE
    $<BUILD_INTERFACE:intf_pub>
    $<BUILD_INTERFACE:mmpa_headers>
    $<BUILD_INTERFACE:adump_headers>
    $<BUILD_INTERFACE:slog_headers>
    $<BUILD_INTERFACE:adcore_headers>
    -Wl,--no-as-needed
    ${no_needed_linklibs}
    -Wl,--as-needed
    ${needed_linklibs}
)
