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

include(${RUNTIME_DIR}/cmake/third_party/openssl.cmake)
include(${RUNTIME_DIR}/cmake/intf_pub_linux.cmake)

set(PROTO_LIST
    ${BASE_DIR}/common/proto/tsd_message.proto
)

set(tdt_common_files
    ${BASE_DIR}/common/src/hdc_common.cpp
    ${BASE_DIR}/common/src/log.cpp
    ${BASE_DIR}/common/src/message_parse_interface.cpp
    ${BASE_DIR}/common/src/internal_api.cpp
    ${BASE_DIR}/common/src/hdc_client.cpp
    ${BASE_DIR}/common/src/message_parse_client.cpp
    ${BASE_DIR}/common/src/version_verify.cpp
)

protobuf_generate(tsd_host_proto PROTO_SRCS PROTO_HDRS ${PROTO_LIST} TARGET)
    
if(${TARGET_SYSTEM_NAME} STREQUAL "Windows")
# windows
#######################################################################################################################
# libtsdclient.so windows
add_library(tsdclient SHARED
    src/tsd_client.cpp
    src/client_manager.cpp
    src/process_mode_manager.cpp
    src/process_mode_base.cpp
    src/process_mode_msg_parse.cpp
    src/stub/stub_process_mode_win.cpp
    src/thread_mode_manager.cpp
    src/aicpu_thread_mode_manager.cpp
    src/env_internal_api.cpp
    ${tdt_common_files}
    ${PROTO_SRCS}
)

add_dependencies(tsdclient tsd_host_proto)

target_include_directories(tsdclient PRIVATE
    ${CMAKE_CURRENT_SOURCE_DIR}/../common/
    ${CMAKE_CURRENT_SOURCE_DIR}/../tsdaemon/
    ${CMAKE_CURRENT_SOURCE_DIR}
    ${CMAKE_CURRENT_SOURCE_DIR}/inc/
    ${RUNTIME_DIR}/include/
    ${RUNTIME_DIR}/src/tsd/client/common/inc/
    ${RUNTIME_DIR}/src/tsd/client/common/inc/stub/
    ${RUNTIME_DIR}/pkg_in/aicpu/queue_schedule
    ${RUNTIME_DIR}/pkg_inc/profiling
    ${RUNTIME_DIR}/src/inc/
)

target_compile_options(tsdclient PRIVATE
    /utf-8
    $<$<STREQUAL:${CMAKE_CONFIGURATION_TYPES},Debug>:/MTd>
    $<$<STREQUAL:${CMAKE_CONFIGURATION_TYPES},Release>:/MT>
    $<$<STREQUAL:${ascend031},true>:TINY_RUNTIME>
)

target_compile_definitions(tsdclient PRIVATE
    TDT_HOST_LIB
    TSD_HOST_LIB
    NOT_COVERAGE_BY_UT
    WIN_TSD
    SECUREC_USING_STD_SECURE_LIB=0
    NOMINMAX
    google=ascend_private
    $<$<STREQUAL:${SUPPORT_IAM},true>:SUPPORT_IAM>
    $<$<STREQUAL:${TSD_DEPLOY_ON_HOST},true>:TSD_DEPLOY_ON_HOST>
)

target_link_options(tsdclient PRIVATE
    /FORCE:UNRESOLVED
)

target_link_libraries(tsdclient PRIVATE
    $<BUILD_INTERFACE:intf_pub_cxx17>
    -Wl,--no-as-needed
    ascend_protobuf_static
    c_sec
    mmpa
    ascend_hal_stub
    dl
    unified_dlog
    ascendalog
    -Wl,--as-needed
    error_manager
    crypto
    $<BUILD_INTERFACE:c_sec_headers>
)

set_target_properties(tsdclient
    PROPERTIES
    OUTPUT_NAME libtsdclient
)

#---------------------------------------------------------------------------------------------------linux
else()

set(host_tsd_src_files_tsd_client
    ${BASE_DIR}/common/src/domain_socket_common.cpp
    ${BASE_DIR}/common/src/domain_socket_client.cpp
)

