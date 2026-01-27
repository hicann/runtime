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
set(proto_src_files
    ${CMAKE_CURRENT_SOURCE_DIR}/proto/easycom_message.proto
    ${CMAKE_CURRENT_SOURCE_DIR}/proto/dynamic_sched_message.proto
)

protobuf_generate(aicpu PROTO_SRCS PROTO_HDRS ${proto_src_files})

# qs_client
set(qs_client_files
    ${CMAKE_CURRENT_SOURCE_DIR}/ezcom_client.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/bqs_client.cpp
    ${PROTO_SRCS}
)
set (qs_client_path
    ${CMAKE_CURRENT_SOURCE_DIR}/inc/stub
    ${CMAKE_CURRENT_SOURCE_DIR}/inc
    ${QUEUE_SCHEDULE_DIR}/common
    ${QUEUE_SCHEDULE_DIR}
    ${RUNTIME_DIR}/include
    ${RUNTIME_DIR}/pkg_inc/aicpu/queue_schedule
    ${CMAKE_BINARY_DIR}/proto/aicpu
    ${CMAKE_BINARY_DIR}/proto/aicpu/proto
)

add_library(qs_client SHARED
     ${qs_client_files}
)

target_include_directories(qs_client PRIVATE
     ${qs_client_path}
)

target_compile_options(qs_client PRIVATE
    -rdynamic
    -O2
    -fvisibility-inlines-hidden
    -fvisibility=hidden
    $<$<STREQUAL:${RESERVED_SYMBOL},true>:-g>
)

target_compile_definitions(qs_client PRIVATE
    STATISTIC
    VISIBILITY
    RUN_ON_AICPU
    google=ascend_private
)

target_link_libraries(qs_client PRIVATE
    $<BUILD_INTERFACE:intf_pub_cxx17>
    -Wl,-Bsymbolic -Wl,--exclude-libs,ALL
    -rdynamic
    $<$<OR:$<STREQUAL:${PRODUCT},ascend610>,$<STREQUAL:${PRODUCT},ascend610Lite>,$<STREQUAL:${PRODUCT},ascend615>,$<STREQUAL:${PRODUCT},ascend310Brc>,$<STREQUAL:${PRODUCT},as31xm1>,$<STREQUAL:${PRODUCT},mc62cm12aesl>,$<STREQUAL:${PRODUCT},mc62cm12a>>:easy_comm>
    c_sec
    -Wl,--no-as-needed
    unified_dlog
    -Wl,--as-needed
    ascend_protobuf_static
    $<BUILD_INTERFACE:c_sec_headers>
)

