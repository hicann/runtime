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

set(PROTO_LIST
    ${BASE_DIR}/pub_facility/proto/tsd_message.proto
)

set(tdt_common_files
    ${BASE_DIR}/basic_component/device_comm/hdc_common.cpp
    ${BASE_DIR}/common/src/message_parse_interface.cpp
    ${BASE_DIR}/pub_facility/util_func/tsd_util_func.cpp
    ${BASE_DIR}/pub_facility/util_func/tsd_sha256.cpp
    ${BASE_DIR}/basic_component/device_comm/device_comm.cpp
    ${BASE_DIR}/basic_component/device_comm/hdc_client.cpp
    ${BASE_DIR}/basic_component/message_builder/hdc_message_builder.cpp
    ${BASE_DIR}/common/src/message_parse_client.cpp
    ${BASE_DIR}/common/src/version_verify.cpp
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
    ${BASE_DIR}/interface/tsd_client.cpp
    src/client_manager.cpp
    src/process_mode_manager.cpp
    src/process_mode_base.cpp
    src/process_mode_msg_parse.cpp
    src/plugin_pkg_version.cpp
    src/thread_mode_manager.cpp
    ${BASE_DIR}/pub_facility/env_manager/env_internal_api.cpp
    ${BASE_DIR}/common/src/package_worker.cpp
    ${BASE_DIR}/common/src/package_worker_utils.cpp
    ${BASE_DIR}/common/src/package_worker_factory.cpp
    ${BASE_DIR}/common/src/package_verify.cpp
    ${BASE_DIR}/common/src/base_package_worker.cpp
    ${BASE_DIR}/common/src/aicpu_thread_package_worker.cpp
    ${BASE_DIR}/common/src/aicpu_package_process.cpp
    ${BASE_DIR}/common/src/package_process_config.cpp
    ${BASE_DIR}/common/src/tsd_path_mgr.cpp
    $<$<NOT:$<OR:$<STREQUAL:${PRODUCT},ascend610>,$<STREQUAL:${PRODUCT},ascend610Lite>>>:${CMAKE_CURRENT_SOURCE_DIR}/src/stub/stub_dc.cpp>
    ${tdt_common_files}
    ${PROTO_SRCS}
    src/stub/stub_process_mode_nowin.cpp
)

add_dependencies(tsdclient tsd_host_proto)

target_include_directories(tsdclient PRIVATE
    ${CMAKE_CURRENT_SOURCE_DIR}/../common/
    ${CMAKE_CURRENT_SOURCE_DIR}
    ${CMAKE_BINARY_DIR}/proto/tsd_host_proto/
    ${CMAKE_CURRENT_SOURCE_DIR}/inc/
    ${RUNTIME_DIR}/include/
    ${RUNTIME_DIR}/src/tsd/
    ${RUNTIME_DIR}/src/tsd/pub_facility/tsdlog/
    ${RUNTIME_DIR}/src/tsd/pub_facility/util_func/
    ${RUNTIME_DIR}/src/tsd/pub_facility/env_manager/
    ${RUNTIME_DIR}/src/tsd/basic_component/device_comm/
    ${RUNTIME_DIR}/src/tsd/basic_component/message_builder/
    ${RUNTIME_DIR}/src/tsd/client/common/inc/
    ${RUNTIME_DIR}/src/tsd/client/common/inc/stub/
    ${RUNTIME_DIR}/src/inc/
    ${RUNTIME_DIR}/pkg_inc/profiling
    ${RUNTIME_DIR}/pkg_inc/platform
    ${RUNTIME_DIR}/src/dfx/error_manager/
    ${RUNTIME_DIR}/pkg_inc/aicpu_sched/
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