set(host_tsd_include_files_tsd_client
    ${BASE_DIR}/common/src/domain_socket_common.h
    ${BASE_DIR}/common/src/domain_socket_client.h
)

# linux
#######################################################################################################################
# libtsdclient.so linux
add_library(tsdclient SHARED
    src/tsd_client.cpp
    src/client_manager.cpp
    src/process_mode_manager.cpp
    src/process_mode_base.cpp
    src/process_mode_msg_parse.cpp
    src/thread_mode_manager.cpp
    src/aicpu_thread_mode_manager.cpp
    src/env_internal_api.cpp
    ${BASE_DIR}/common/src/package_worker.cpp
    ${BASE_DIR}/common/src/package_worker_utils.cpp
    ${BASE_DIR}/common/src/package_worker_factory.cpp
    ${BASE_DIR}/common/src/package_verify.cpp
    ${BASE_DIR}/common/src/base_package_worker.cpp
    ${BASE_DIR}/common/src/runtime_package_worker.cpp
    ${BASE_DIR}/common/src/dshape_package_worker.cpp
    ${BASE_DIR}/common/src/om_package_worker.cpp
    ${BASE_DIR}/common/src/aicpu_process_package_worker.cpp
    ${BASE_DIR}/common/src/aicpu_thread_package_worker.cpp
    ${BASE_DIR}/common/src/aicpu_package_process.cpp
    ${BASE_DIR}/common/src/common_sink_package_worker.cpp
    ${BASE_DIR}/common/src/package_process_config.cpp
    ${BASE_DIR}/common/src/process_util_common.cpp
    ${BASE_DIR}/common/src/tsd_path_mgr.cpp
    ${BASE_DIR}/common/src/tsd_hash_verify.cpp
    $<$<NOT:$<OR:$<STREQUAL:${PRODUCT},ascend615>,$<STREQUAL:${PRODUCT},ascend610>,$<STREQUAL:${PRODUCT},ascend610Lite>>>:${CMAKE_CURRENT_SOURCE_DIR}/src/stub/stub_dc.cpp>
    ${tdt_common_files}
    ${PROTO_SRCS}
    ${host_tsd_src_files_tsd_client}
    src/stub/stub_process_mode_nowin.cpp
)

target_include_directories(tsdclient PRIVATE
    ${CMAKE_CURRENT_SOURCE_DIR}/../common/
    ${CMAKE_CURRENT_SOURCE_DIR}/../tsdaemon/
    ${CMAKE_CURRENT_SOURCE_DIR}
    ${CMAKE_BINARY_DIR}/proto/tsd_host_proto/
    ${CMAKE_CURRENT_SOURCE_DIR}/inc/
    ${RUNTIME_DIR}/include/
    ${RUNTIME_DIR}/src/tsd/
    ${RUNTIME_DIR}/src/tsd/client/common/inc/
    ${RUNTIME_DIR}/src/tsd/client/common/inc/stub/
    ${RUNTIME_DIR}/src/inc/
    ${RUNTIME_DIR}/pkg_inc/profiling
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
    $<$<STREQUAL:${SUPPORT_IAM},true>:SUPPORT_IAM>
    $<$<STREQUAL:${SUPPORT_SELINUX},true>:SUPPORT_SELINUX>
    CMSCBB_SUPPORT_RSAPSS=1
    CFG_FEATURE_PKCS_SIGN
    CFG_FEATURE_RSA_2048
    CFG_FEATURE_RSA_4096
    $<$<STREQUAL:${CMS_VERIFY_SIGNED_PKG},true>:CMS_VERIFY_SIGNED_PKG>
)

target_link_options(tsdclient PRIVATE
    -rdynamic
    -ldl
    -lrt
    -Wl,-Bsymbolic
    -Wl,--exclude-libs,ALL
)

target_link_libraries(tsdclient PRIVATE
    $<BUILD_INTERFACE:intf_pub_cxx17>
    -Wl,--no-as-needed
    ascend_protobuf_static
    c_sec 
    mmpa
    ascend_hal_stub
    dl
    unified_dlog
    -Wl,--as-needed
    error_manager
    crypto_static
    $<BUILD_INTERFACE:c_sec_headers>
)

endif()
