# -----------------------------------------------------------------------------------------------------------
# Copyright (c) 2025 Huawei Technologies Co., Ltd.
# This program is free software, you can redistribute it and/or modify it under the terms and conditions of
# CANN Open Software License Agreement Version 2.0 (the "License").
# Please refer to the License for details. You may not use this file except in compliance with the License.
# THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
# INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
# See LICENSE in the root of the software repository for the full text of the License.
# -----------------------------------------------------------------------------------------------------------
cmake_minimum_required(VERSION 3.12)
project(tsdclient)

set(BASE_DIR ${CMAKE_CURRENT_SOURCE_DIR}/..)
set(RUNTIME_TSD_DIR ${BASE_DIR})
set(RUNTIME_DIR ${BASE_DIR}/../..)

include(${BASE_DIR}/tsdclient_sources.cmake)

set(PROTO_LIST
    ${BASE_DIR}/pub_facility/proto/tsd_message.proto
)

# SHA256 ARM加速路径需要 -march=armv8-a+crypto，仅对该文件生效，避免影响其他代码
if(CMAKE_SYSTEM_PROCESSOR STREQUAL "aarch64")
    set_source_files_properties(
        ${BASE_DIR}/pub_facility/util_func/tsd_sha256.cpp
        PROPERTIES COMPILE_FLAGS "-march=armv8-a+crypto"
    )
endif()

protobuf_generate(tsd_host_proto PROTO_SRCS PROTO_HDRS ${PROTO_LIST} TARGET)
    
add_library(tsdclient SHARED
    ${tsdclient_all_sources}
    ${BASE_DIR}/common/stub/stub_dc.cpp
    ${PROTO_SRCS}
)

add_dependencies(tsdclient tsd_host_proto)

target_include_directories(tsdclient PRIVATE
    ${tsdclient_include_dirs}
    ${CMAKE_BINARY_DIR}/proto/tsd_host_proto/
)

target_compile_options(tsdclient PRIVATE
    -O2
    -fno-common
    -fvisibility-inlines-hidden
    -fstack-protector-strong
    -Wl,-z,now
    $<$<STREQUAL:${RESERVED_SYMBOL},true>:-g>
    $<$<STREQUAL:${ascend031},true>:TINY_RUNTIME>
)

target_compile_definitions(tsdclient PRIVATE
    TDT_HOST_LIB
    TSD_HOST_LIB
    NOT_COVERAGE_BY_UT
    google=ascend_private
)

target_link_options(tsdclient PRIVATE
    -rdynamic
    -ldl
    -lrt
    -Wl,-Bsymbolic
    -Wl,--exclude-libs,ALL
)

target_link_libraries(tsdclient PRIVATE
    $<BUILD_INTERFACE:intf_pub>
    -Wl,--no-as-needed
    ascend_protobuf_static
    c_sec 
    mmpa
    ascend_hal_stub
    dl
    unified_dlog
    -Wl,--as-needed
    error_manager
    $<BUILD_INTERFACE:c_sec_headers>
    platform
)

add_dependencies(tsdclient platform)
