# -----------------------------------------------------------------------------------------------------------
# Copyright (c) 2025 Huawei Technologies Co., Ltd.
# This program is free software, you can redistribute it and/or modify it under the terms and conditions of
# CANN Open Software License Agreement Version 2.0 (the "License").
# Please refer to the License for details. You may not use this file except in compliance with the License.
# THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
# INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
# See LICENSE in the root of the software repository for the full text of the License.
# -----------------------------------------------------------------------------------------------------------

set(QUEUE_SCHEDULE_DIR ${CMAKE_CURRENT_SOURCE_DIR}/..)

set(dgw_client_file
    ${CMAKE_CURRENT_SOURCE_DIR}/dgw_client.cpp
)
set(dgw_client_inc_path
    ${QUEUE_SCHEDULE_DIR}
    ${QUEUE_SCHEDULE_DIR}/common
    ${RUNTIME_DIR}/pkg_inc
    ${RUNTIME_DIR}/pkg_inc/queue_schedule
    ${RUNTIME_DIR}/pkg_inc/profiling
    ${RUNTIME_DIR}/include
    ${RUNTIME_DIR}/include/driver
    ${RUNTIME_DIR}/src/inc
    ${CMAKE_CURRENT_SOURCE_DIR}
    ${CMAKE_BINARY_DIR}/proto/aicpu
    ${CMAKE_BINARY_DIR}/proto/aicpu/proto  
)

# dgw_client_so
add_library(dgw_client SHARED
    ${dgw_client_file}
    ${QUEUE_SCHEDULE_DIR}/common/feature_ctrl_open.cpp
)
target_include_directories(dgw_client PRIVATE
    ${dgw_client_inc_path}
)

target_compile_options(dgw_client PRIVATE
    -ftrapv
    -O2
    -fvisibility-inlines-hidden
    -fvisibility=hidden
    $<$<STREQUAL:${RESERVED_SYMBOL},true>:-g>
)

target_link_libraries(dgw_client
    PRIVATE
        $<BUILD_INTERFACE:intf_pub_cxx17>
        c_sec
        -Wl,--no-as-needed
        unified_dlog
        -Wl,--as-needed
        ascend_hal_stub
        $<BUILD_INTERFACE:c_sec_headers>
)

target_compile_definitions(dgw_client PRIVATE
    RUN_ON_AICPU
    _FORTIFY_SOURCE=2
)